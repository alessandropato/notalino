import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

/// Costruisce i [ThemeData] light/dark a partire dai token (SRD §10bis.3).
/// Il tema è il ponte tra i token e i widget Material di base; i componenti
/// custom leggono comunque i token via `context.tokens`.
abstract final class AppTheme {
  static ThemeData light() => _build(AppTokens.light, Brightness.light);
  static ThemeData dark() => _build(AppTokens.dark, Brightness.dark);

  static ThemeData _build(AppTokens tokens, Brightness brightness) {
    final AppColors c = tokens.colors;
    final ColorScheme scheme = ColorScheme(
      brightness: brightness,
      primary: c.accentPrimary,
      onPrimary: Colors.white,
      secondary: c.accentSecondary,
      onSecondary: Colors.white,
      error: c.error,
      onError: Colors.white,
      surface: c.surface,
      onSurface: c.textPrimary,
    );

    final TextTheme textTheme = TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: c.textPrimary),
      titleLarge: AppTypography.titleLarge.copyWith(color: c.textPrimary),
      titleMedium: AppTypography.titleMedium.copyWith(color: c.textPrimary),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: c.textPrimary),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
      labelLarge: AppTypography.label.copyWith(color: c.textPrimary),
      labelMedium: AppTypography.label.copyWith(color: c.textSecondary),
      bodySmall: AppTypography.caption.copyWith(color: c.textTertiary),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: c.textPrimary,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: c.textPrimary),
      ),
      extensions: <ThemeExtension<dynamic>>[tokens],
    );
  }
}
