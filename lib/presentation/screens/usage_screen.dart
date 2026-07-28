import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/usage_record.dart';
import '../providers/data_providers.dart';
import '../widgets/widgets.dart';

/// Dashboard consumi (SRD §9, §10 schermata 7). Stima, non fattura reale.
class UsageScreen extends ConsumerWidget {
  const UsageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<UsageRecord>> usage = ref.watch(usageProvider);
    final AppTokens t = context.tokens;

    return AppScaffold(
      appBar: AppBar(title: const Text('Consumi')),
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

          final Map<UsageOperationType, double> byType =
              <UsageOperationType, double>{};
          for (final UsageRecord r in records) {
            byType[r.operationType] =
                (byType[r.operationType] ?? 0) + r.estimatedCostUsd;
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _TotalCard(
                      label: 'Mese corrente',
                      value: monthTotal,
                      highlight: true,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _TotalCard(label: 'Totale', value: allTotal),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionHeader(
                        title: 'Dettaglio per operazione', eyebrow: 'Breakdown'),
                    const SizedBox(height: AppSpacing.md),
                    _BreakdownRow(
                        label: 'Trascrizione',
                        value: byType[UsageOperationType.transcription] ?? 0),
                    _BreakdownRow(
                        label: 'Analisi',
                        value: byType[UsageOperationType.analysis] ?? 0),
                    _BreakdownRow(
                        label: 'Aggiornamento contesto',
                        value: byType[UsageOperationType.contextUpdate] ?? 0),
                    _BreakdownRow(
                        label: 'Q&A',
                        value: byType[UsageOperationType.qa] ?? 0),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'I valori sono una stima basata sulle tariffe impostate, non la fattura reale OpenAI.',
                style: AppTypography.caption
                    .copyWith(color: t.colors.textTertiary),
              ),
              if (records.isEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                const EmptyState(
                  icon: Icons.savings_outlined,
                  title: 'Nessun consumo ancora',
                  message: 'Qui vedrai la stima dei costi delle API OpenAI.',
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

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
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
