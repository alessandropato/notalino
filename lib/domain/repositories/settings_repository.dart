import '../../core/constants/pricing_constants.dart';

/// Impostazioni dell'app (SRD §5 implicito, §9, §12). La API key vive SOLO nel
/// secure storage (Keychain), mai nel DB. Le altre preferenze possono stare in
/// storage non sensibile.
abstract interface class SettingsRepository {
  // --- API key (secure storage) ---
  Future<String?> getApiKey();
  Future<void> setApiKey(String apiKey);
  Future<void> deleteApiKey();
  Future<bool> hasApiKey();

  /// Verifica la validità della chiave contro OpenAI (test connessione §10.6).
  Future<bool> testApiKey(String apiKey);

  // --- Modello chat ---
  Future<String> getChatModel();
  Future<void> setChatModel(String model);

  // --- Tariffe modificabili (SRD §9) ---
  Future<double> getWhisperPerMinuteUsd();
  Future<void> setWhisperPerMinuteUsd(double value);
  Future<ModelPricing> getChatPricing(String model);
  Future<void> setChatPricing(String model, ModelPricing pricing);
}
