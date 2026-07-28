import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../domain/entities/project.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../widgets/widgets.dart';
import 'new_meeting_screen.dart';
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(size: 26),
            const SizedBox(width: AppSpacing.sm),
            Text('Notalino',
                style: AppTypography.titleLarge
                    .copyWith(color: t.colors.textPrimary)),
          ],
        ),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: projects.when(
              loading: () => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppLogo(size: 88, color: t.colors.accentPrimary),
                    const SizedBox(height: AppSpacing.xl),
                    const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.4),
                    ),
                  ],
                ),
              ),
              error: (Object e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text('Errore nel caricamento: $e',
                      style: AppTypography.bodyMedium
                          .copyWith(color: t.colors.error)),
                ),
              ),
              data: (List<Project> list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: Icons.folder_special_outlined,
                    title: 'Inizia da qui',
                    message:
                        'Importa una riunione (audio o testo) o crea un progetto per organizzare i tuoi verbali.',
                    action: PrimaryButton(
                      label: 'Importa riunione',
                      icon: Icons.auto_awesome,
                      expand: false,
                      onPressed: () => _importMeeting(context),
                    ),
                  );
                }
                final Map<String, int> countMap = counts.value ?? const {};
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 120),
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
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
          ),
          // Barra azioni pinnata in basso.
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                      label: 'Importa riunione',
                      icon: Icons.auto_awesome,
                      onPressed: () => _importMeeting(context),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 2,
                    child: SecondaryButton(
                      label: 'Progetto',
                      icon: Icons.create_new_folder_outlined,
                      expand: true,
                      onPressed: () => _createProject(context, ref),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _importMeeting(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const NewMeetingScreen()),
      );

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
              boxShadow: t.glass.shadows,
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
                  meetingCount == 1 ? '1 riunione' : '$meetingCount riunioni',
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
