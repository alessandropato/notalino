import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../domain/entities/project.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../widgets/widgets.dart';
import 'project_detail_screen.dart';
import 'settings_screen.dart';
import 'usage_screen.dart';

/// Home / Progetti (SRD §10 schermata 1).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Project>> projects = ref.watch(projectsProvider);
    final AsyncValue<Map<String, int>> counts = ref.watch(meetingCountsProvider);
    final AppTokens t = context.tokens;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Notalino'),
        actions: [
          IconButton(
            tooltip: 'Consumi',
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const UsageScreen()),
            ),
          ),
          IconButton(
            tooltip: 'Impostazioni',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProject(context, ref),
        backgroundColor: t.colors.accentPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nuovo progetto'),
      ),
      body: projects.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text('Errore nel caricamento: $e',
                style: AppTypography.bodyMedium.copyWith(color: t.colors.error)),
          ),
        ),
        data: (List<Project> list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.folder_special_outlined,
              title: 'Nessun progetto',
              message:
                  'Crea il tuo primo progetto per organizzare le riunioni e ottenere verbali automatici.',
              action: PrimaryButton(
                label: 'Nuovo progetto',
                icon: Icons.add,
                expand: false,
                onPressed: () => _createProject(context, ref),
              ),
            );
          }
          final Map<String, int> countMap = counts.valueOrNull ?? const {};
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 96),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (BuildContext context, int i) {
              final Project p = list[i];
              return _ProjectCard(
                project: p,
                meetingCount: countMap[p.id] ?? 0,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ProjectDetailScreen(projectId: p.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _createProject(BuildContext context, WidgetRef ref) async {
    final TextEditingController nameCtrl = TextEditingController();
    final bool? ok = await AppBottomSheet.show<bool>(
      context: context,
      builder: (BuildContext ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Nuovo progetto', eyebrow: 'Crea'),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: nameCtrl,
            label: 'Nome del progetto',
            hint: 'Es. Progetto Halligan',
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: 'Crea progetto',
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
    if (ok == true && nameCtrl.text.trim().isNotEmpty) {
      await ref
          .read(projectRepositoryProvider)
          .createProject(name: nameCtrl.text.trim());
      ref.invalidate(meetingCountsProvider);
    }
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.meetingCount,
    required this.onTap,
  });

  final Project project;
  final int meetingCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: t.colors.accentGradient,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: const Icon(Icons.folder_rounded, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name,
                    style: AppTypography.titleMedium
                        .copyWith(color: t.colors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(
                  meetingCount == 1
                      ? '1 riunione'
                      : '$meetingCount riunioni',
                  style: AppTypography.bodyMedium
                      .copyWith(color: t.colors.textSecondary),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: t.colors.textTertiary),
        ],
      ),
    );
  }
}
