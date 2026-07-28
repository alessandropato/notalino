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

/// Dettaglio progetto (SRD §6ter, §10 schermata 2): apre sul contesto.
/// Navigazione a due sezioni (Contesto, Riunioni) con barra in basso; il Q&A
/// ("Chiedi al progetto") è un popup, non una tab — app snella e intuitiva.
class ProjectDetailScreen extends ConsumerStatefulWidget {
  const ProjectDetailScreen({super.key, required this.projectId});
  final String projectId;

  @override
  ConsumerState<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Project?> project =
        ref.watch(projectProvider(widget.projectId));

    return AppScaffold(
      appBar: AppBar(
        title: Text(project.value?.name ?? 'Progetto',
            overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            tooltip: 'Carica riunione',
            icon: const Icon(Icons.add),
            onPressed: _loadMeeting,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _index,
              children: [
                _ContextTab(projectId: widget.projectId),
                _MeetingsTab(projectId: widget.projectId, onLoad: _loadMeeting),
              ],
            ),
          ),
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: _ChiediChatButton(onTap: _openQa),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SegmentedToggle<int>(
                    value: _index,
                    segments: const [
                      ToggleSegment(value: 0, label: 'Contesto', icon: Icons.auto_awesome_outlined),
                      ToggleSegment(value: 1, label: 'Riunioni', icon: Icons.event_note_outlined),
                    ],
                    onChanged: (i) => setState(() => _index = i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMeeting() => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => NewMeetingScreen(presetProjectId: widget.projectId),
        ),
      );

  void _openQa() => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: context.tokens.colors.overlayTint.withValues(alpha: 0.4),
        builder: (_) => _QaHub(projectId: widget.projectId),
      );
}

/// Pulsante flottante circolare "Chiedi al progetto" — icona chat moderna.
class _ChiediChatButton extends StatelessWidget {
  const _ChiediChatButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: t.colors.accentGradient,
            shape: BoxShape.circle,
            boxShadow: t.glass.shadows,
          ),
          child: const Icon(Icons.chat_bubble_rounded,
              size: 26, color: Colors.white),
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
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 160),
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(
                title: 'Contesto',
                trailing: GhostButton(
                  label: 'Modifica',
                  icon: Icons.edit_outlined,
                  onPressed: () =>
                      _editDescription(context, ref, project.value),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                (project.value?.description.trim().isNotEmpty ?? false)
                    ? project.value!.description
                    : 'Aggiungi il contesto del progetto.',
                style: AppTypography.bodyMedium.copyWith(
                  color: (project.value?.description.trim().isNotEmpty ?? false)
                      ? t.colors.textSecondary
                      : t.colors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        context$.when(
          loading: () => const Center(
              child: Padding(
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
                  MarkdownBody(
                    data: ctx.overviewMarkdown,
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
          const SectionHeader(title: 'Contesto'),
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
  const _MeetingsTab({required this.projectId, required this.onLoad});
  final String projectId;
  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Meeting>> meetings =
        ref.watch(projectMeetingsProvider(projectId));

    return meetings.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, _) => Center(child: Text('Errore: $e')),
      data: (List<Meeting> list) {
        if (list.isEmpty) {
          return EmptyState(
            icon: Icons.event_note_outlined,
            title: 'Nessuna riunione',
            message:
                'Carica la prima riunione (audio o testo): verrà trascritta e analizzata.',
            action: PrimaryButton(
              label: 'Carica riunione',
              icon: Icons.upload_file,
              expand: false,
              onPressed: onLoad,
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 160),
          itemCount: list.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (BuildContext context, int i) =>
              _MeetingCard(meeting: list[i]),
        );
      },
    );
  }
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

// ------------------- Q&A (popup) -------------------

/// Contenuto del popup "Chiedi al progetto": nuova domanda + cronologia.
class _QaHub extends ConsumerWidget {
  const _QaHub({required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTokens t = context.tokens;
    final AsyncValue<List<ProjectQAThread>> threads =
        ref.watch(qaThreadsProvider(projectId));

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (BuildContext context, ScrollController scroll) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: t.colors.textTertiary.withValues(alpha: 0.4),
                  borderRadius: AppRadii.rPill,
                ),
              ),
            ),
            const SectionHeader(
                title: 'Chiedi al progetto', eyebrow: 'Second brain'),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Nuova domanda',
              icon: Icons.add_comment_outlined,
              onPressed: () => _newThread(context, ref),
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: threads.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (Object e, _) => Center(child: Text('Errore: $e')),
                data: (List<ProjectQAThread> list) {
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        'Nessuna domanda ancora. Le risposte si basano sui recap delle riunioni.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyMedium
                            .copyWith(color: t.colors.textTertiary),
                      ),
                    );
                  }
                  return ListView.separated(
                    controller: scroll,
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (BuildContext context, int i) {
                      final ProjectQAThread thread = list[i];
                      return GlassCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                        onTap: () => _openThread(context, thread),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline,
                                size: 18, color: t.colors.accentPrimary),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(thread.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodyLarge
                                      .copyWith(color: t.colors.textPrimary)),
                            ),
                            Icon(Icons.chevron_right,
                                color: t.colors.textTertiary),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _newThread(BuildContext context, WidgetRef ref) async {
    final ProjectQAThread thread = await ref
        .read(qaRepositoryProvider)
        .createThread(projectId: projectId, title: 'Nuova domanda');
    if (!context.mounted) return;
    Navigator.of(context).pop(); // chiude il popup
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

  void _openThread(BuildContext context, ProjectQAThread thread) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
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
