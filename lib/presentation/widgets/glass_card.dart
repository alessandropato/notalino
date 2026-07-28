import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import 'glass_container.dart';

/// Card vetro standard (SRD §10bis.2): [GlassContainer] con padding e raggio
/// coerenti, opzionalmente toccabile.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.tinted = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      onTap: onTap,
      padding: padding,
      borderRadius: AppRadii.rLg,
      tinted: tinted,
      child: child,
    );
  }
}
