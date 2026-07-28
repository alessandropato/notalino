import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import 'glass_container.dart';

/// Bottom sheet in stile vetro (SRD §10bis.2).
abstract final class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) {
    final AppTokens t = context.tokens;
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: t.colors.overlayTint.withValues(alpha: 0.35),
      builder: (BuildContext ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
        ),
        child: SafeArea(
          top: false,
          child: GlassContainer(
            borderRadius: AppRadii.rXl,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: t.colors.textTertiary.withValues(alpha: 0.4),
                    borderRadius: AppRadii.rPill,
                  ),
                ),
                Builder(builder: builder),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
