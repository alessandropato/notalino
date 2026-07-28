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

/// Controllo segmentato glass (design system §10bis). Ogni segmento è un
/// `Expanded` (larghezza identica) e quello selezionato ha lo sfondo a pillola
/// con gradiente — nessun positioning manuale, sempre allineato e centrato.
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
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: t.colors.surface.withValues(alpha: 0.55),
        borderRadius: AppRadii.rPill,
        border: Border.all(color: t.colors.glassBorder),
      ),
      child: Row(
        children: segments.map((ToggleSegment<T> s) {
          final bool selected = s.value == value;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(s.value),
              child: AnimatedContainer(
                duration: AppMotion.base,
                curve: AppMotion.standard,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: selected ? t.colors.accentGradient : null,
                  borderRadius: AppRadii.rPill,
                  boxShadow: selected ? t.glass.shadows : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                    Flexible(
                      child: Text(
                        s.label,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.label.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              selected ? Colors.white : t.colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
