import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/qa.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../utils/status_ui.dart';
import '../widgets/widgets.dart';
import 'meeting_detail_screen.dart';
import 'new_meeting_screen.dart';
import 'qa_thread_screen.dart';

/// Dettaglio progetto (SRD §6ter, §10 schermata 2): apre sul contesto,
/// con aree Contesto / Riunioni / Chiedi al progetto.
class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({super.key, required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Project?> project = ref.watch(projectProvider(projectId));

    return DefaultTabController(
      length: 3,
      child: AppScaffold(
        appBar: AppBar(
          title: Text(project.value?.name ?? 'Progetto',
              overflow: TextOverflow.ellipsis),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Contesto'),
              Tab(text: 'Riunioni'),
              Tab(text: 'Chiedi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ContextTab(projectId: projectId),
            _MeetingsTab(projectId: projectId),
            _QaTab(projectId: projectId),
          ],
        ),
      ),
    );
  }
}

// ------------------- Contesto -------------------

class _ContextTab extends ConsumerWidget {
  const _ContextTab({required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProjectContext?> context$ =
        ref.watch(projectContextProvider(projectId));
    final AsyncValue<Project?> project = ref.watch(projectProvider(projectId));
    final AppTokens t = context.tokens;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Descrizione manuale (SRD §6ter).
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(
                title: 'Descrizione',
                eyebrow: 'Intento',
                trailing: GhostButton(
                  label: 'Modifica',
                  icon: Icons.edit_outlined,
                  onPressed: () => _editDescription(context, ref, project.value),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                (project.value?.description.trim().isNotEmpty ?? false)
                    ? project.value!.description
                    : 'Aggiungi una descrizione del progetto: verrà usata dall\'AI come intento.',
                style: AppTypography.bodyMedium.copyWith(
                  color: (project.value?.description.trim().isNotEmpty ??
                          false)
                      ? t.colors.textSecondary
                      : t.colors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Contesto AI (SRD §6ter, §8ter.2).
        context$.when(
          loading: () =>
              const Center(child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: CircularProgressIndicator())),
          error: (Object e, _) => Text('Errore: $e'),
          data: (ProjectContext? ctx) {
            if (ctx == null) {
              return const EmptyState(
                icon: Icons.auto_awesome_outlined,
                title: 'Contesto non ancora generato',
                message:
                    'Il contesto vivo del progetto viene generato dall\'AI al completamento della prima riunione.',
              );
            }
            return GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Markdown(
                    data: ctx.overviewMarkdown,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    styleSheet: MarkdownStyleSheet(
                      h1: AppTypography.titleLarge
                          .copyWith(color: t.colors.textPrimary),
                      h2: AppTypography.titleMedium
                          .copyWith(color: t.colors.textPrimary),
                      p: AppTypography.bodyLarge
                          .copyWith(color: t.colors.textSecondary),
                      listBullet: AppTypography.bodyLarge
                          .copyWith(color: t.colors.textSecondary),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Aggiornato il ${Formatters.date(ctx.updatedAt)}',
                      style: AppTypography.caption
                          .copyWith(color: t.colors.textTertiary)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _editDescription(
      BuildContext context, WidgetRef ref, Project? project) async {
    if (project == null) return;
    final TextEditingController ctrl =
        TextEditingController(text: project.description);
    final bool? ok = await AppBottomSheet.show<bool>(
      context: context,
      builder: (BuildContext ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Descrizione del progetto'),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(controller: ctrl, maxLines: 5, hint: 'Di cosa tratta…'),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
              label: 'Salva', onPressed: () => Navigator.of(ctx).pop(true)),
        ],
      ),
    );
    if (ok == true) {
      await ref
          .read(projectRepositoryProvider)
          .updateProject(project.copyWith(description: ctrl.text.trim()));
      ref.invalidate(projectProvider(projectId));
    }
  }
}

// ------------------- Riunioni -------------------

class _MeetingsTab extends ConsumerWidget {
  const _MeetingsTab({required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Meeting>> meetings =
        ref.watch(projectMeetingsProvider(projectId));

    return Stack(
      children: [
        meetings.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, _) => Center(child: Text('Errore: $e')),
          data: (List<Meeting> list) {
            if (list.isEmpty) {
              return EmptyState(
                icon: Icons.event_note_outlined,
                title: 'Nessuna riunione',
                message:
                    'Carica la prima riunione: una o più registrazioni verranno trascritte e analizzate.',
                action: PrimaryButton(
                  label: 'Carica riunione',
                  icon: Icons.upload_file,
                  expand: false,
                  onPressed: () => _newMeeting(context),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 96),
              itemCount: list.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (BuildContext context, int i) =>
                  _MeetingCard(meeting: list[i]),
            );
          },
        ),
        Positioned(
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: FloatingActionButton.extended(
            onPressed: () => _newMeeting(context),
            icon: const Icon(Icons.upload_file),
            label: const Text('Carica riunione'),
          ),
        ),
      ],
    );
  }

  void _newMeeting(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => NewMeetingScreen(presetProjectId: projectId),
        ),
      );
}

class _MeetingCard extends StatelessWidget {
  const _MeetingCard({required this.meeting});
  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final ({String label, StatusTone tone}) status =
        StatusUi.meeting(meeting.status);
    return GlassCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => MeetingDetailScreen(meetingId: meeting.id),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meeting.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleMedium
                        .copyWith(color: t.colors.textPrimary)),
                const SizedBox(height: 4),
                Text(Formatters.date(meeting.createdAt),
                    style: AppTypography.caption
                        .copyWith(color: t.colors.textTertiary)),
              ],
            ),
          ),
          StatusBadge(label: status.label, tone: status.tone),
        ],
      ),
    );
  }
}

// ------------------- Q&A -------------------

class _QaTab extends ConsumerWidget {
  const _QaTab({required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ProjectQAThread>> threads =
        ref.watch(qaThreadsProvider(projectId));

    return Stack(
      children: [
        threads.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object e, _) => Center(child: Text('Errore: $e')),
          data: (List<ProjectQAThread> list) {
            if (list.isEmpty) {
              return EmptyState(
                icon: Icons.forum_outlined,
                title: 'Chiedi al progetto',
                message:
                    'Poni domande in linguaggio naturale sull\'intero progetto. Le risposte si basano sui recap delle riunioni.',
                action: PrimaryButton(
                  label: 'Nuova domanda',
                  icon: Icons.add_comment_outlined,
                  expand: false,
                  onPressed: () => _newThread(context, ref),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 96),
              itemCount: list.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (BuildContext context, int i) {
                final ProjectQAThread thread = list[i];
                final AppTokens t = context.tokens;
                return GlassCard(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => QaThreadScreen(
                        projectId: projectId,
                        threadId: thread.id,
                        title: thread.title,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          color: t.colors.accentPrimary),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(thread.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodyLarge
                                .copyWith(color: t.colors.textPrimary)),
                      ),
                      Icon(Icons.chevron_right, color: t.colors.textTertiary),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: FloatingActionButton.extended(
            onPressed: () => _newThread(context, ref),
            icon: const Icon(Icons.add_comment_outlined),
            label: const Text('Nuova domanda'),
          ),
        ),
      ],
    );
  }

  Future<void> _newThread(BuildContext context, WidgetRef ref) async {
    final ProjectQAThread thread = await ref
        .read(qaRepositoryProvider)
        .createThread(projectId: projectId, title: 'Nuova domanda');
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QaThreadScreen(
          projectId: projectId,
          threadId: thread.id,
          title: thread.title,
        ),
      ),
    );
  }
}
