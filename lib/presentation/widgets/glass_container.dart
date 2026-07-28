import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';

/// Primitiva del materiale "vetro smerigliato" (SRD §10bis.2).
/// Incapsula il [BackdropFilter] + riempimento traslucido + bordo luminoso +
/// ombra, tutto derivato dai token. Ogni componente vetro nasce da qui, così il
/// look è coerente e modificabile da un punto solo.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.borderRadius = AppRadii.rLg,
    this.onTap,
    this.tinted = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  /// Se true, aggiunge una leggerissima tinta d'accento sotto il vetro.
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final Widget content = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: t.glass.shadows,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: t.glass.blurSigma,
            sigmaY: t.glass.blurSigma,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: t.colors.glassSurface,
              borderRadius: borderRadius,
              border: Border.all(
                color: t.colors.glassBorder,
                width: t.glass.borderWidth,
              ),
              gradient: tinted
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        t.colors.accentPrimary.withValues(alpha: 0.06),
                        t.colors.overlayTint,
                      ],
                    )
                  : null,
            ),
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: content,
      ),
    );
  }
}
