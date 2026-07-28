import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Intestazione di sezione con eyebrow opzionale (SRD §10bis.2).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.trailing,
  });

  final String title;
  final String? eyebrow;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null)
                Text(
                  eyebrow!.toUpperCase(),
                  style: AppTypography.label.copyWith(
                    color: t.colors.accentPrimary,
                    letterSpacing: 1.2,
                  ),
                ),
              Text(
                title,
                style:
                    AppTypography.titleMedium.copyWith(color: t.colors.textPrimary),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
