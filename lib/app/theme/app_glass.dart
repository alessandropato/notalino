import 'package:flutter/widgets.dart';

/// Parametri del materiale "vetro smerigliato" (SRD §10bis.1).
/// Incapsulati qui e consumati esclusivamente da [GlassContainer], così che
/// tutti i componenti vetro siano coerenti e modificabili da un punto solo.
@immutable
class AppGlass {
  const AppGlass({
    required this.blurSigma,
    required this.borderWidth,
    required this.shadows,
  });

  /// Intensità del BackdropFilter (SRD suggerisce sigma 18-24).
  final double blurSigma;
  final double borderWidth;

  /// Ombra esterna morbida e diffusa (elevazione, SRD §10bis.1).
  final List<BoxShadow> shadows;

  static const AppGlass light = AppGlass(
    blurSigma: 20,
    borderWidth: 1,
    shadows: [
      BoxShadow(
        color: Color(0x140A2540), // #0A2540 ~8%
        blurRadius: 24,
        offset: Offset(0, 8),
      ),
    ],
  );

  static const AppGlass dark = AppGlass(
    blurSigma: 22,
    borderWidth: 1,
    shadows: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 28,
        offset: Offset(0, 10),
      ),
    ],
  );

  AppGlass lerpTo(AppGlass other, double t) => AppGlass(
        blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
        borderWidth: borderWidth + (other.borderWidth - borderWidth) * t,
        shadows: t < 0.5 ? shadows : other.shadows,
      );
}
