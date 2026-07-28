import '../../core/constants/pricing_constants.dart';

/// Stima dei costi OpenAI (SRD §9). Logica pura, testabile. Le tariffe sono
/// parametri (provengono dalle impostazioni), non costanti hardcoded qui.
abstract final class CostEstimator {
  /// Costo di una trascrizione Whisper dato l'audio in secondi.
  static double transcription({
    required int audioSeconds,
    required double whisperPerMinuteUsd,
  }) {
    final double minutes = audioSeconds / 60.0;
    return minutes * whisperPerMinuteUsd;
  }

  /// Costo di una chiamata chat dato il consumo di token.
  static double chat({
    required int inputTokens,
    required int outputTokens,
    required ModelPricing pricing,
  }) {
    final double input = inputTokens / 1000000.0 * pricing.inputPerMillionUsd;
    final double output = outputTokens / 1000000.0 * pricing.outputPerMillionUsd;
    return input + output;
  }
}
