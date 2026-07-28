import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/openai_constants.dart';
import '../../core/constants/pricing_constants.dart';
import '../../domain/repositories/settings_repository.dart';

/// Implementazione delle impostazioni (SRD §9, §12).
/// La API key vive SOLO nel secure storage (Keychain iOS / Keystore Android),
/// mai in DB, log o SharedPreferences. Le altre preferenze (non sensibili)
/// stanno anch'esse nel secure storage per non introdurre un secondo store.
class SecureSettingsRepository implements SettingsRepository {
  SecureSettingsRepository({FlutterSecureStorage? storage, Dio? dio})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            ),
        _dio = dio ?? Dio();

  final FlutterSecureStorage _storage;
  final Dio _dio;

  static const String _kApiKey = 'openai_api_key';
  static const String _kChatModel = 'chat_model';
  static const String _kWhisperRate = 'whisper_per_minute_usd';
  static String _kChatInput(String m) => 'chat_input_$m';
  static String _kChatOutput(String m) => 'chat_output_$m';

  // ---------------- API key ----------------

  @override
  Future<String?> getApiKey() => _storage.read(key: _kApiKey);

  @override
  Future<void> setApiKey(String apiKey) =>
      _storage.write(key: _kApiKey, value: apiKey.trim());

  @override
  Future<void> deleteApiKey() => _storage.delete(key: _kApiKey);

  @override
  Future<bool> hasApiKey() async {
    final String? key = await getApiKey();
    return key != null && key.trim().isNotEmpty;
  }

  @override
  Future<bool> testApiKey(String apiKey) async {
    try {
      final Response<dynamic> res = await _dio.get<dynamic>(
        '${OpenAiConstants.baseUrl}${OpenAiConstants.modelsPath}',
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer ${apiKey.trim()}',
          },
          validateStatus: (int? s) => s != null && s < 500,
        ),
      );
      return res.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  // ---------------- Modello ----------------

  @override
  Future<String> getChatModel() async =>
      await _storage.read(key: _kChatModel) ?? OpenAiConstants.defaultChatModel;

  @override
  Future<void> setChatModel(String model) =>
      _storage.write(key: _kChatModel, value: model);

  // ---------------- Tariffe ----------------

  @override
  Future<double> getWhisperPerMinuteUsd() async {
    final String? raw = await _storage.read(key: _kWhisperRate);
    return raw == null
        ? PricingConstants.whisperPerMinuteUsd
        : (double.tryParse(raw) ?? PricingConstants.whisperPerMinuteUsd);
  }

  @override
  Future<void> setWhisperPerMinuteUsd(double value) =>
      _storage.write(key: _kWhisperRate, value: value.toString());

  @override
  Future<ModelPricing> getChatPricing(String model) async {
    final ModelPricing fallback = PricingConstants.pricingForModel(model);
    final String? input = await _storage.read(key: _kChatInput(model));
    final String? output = await _storage.read(key: _kChatOutput(model));
    return ModelPricing(
      inputPerMillionUsd:
          input == null ? fallback.inputPerMillionUsd : (double.tryParse(input) ?? fallback.inputPerMillionUsd),
      outputPerMillionUsd:
          output == null ? fallback.outputPerMillionUsd : (double.tryParse(output) ?? fallback.outputPerMillionUsd),
    );
  }

  @override
  Future<void> setChatPricing(String model, ModelPricing pricing) async {
    await _storage.write(
        key: _kChatInput(model), value: pricing.inputPerMillionUsd.toString());
    await _storage.write(
        key: _kChatOutput(model), value: pricing.outputPerMillionUsd.toString());
  }
}
