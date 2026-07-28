import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Bottoni dell'app (SRD §10bis.2), tutti derivati dai token e con stati
/// normale/premuto/disabilitato/loading.

enum _ButtonKind { primary, secondary, ghost }

class _BaseButton extends StatelessWidget {
  const _BaseButton({
    required this.label,
    required this.onPressed,
    required this.kind,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final _ButtonKind kind;
  final IconData? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final bool disabled = onPressed == null || loading;

    final Widget content = loading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                kind == _ButtonKind.primary
                    ? Colors.white
                    : t.colors.accentPrimary,
              ),
            ),
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  style: AppTypography.label.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    switch (kind) {
      case _ButtonKind.primary:
        return Opacity(
          opacity: disabled ? 0.5 : 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: t.colors.accentGradient,
              borderRadius: AppRadii.rMd,
              boxShadow: disabled ? null : t.glass.shadows,
            ),
            child: _tappable(context, content, Colors.white, disabled),
          ),
        );
      case _ButtonKind.secondary:
        return Opacity(
          opacity: disabled ? 0.5 : 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: t.colors.accentPrimary.withValues(alpha: 0.12),
              borderRadius: AppRadii.rMd,
              border: Border.all(
                color: t.colors.accentPrimary.withValues(alpha: 0.35),
              ),
            ),
            child: _tappable(context, content, t.colors.accentPrimary, disabled),
          ),
        );
      case _ButtonKind.ghost:
        return Opacity(
          opacity: disabled ? 0.5 : 1,
          child: _tappable(context, content, t.colors.accentPrimary, disabled),
        );
    }
  }

  Widget _tappable(
    BuildContext context,
    Widget content,
    Color foreground,
    bool disabled,
  ) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppRadii.rMd,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        borderRadius: AppRadii.rMd,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md + 2,
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: foreground),
            child: IconTheme.merge(
              data: IconThemeData(color: foreground),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) => _BaseButton(
        label: label,
        onPressed: onPressed,
        kind: _ButtonKind.primary,
        icon: icon,
        loading: loading,
        expand: expand,
      );
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) => _BaseButton(
        label: label,
        onPressed: onPressed,
        kind: _ButtonKind.secondary,
        icon: icon,
        loading: loading,
        expand: expand,
      );
}

class GhostButton extends StatelessWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) => _BaseButton(
        label: label,
        onPressed: onPressed,
        kind: _ButtonKind.ghost,
        icon: icon,
        loading: loading,
      );
}
