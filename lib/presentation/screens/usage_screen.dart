import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/usage_record.dart';
import '../providers/data_providers.dart';
import '../widgets/widgets.dart';

/// Consumi (SRD §9): quanto hai speso questo mese e in totale, con il dettaglio
/// per modello. Semplice, senza fronzoli.
class UsageScreen extends ConsumerWidget {
  const UsageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UsageRecord>> usage = ref.watch(usageProvider);

    return AppScaffold(
      appBar: AppBar(title: const Text('Spesa')),
      body: usage.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, _) => Center(child: Text('Errore: $e')),
        data: (List<UsageRecord> records) {
          final DateTime now = DateTime.now();
          final DateTime monthStart = DateTime(now.year, now.month);
          final double monthTotal = records
              .where((UsageRecord r) => !r.timestamp.isBefore(monthStart))
              .fold<double>(0, (double s, UsageRecord r) => s + r.estimatedCostUsd);
          final double allTotal = records.fold<double>(
              0, (double s, UsageRecord r) => s + r.estimatedCostUsd);

          // Dettaglio per modello (Whisper incluso come "whisper-1").
          final Map<String, double> byModel = <String, double>{};
          for (final UsageRecord r in records) {
            byModel[r.model] = (byModel[r.model] ?? 0) + r.estimatedCostUsd;
          }
          final List<MapEntry<String, double>> models = byModel.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _TotalCard(
                        label: 'Questo mese',
                        value: monthTotal,
                        highlight: true),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                      child: _TotalCard(label: 'Totale', value: allTotal)),
                ],
              ),
              if (models.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionHeader(
                          title: 'Per modello', eyebrow: 'Dettaglio'),
                      const SizedBox(height: AppSpacing.md),
                      for (final MapEntry<String, double> m in models)
                        _ModelRow(model: m.key, value: m.value),
                    ],
                  ),
                ),
              ],
              if (records.isEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const EmptyState(
                  icon: Icons.savings_outlined,
                  title: 'Ancora nessuna spesa',
                  message: 'Qui vedrai quanto spendi in API OpenAI.',
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final double value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return GlassCard(
      tinted: highlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  AppTypography.label.copyWith(color: t.colors.textSecondary)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            Formatters.usd(value),
            style: AppTypography.displayLarge.copyWith(
              color: highlight ? t.colors.accentPrimary : t.colors.textPrimary,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({required this.model, required this.value});
  final String model;
  final double value;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(model,
                style: AppTypography.bodyLarge
                    .copyWith(color: t.colors.textSecondary)),
          ),
          Text(Formatters.usd(value),
              style: AppTypography.bodyLarge.copyWith(
                  color: t.colors.textPrimary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
