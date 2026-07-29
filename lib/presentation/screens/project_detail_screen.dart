import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/qa.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../utils/status_ui.dart';
import '../widgets/widgets.dart';
import 'meeting_detail_screen.dart';
import 'new_meeting_screen.dart';

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
    final AsyncValue<Project?> project = ref.watch(
      projectProvider(widget.projectId),
    );

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          project.value?.name ?? 'Progetto',
          overflow: TextOverflow.ellipsis,
        ),
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
                      ToggleSegment(
                        value: 0,
                        label: 'Contesto',
                        icon: Icons.auto_awesome_outlined,
                      ),
                      ToggleSegment(
                        value: 1,
                        label: 'Riunioni',
                        icon: Icons.event_note_outlined,
                      ),
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
          alignment: Alignment.center,
          child: const AppLogo(size: 30, color: Colors.white),
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
    final AsyncValue<ProjectContext?> context$ = ref.watch(
      projectContextProvider(projectId),
    );
    final AsyncValue<Project?> project = ref.watch(projectProvider(projectId));
    final AppTokens t = context.tokens;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        160,
      ),
      children: [
        GlassCard(
          onTap: () => _editDescription(context, ref, project.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(
                title: 'Contesto',
                trailing: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: t.colors.accentPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                (project.value?.description.trim().isNotEmpty ?? false)
                    ? project.value!.description
                    : 'Tocca per aggiungere informazioni sul progetto.',
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
              child: CircularProgressIndicator(),
            ),
          ),
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
                      h1: AppTypography.titleLarge.copyWith(
                        color: t.colors.textPrimary,
                      ),
                      h2: AppTypography.titleMedium.copyWith(
                        color: t.colors.textPrimary,
                      ),
                      p: AppTypography.bodyLarge.copyWith(
                        color: t.colors.textSecondary,
                      ),
                      listBullet: AppTypography.bodyLarge.copyWith(
                        color: t.colors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Aggiornato il ${Formatters.date(ctx.updatedAt)}',
                    style: AppTypography.caption.copyWith(
                      color: t.colors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _editDescription(
    BuildContext context,
    WidgetRef ref,
    Project? project,
  ) async {
    if (project == null) return;
    final TextEditingController ctrl = TextEditingController(
      text: project.description,
    );
    bool saving = false;
    String? error;

    await AppBottomSheet.show<void>(
      context: context,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setSheetState) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Contesto'),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'L\'AI lo integra nella scheda viva del progetto (non resta un testo a parte).',
              style: AppTypography.caption.copyWith(
                color: context.tokens.colors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: ctrl,
              maxLines: 5,
              hint: 'Di cosa tratta…',
              enabled: !saving,
            ),
            if (error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                error!,
                style: AppTypography.caption.copyWith(
                  color: context.tokens.colors.error,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Salva',
              loading: saving,
              onPressed: saving
                  ? null
                  : () async {
                      setSheetState(() {
                        saving = true;
                        error = null;
                      });
                      try {
                        await ref
                            .read(projectRepositoryProvider)
                            .updateProject(
                              project.copyWith(description: ctrl.text.trim()),
                            );
                        ref.invalidate(projectProvider(projectId));
                        // Integra il nuovo contesto nella scheda viva del
                        // progetto via AI (se ci sono già riunioni da cui
                        // partire); altrimenti la description resta come
                        // materiale grezzo finché non arriva la prima.
                        await ref
                            .read(updateProjectContextProvider)
                            .call(projectId);
                        if (ctx.mounted) Navigator.of(ctx).pop();
                      } catch (e) {
                        setSheetState(() {
                          saving = false;
                          error =
                              'Salvato, ma l\'integrazione AI nel contesto è fallita: '
                              '${e.toString().replaceFirst("Exception: ", "")}';
                        });
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Riunioni -------------------

class _MeetingsTab extends ConsumerWidget {
  const _MeetingsTab({required this.projectId, required this.onLoad});
  final String projectId;
  final VoidCallback onLoad;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Meeting>> meetings = ref.watch(
      projectMeetingsProvider(projectId),
    );

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
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            160,
          ),
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
    final ({String label, StatusTone tone}) status = StatusUi.meeting(
      meeting.status,
    );
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
                Text(
                  meeting.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.titleMedium.copyWith(
                    color: t.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Formatters.date(meeting.createdAt),
                  style: AppTypography.caption.copyWith(
                    color: t.colors.textTertiary,
                  ),
                ),
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

/// Popup "Chiedi al progetto": la chat si apre direttamente qui dentro, senza
/// navigare a un'altra schermata. Usa un'unica conversazione per progetto
/// (l'ultima o una nuova), così è immediato.
class _QaHub extends ConsumerStatefulWidget {
  const _QaHub({required this.projectId});
  final String projectId;

  @override
  ConsumerState<_QaHub> createState() => _QaHubState();
}

class _QaHubState extends ConsumerState<_QaHub> {
  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _threadId;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Riusa l'ultima conversazione del progetto, se esiste.
    Future<void>(() async {
      final List<ProjectQAThread> threads = await ref
          .read(qaRepositoryProvider)
          .getThreads(widget.projectId);
      if (mounted && threads.isNotEmpty) {
        setState(() => _threadId = threads.first.id);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final AsyncValue<List<ProjectQAMessage>>? messages = _threadId == null
        ? null
        : ref.watch(qaMessagesProvider(_threadId!));

    // Spinge l'intero foglio sopra la tastiera quando compare (altrimenti
    // copre il composer): il DraggableScrollableSheet da solo non ne tiene
    // conto, essendo dimensionato in frazioni dell'altezza disponibile.
    return AnimatedPadding(
      duration: AppMotion.fast,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (BuildContext context, ScrollController scroll) =>
            GlassContainer(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadii.xl),
              ),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: t.colors.textTertiary.withValues(alpha: 0.4),
                        borderRadius: AppRadii.rPill,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const AppLogo(size: 22),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Chiedi al progetto',
                          style: AppTypography.titleMedium.copyWith(
                            color: t.colors.textPrimary,
                          ),
                        ),
                      ),
                      if (_threadId != null)
                        IconButton(
                          tooltip: 'Nuova conversazione',
                          icon: Icon(
                            Icons.add_comment_outlined,
                            color: t.colors.textSecondary,
                          ),
                          onPressed: () => setState(() {
                            _threadId = null;
                            _error = null;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: (messages == null)
                        ? _emptyPrompt(t)
                        : messages.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (Object e, _) =>
                                Center(child: Text('Errore: $e')),
                            data: (List<ProjectQAMessage> list) {
                              if (list.isEmpty && !_sending) {
                                return _emptyPrompt(t);
                              }
                              return ListView(
                                controller: scroll,
                                children: [
                                  for (final ProjectQAMessage m in list)
                                    _bubble(t, m),
                                  if (_sending) _typing(t),
                                ],
                              );
                            },
                          ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Text(
                        _error!,
                        style: AppTypography.caption.copyWith(
                          color: t.colors.error,
                        ),
                      ),
                    ),
                  _composer(t),
                ],
              ),
            ),
      ),
    );
  }

  Widget _emptyPrompt(AppTokens t) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(
        'Fai una domanda sul progetto.\nEs. "Cosa avevamo deciso sul budget?"',
        textAlign: TextAlign.center,
        style: AppTypography.bodyMedium.copyWith(color: t.colors.textTertiary),
      ),
    ),
  );

  Widget _bubble(AppTokens t, ProjectQAMessage m) {
    final bool isUser = m.role == QaRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: isUser ? t.colors.accentGradient : null,
          color: isUser ? null : t.colors.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadii.lg),
            topRight: const Radius.circular(AppRadii.lg),
            bottomLeft: Radius.circular(isUser ? AppRadii.lg : AppRadii.sm),
            bottomRight: Radius.circular(isUser ? AppRadii.sm : AppRadii.lg),
          ),
          border: isUser ? null : Border.all(color: t.colors.glassBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              m.content,
              style: AppTypography.bodyLarge.copyWith(
                color: isUser ? Colors.white : t.colors.textPrimary,
              ),
            ),
            if (m.citedMeetingIds.isNotEmpty) _citations(t, m.citedMeetingIds),
          ],
        ),
      ),
    );
  }

  /// Riunioni citate nella risposta (SRD §8bis), in stile compatto.
  Widget _citations(AppTokens t, List<String> meetingIds) {
    final List<Meeting> all =
        ref.watch(projectMeetingsProvider(widget.projectId)).value ??
        const <Meeting>[];
    final List<Meeting> cited = all
        .where((Meeting m) => meetingIds.contains(m.id))
        .toList();
    if (cited.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Wrap(
        spacing: AppSpacing.xs,
        runSpacing: 2,
        children: [
          for (final Meeting m in cited)
            Text(
              '↳ ${m.title}',
              style: AppTypography.caption.copyWith(
                fontSize: 10,
                color: t.colors.textTertiary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _typing(AppTokens t) => Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: t.colors.surface.withValues(alpha: 0.6),
        borderRadius: AppRadii.rLg,
        border: Border.all(color: t.colors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(t.colors.accentPrimary),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            'Sto consultando i recap…',
            style: AppTypography.bodyMedium.copyWith(
              color: t.colors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _composer(AppTokens t) => SafeArea(
    top: false,
    child: Padding(
      // Il gap verso la tastiera è già gestito dall'AnimatedPadding attorno
      // all'intero foglio: qui basta un piccolo margine fisso.
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _ctrl,
              focusNode: _focusNode,
              autofocus: true,
              hint: 'Scrivi una domanda…',
              maxLines: 3,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: _sending ? null : _send,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: t.colors.accentGradient,
                shape: BoxShape.circle,
              ),
              child: _sending
                  ? const Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _send() async {
    final String question = _ctrl.text.trim();
    if (question.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    _ctrl.clear();
    try {
      // Crea la conversazione al primo messaggio.
      if (_threadId == null) {
        final String title = question.length > 60
            ? '${question.substring(0, 60)}…'
            : question;
        final ProjectQAThread thread = await ref
            .read(qaRepositoryProvider)
            .createThread(projectId: widget.projectId, title: title);
        if (!mounted) return;
        setState(() => _threadId = thread.id);
      }
      await ref
          .read(askProjectProvider)
          .ask(
            threadId: _threadId!,
            projectId: widget.projectId,
            question: question,
          );
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }
}
