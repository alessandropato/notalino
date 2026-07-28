/// Tariffe di default per la stima costi (SRD §9). Modificabili dall'utente in
/// Impostazioni (persistite nelle preferenze) — questi sono i valori iniziali.
/// La stima NON è la fattura reale OpenAI (chiarito in UI).
class ModelPricing {
  const ModelPricing({
    required this.inputPerMillionUsd,
    required this.outputPerMillionUsd,
  });

  /// USD per 1M token di input.
  final double inputPerMillionUsd;

  /// USD per 1M token di output.
  final double outputPerMillionUsd;
}

abstract final class PricingConstants {
  /// Whisper: tariffa al minuto di audio (SRD §9).
  static const double whisperPerMinuteUsd = 0.006;

  /// Tariffe GPT per modello (USD / 1M token). Valori di riferimento.
  static const Map<String, ModelPricing> chatPricing = <String, ModelPricing>{
    'gpt-4o': ModelPricing(inputPerMillionUsd: 2.50, outputPerMillionUsd: 10.00),
    'gpt-4o-mini':
        ModelPricing(inputPerMillionUsd: 0.15, outputPerMillionUsd: 0.60),
    'gpt-4.1': ModelPricing(inputPerMillionUsd: 2.00, outputPerMillionUsd: 8.00),
    'gpt-4.1-mini':
        ModelPricing(inputPerMillionUsd: 0.40, outputPerMillionUsd: 1.60),
  };

  /// Fallback se il modello non è in tabella.
  static const ModelPricing fallbackChatPricing =
      ModelPricing(inputPerMillionUsd: 2.50, outputPerMillionUsd: 10.00);

  static ModelPricing pricingForModel(String model) =>
      chatPricing[model] ?? fallbackChatPricing;
}
