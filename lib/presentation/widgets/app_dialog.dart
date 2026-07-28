import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import 'app_buttons.dart';
import 'glass_container.dart';

/// Dialog in stile vetro (SRD §10bis.2), con conferma/annulla.
abstract final class AppDialog {
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Conferma',
    String cancelLabel = 'Annulla',
    bool destructive = false,
  }) async {
    final AppTokens t = context.tokens;
    final bool? result = await showDialog<bool>(
      context: context,
      barrierColor: t.colors.overlayTint.withValues(alpha: 0.4),
      builder: (BuildContext ctx) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: GlassContainer(
            borderRadius: AppRadii.rXl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium
                      .copyWith(color: t.colors.textPrimary),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  style: AppTypography.bodyMedium
                      .copyWith(color: t.colors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: GhostButton(
                        label: cancelLabel,
                        onPressed: () => Navigator.of(ctx).pop(false),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        label: confirmLabel,
                        onPressed: () => Navigator.of(ctx).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return result ?? false;
  }
}
