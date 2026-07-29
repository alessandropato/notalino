import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Campo di testo dell'app (SRD §10bis.2), incluso il campo mascherato per la
/// API key (`obscure` + toggle di visibilità).
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.obscure = false,
    this.maxLines = 1,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
    this.prefixIcon,
    this.errorText,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;

  /// Campo mascherato (API key): mostra pallini + toggle occhio.
  final bool obscure;
  final int maxLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final IconData? prefixIcon;
  final String? errorText;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscure;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.label.copyWith(color: t.colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: t.colors.surface.withValues(alpha: 0.6),
            borderRadius: AppRadii.rMd,
            border: Border.all(
              color: widget.errorText != null
                  ? t.colors.error
                  : t.colors.glassBorder,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            obscureText: _obscured,
            maxLines: widget.obscure ? 1 : widget.maxLines,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            style: AppTypography.bodyLarge.copyWith(color: t.colors.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  AppTypography.bodyLarge.copyWith(color: t.colors.textTertiary),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md + 2,
              ),
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon, color: t.colors.textTertiary),
              suffixIcon: widget.obscure
                  ? IconButton(
                      icon: Icon(
                        _obscured
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: t.colors.textTertiary,
                      ),
                      onPressed: () => setState(() => _obscured = !_obscured),
                    )
                  : null,
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: AppTypography.caption.copyWith(color: t.colors.error),
          ),
        ],
      ],
    );
  }
}
