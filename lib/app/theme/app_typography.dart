import 'package:flutter/widgets.dart';

/// Scala tipografica con ruoli nominati (SRD §10bis.1). Nessuna dimensione
/// sparsa: si usano questi stili, colorati dai token in fase di tema.
///
/// Font: si usa la famiglia di sistema (SF Pro su iOS, Roboto su Android) per
/// leggibilità nativa e Dynamic Type. Se in futuro si adotta un display font
/// custom (es. Manrope), va aggiunto qui e negli asset.
abstract final class AppTypography {
  // I colori vengono applicati nel ThemeData; qui solo dimensione/peso/altezza.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    height: 40 / 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    height: 30 / 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 17,
    height: 24 / 17,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    height: 16 / 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
  );
}
