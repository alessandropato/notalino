import 'package:flutter/widgets.dart';

/// Token di colore (SRD §10bis.1). Fonte unica di verità: nessun colore
/// hardcoded nelle schermate. Ogni token ha la sua controparte dark.
///
/// Istanziato tramite [AppColors.light] / [AppColors.dark] e trasportato
/// nel tema via `AppTokens` (ThemeExtension).
@immutable
class AppColors {
  const AppColors({
    required this.background,
    required this.surface,
    required this.glassSurface,
    required this.glassBorder,
    required this.overlayTint,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accentPrimary,
    required this.accentPrimaryGradientEnd,
    required this.accentSecondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  // Superfici
  final Color background;
  final Color surface;
  final Color glassSurface;
  final Color glassBorder;
  final Color overlayTint;

  // Testo
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  // Accenti
  final Color accentPrimary;
  final Color accentPrimaryGradientEnd;
  final Color accentSecondary;

  // Semantici
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  /// Gradiente dell'azione principale (accento → variante chiara).
  LinearGradient get accentGradient => LinearGradient(
        colors: [accentPrimary, accentPrimaryGradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  /// Palette chiara — direzione fredda/pulita (SRD §10bis.1).
  static const AppColors light = AppColors(
    background: Color(0xFFF5F7FA),
    surface: Color(0xFFFFFFFF),
    // glassSurface e glassBorder includono già l'alpha del materiale vetro.
    glassSurface: Color(0xB3FFFFFF), // bianco ~70%
    glassBorder: Color(0x66FFFFFF), // bianco ~40%
    overlayTint: Color(0x0D0A2540), // #0A2540 ~5%
    textPrimary: Color(0xFF1C2733),
    textSecondary: Color(0xFF5A6B7B),
    textTertiary: Color(0xFF93A1AF),
    accentPrimary: Color(0xFF4C8DFF),
    accentPrimaryGradientEnd: Color(0xFF6FA8FF),
    accentSecondary: Color(0xFF7B8FF7),
    success: Color(0xFF3FBF8F),
    warning: Color(0xFFE8A13A),
    error: Color(0xFFE5675C),
    info: Color(0xFF4C8DFF),
  );

  /// Palette scura — controparte dei token (SRD §10bis.3).
  static const AppColors dark = AppColors(
    background: Color(0xFF0E141B),
    surface: Color(0xFF1A222C),
    glassSurface: Color(0x991F2A36), // superficie scura ~60%
    glassBorder: Color(0x33FFFFFF), // bianco ~20%
    overlayTint: Color(0x1A000000),
    textPrimary: Color(0xFFEAF0F6),
    textSecondary: Color(0xFF9FB0C0),
    textTertiary: Color(0xFF64748B),
    accentPrimary: Color(0xFF5C97FF),
    accentPrimaryGradientEnd: Color(0xFF7FB0FF),
    accentSecondary: Color(0xFF8B9DFF),
    success: Color(0xFF4FCF9F),
    warning: Color(0xFFF0B054),
    error: Color(0xFFF07A70),
    info: Color(0xFF5C97FF),
  );

  AppColors lerpTo(AppColors other, double t) {
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      background: c(background, other.background),
      surface: c(surface, other.surface),
      glassSurface: c(glassSurface, other.glassSurface),
      glassBorder: c(glassBorder, other.glassBorder),
      overlayTint: c(overlayTint, other.overlayTint),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      accentPrimary: c(accentPrimary, other.accentPrimary),
      accentPrimaryGradientEnd:
          c(accentPrimaryGradientEnd, other.accentPrimaryGradientEnd),
      accentSecondary: c(accentSecondary, other.accentSecondary),
      success: c(success, other.success),
      warning: c(warning, other.warning),
      error: c(error, other.error),
      info: c(info, other.info),
    );
  }
}
