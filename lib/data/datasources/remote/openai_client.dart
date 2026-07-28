import 'dart:async';

import 'package:dio/dio.dart';

import '../../../core/constants/openai_constants.dart';
import '../../../core/errors/app_exceptions.dart';

/// Factory del client OpenAI con interceptor di retry (backoff) e mappatura
/// degli errori in eccezioni tipizzate (SRD §3, §6.5).
class OpenAiClient {
  OpenAiClient({required this.apiKeyProvider, Dio? dio})
      : _dio = dio ?? Dio() {
    _dio.options
      ..baseUrl = OpenAiConstants.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(minutes: 5)
      ..sendTimeout = const Duration(minutes: 5);
    _dio.interceptors.add(_RetryInterceptor(_dio));
  }

  /// Fornisce la API key corrente (dal secure storage). Mai loggata.
  final Future<String?> Function() apiKeyProvider;
  final Dio _dio;

  Dio get dio => _dio;

  /// Header di autorizzazione; lancia [ApiKeyMissingException] se assente.
  Future<Options> authorizedOptions({String? contentType}) async {
    final String? key = await apiKeyProvider();
    if (key == null || key.trim().isEmpty) {
      throw const ApiKeyMissingException();
    }
    return Options(
      headers: <String, dynamic>{'Authorization': 'Bearer ${key.trim()}'},
      contentType: contentType,
    );
  }

  /// Converte un [DioException] nell'eccezione tipizzata appropriata.
  static Never mapError(DioException e) {
    final int? status = e.response?.statusCode;
    if (status == 401) throw const ApiKeyInvalidException();
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw NetworkException(
        'Errore di rete verso OpenAI: ${e.message ?? e.type.name}',
      );
    }
    final Object? data = e.response?.data;
    String message = 'OpenAI ha risposto con un errore';
    if (data is Map) {
      final Object? error = data['error'];
      if (error is Map && error['message'] is String) {
        message = error['message'] as String;
      }
    }
    throw OpenAiApiException(message, statusCode: status);
  }
}

/// Retry con backoff esponenziale per errori transitori (rete / 429 / 5xx).
class _RetryInterceptor extends Interceptor {
  _RetryInterceptor(this._dio);

  final Dio _dio;
  static const int maxRetries = 3;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final int attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;
    if (_shouldRetry(err) && attempt < maxRetries) {
      final int nextAttempt = attempt + 1;
      final Duration delay = Duration(milliseconds: 400 * (1 << attempt));
      await Future<void>.delayed(delay);
      final RequestOptions ro = err.requestOptions;
      ro.extra['retry_attempt'] = nextAttempt;
      try {
        final Response<dynamic> response = await _dio.fetch<dynamic>(ro);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    final int? status = err.response?.statusCode;
    if (status == 429) return true;
    if (status != null && status >= 500) return true;
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}
