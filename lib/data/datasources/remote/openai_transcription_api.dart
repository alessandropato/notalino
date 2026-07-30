import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/constants/openai_constants.dart';
import '../../../domain/services/transcription_service.dart';
import 'openai_client.dart';

/// Chiamata a Whisper per la trascrizione di un singolo file (SRD §3, §6.2).
/// `POST /v1/audio/transcriptions`, modello `whisper-1`.
class OpenAiTranscriptionApi {
  OpenAiTranscriptionApi(this._client);

  final OpenAiClient _client;

  /// Timeout dedicati e più generosi di quelli di default (SRD §6.5): la
  /// trascrizione di una riunione lunga richiede più tempo sia in upload sia
  /// in elaborazione lato server rispetto a una chat completion.
  static const Duration _receiveTimeout = Duration(minutes: 20);
  static const Duration _sendTimeout = Duration(minutes: 10);

  Future<TranscriptionResult> transcribe(String filePath) async {
    final Options options = await _client.authorizedOptions(
      contentType: 'multipart/form-data',
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
    );
    final FormData form = FormData.fromMap(<String, dynamic>{
      'model': OpenAiConstants.transcriptionModel,
      'response_format': 'verbose_json', // include lingua e durata
      'file': await MultipartFile.fromFile(
        filePath,
        filename: p.basename(filePath),
      ),
    });

    try {
      final Response<dynamic> res = await _client.dio.post<dynamic>(
        OpenAiConstants.transcriptionsPath,
        data: form,
        options: options,
      );
      final Map<String, dynamic> data =
          (res.data as Map).cast<String, dynamic>();
      final String text = (data['text'] as String?) ?? '';
      final String? language = data['language'] as String?;
      final num? duration = data['duration'] as num?;
      return TranscriptionResult(
        text: text.trim(),
        language: language,
        audioSeconds: duration?.round(),
      );
    } on DioException catch (e) {
      OpenAiClient.mapError(e);
    }
  }
}
