import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';

/// Un segmento del [SegmentedToggle].
class ToggleSegment<T> {
  const ToggleSegment({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}

/// Controllo segmentato in stile glass con "pillola" scorrevole animata
/// (design system §10bis). Selettore moderno per 2+ opzioni mutuamente esclusive.
class SegmentedToggle<T> extends StatelessWidget {
  const SegmentedToggle({
    super.key,
    required this.value,
    required this.segments,
    required this.onChanged,
  });

  final T value;
  final List<ToggleSegment<T>> segments;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final int index = segments.indexWhere((s) => s.value == value);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        final double segW = c.maxWidth / segments.length;
        return Container(
          height: 46,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: t.colors.surface.withValues(alpha: 0.55),
            borderRadius: AppRadii.rPill,
            border: Border.all(color: t.colors.glassBorder),
          ),
          child: Stack(
            children: [
              // Pillola selezionata, animata.
              AnimatedPositioned(
                duration: AppMotion.base,
                curve: AppMotion.standard,
                left: (index < 0 ? 0 : index) * (segW - 8 / segments.length),
                width: segW - 8,
                top: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: t.colors.accentGradient,
                    borderRadius: AppRadii.rPill,
                    boxShadow: t.glass.shadows,
                  ),
                ),
              ),
              Row(
                children: segments.map((ToggleSegment<T> s) {
                  final bool selected = s.value == value;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onChanged(s.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (s.icon != null) ...[
                            Icon(s.icon,
                                size: 16,
                                color: selected
                                    ? Colors.white
                                    : t.colors.textSecondary),
                            const SizedBox(width: AppSpacing.sm),
                          ],
                          Text(
                            s.label,
                            style: AppTypography.label.copyWith(
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : t.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
