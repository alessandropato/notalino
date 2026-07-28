import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Tonalità semantica di un badge di stato (SRD §10bis.1). Il mapping
/// status→tono vive nella presentazione (`status_ui.dart`), il badge conosce
/// solo la tonalità così resta disaccoppiato dal dominio.
enum StatusTone { neutral, info, success, warning, error }

/// Badge di stato (SRD §10bis.2). Colore derivato dai token via [StatusTone].
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.tone});

  final String label;
  final StatusTone tone;

  Color _color(AppColors c) => switch (tone) {
        StatusTone.neutral => c.textTertiary,
        StatusTone.info => c.info,
        StatusTone.success => c.success,
        StatusTone.warning => c.warning,
        StatusTone.error => c.error,
      };

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final Color color = _color(t.colors);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: AppRadii.rPill,
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
