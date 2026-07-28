import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Indicatore di avanzamento per elaborazioni lunghe (SRD §10bis.2):
/// "Trascrizione blocco 2 di 3…", "Registrazione 2 di 3".
class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.label,
    this.current,
    this.total,
  });

  final String label;
  final int? current;
  final int? total;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final double? value = (current != null && total != null && total! > 0)
        ? (current! / total!).clamp(0.0, 1.0)
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(t.colors.accentPrimary),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium
                    .copyWith(color: t.colors.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: AppRadii.rPill,
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: t.colors.textTertiary.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(t.colors.accentPrimary),
          ),
        ),
      ],
    );
  }
}
