import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/core/constants/pricing_constants.dart';
import 'package:notalino/domain/usecases/cost_estimator.dart';

/// Test della stima costi (SRD §9, §13).
void main() {
  group('CostEstimator.transcription', () {
    test('60 secondi a 0.006\$/min = 0.006\$', () {
      final double cost = CostEstimator.transcription(
        audioSeconds: 60,
        whisperPerMinuteUsd: 0.006,
      );
      expect(cost, closeTo(0.006, 1e-9));
    });

    test('un\'ora a 0.006\$/min = 0.36\$', () {
      final double cost = CostEstimator.transcription(
        audioSeconds: 3600,
        whisperPerMinuteUsd: 0.006,
      );
      expect(cost, closeTo(0.36, 1e-9));
    });

    test('zero secondi = 0', () {
      expect(
        CostEstimator.transcription(audioSeconds: 0, whisperPerMinuteUsd: 0.006),
        0,
      );
    });
  });

  group('CostEstimator.chat', () {
    test('1M input + 1M output con gpt-4o', () {
      const ModelPricing pricing =
          ModelPricing(inputPerMillionUsd: 2.50, outputPerMillionUsd: 10.00);
      final double cost = CostEstimator.chat(
        inputTokens: 1000000,
        outputTokens: 1000000,
        pricing: pricing,
      );
      expect(cost, closeTo(12.50, 1e-6));
    });

    test('token misti proporzionali', () {
      const ModelPricing pricing =
          ModelPricing(inputPerMillionUsd: 2.0, outputPerMillionUsd: 8.0);
      final double cost = CostEstimator.chat(
        inputTokens: 500000,
        outputTokens: 250000,
        pricing: pricing,
      );
      // 0.5*2 + 0.25*8 = 1 + 2 = 3
      expect(cost, closeTo(3.0, 1e-6));
    });
  });

  test('pricingForModel ritorna il fallback per modello sconosciuto', () {
    final ModelPricing p = PricingConstants.pricingForModel('modello-inesistente');
    expect(p.inputPerMillionUsd, PricingConstants.fallbackChatPricing.inputPerMillionUsd);
  });
}
