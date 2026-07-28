import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_glass.dart';

/// Bundle dei token che dipendono dal tema (colori + glass), trasportato nel
/// [ThemeData] come [ThemeExtension]. I token non-tematici (tipografia,
/// spaziatura, raggi, motion) sono costanti statiche nelle rispettive classi.
///
/// Accesso nelle schermate: `context.tokens` (vedi [AppTokensX]).
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({required this.colors, required this.glass});

  final AppColors colors;
  final AppGlass glass;

  static const AppTokens light =
      AppTokens(colors: AppColors.light, glass: AppGlass.light);
  static const AppTokens dark =
      AppTokens(colors: AppColors.dark, glass: AppGlass.dark);

  @override
  AppTokens copyWith({AppColors? colors, AppGlass? glass}) => AppTokens(
        colors: colors ?? this.colors,
        glass: glass ?? this.glass,
      );

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      colors: colors.lerpTo(other.colors, t),
      glass: glass.lerpTo(other.glass, t),
    );
  }
}

/// Zucchero sintattico: `context.tokens.colors.accentPrimary`.
extension AppTokensX on BuildContext {
  AppTokens get tokens =>
      Theme.of(this).extension<AppTokens>() ?? AppTokens.light;
}
