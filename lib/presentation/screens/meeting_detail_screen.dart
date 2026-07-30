import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/audio_constants.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_markdown.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/recording.dart';
import '../../domain/entities/transcript.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../providers/meeting_processing_controller.dart';
import '../utils/status_ui.dart';
import '../widgets/widgets.dart';

/// Dettaglio riunione (SRD §6.4, §10 schermata 4): verbale, trascrizione,
/// registrazioni con aggiunta/riordino/rimozione e banner di stato.
class MeetingDetailScreen extends ConsumerWidget {
  const MeetingDetailScreen({super.key, required this.meetingId});

  final String meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Meeting?> meeting = ref.watch(meetingProvider(meetingId));

    return meeting.when(
      loading: () => const AppScaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (Object e, _) =>
          AppScaffold(body: Center(child: Text('Errore: $e'))),
      data: (Meeting? m) {
        if (m == null) {
          return const AppScaffold(
            body: Center(child: Text('Riunione non trovata')),
          );
        }
        return _MeetingDetailBody(meeting: m);
      },
    );
  }
}

class _MeetingDetailBody extends ConsumerWidget {
  const _MeetingDetailBody({required this.meeting});
  final Meeting meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProcessingState processing =
        ref.watch(meetingProcessingProvider(meeting.id));
    final AppTokens t = context.tokens;
    final ({String label, StatusTone tone}) status =
        StatusUi.meeting(meeting.status);

    return DefaultTabController(
      length: 3,
      child: AppScaffold(
        appBar: AppBar(
          title: Text(meeting.title, overflow: TextOverflow.ellipsis),
          actions: [
            IconButton(
              tooltip: 'Rinomina',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _rename(context, ref),
            ),
            PopupMenuButton<String>(
              onSelected: (String v) => _onMenu(context, ref, v),
              itemBuilder: (_) => const [
                PopupMenuItem<String>(
                    value: 'share', child: Text('Esporta verbale (Markdown)')),
                PopupMenuItem<String>(
                    value: 'reanalyze', child: Text('Rigenera verbale')),
                PopupMenuItem<String>(
                    value: 'delete', child: Text('Elimina riunione')),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Verbale'),
              Tab(text: 'Trascrizione'),
              Tab(text: 'Registrazioni'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Banner di stato / avanzamento / errore.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
              child: Row(
                children: [
                  StatusBadge(label: status.label, tone: status.tone),
                  const Spacer(),
                  Text(Formatters.date(meeting.createdAt),
                      style: AppTypography.caption
                          .copyWith(color: t.colors.textTertiary)),
                ],
              ),
            ),
            _Banners(meeting: meeting, processing: processing),
            Expanded(
              child: TabBarView(
                children: [
                  _VerbaleTab(meetingId: meeting.id),
                  _TrascrizioneTab(meetingId: meeting.id),
                  _RegistrazioniTab(meeting: meeting),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final TextEditingController ctrl =
        TextEditingController(text: meeting.title);
    final bool? ok = await AppBottomSheet.show<bool>(
      context: context,
      builder: (BuildContext ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Rinomina riunione'),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(controller: ctrl, label: 'Titolo'),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
              label: 'Salva', onPressed: () => Navigator.of(ctx).pop(true)),
        ],
      ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      await ref
          .read(meetingRepositoryProvider)
          .updateMeeting(meeting.copyWith(title: ctrl.text.trim()));
    }
  }

  Future<void> _onMenu(
      BuildContext context, WidgetRef ref, String action) async {
    switch (action) {
      case 'share':
        final MeetingMarkdown? md =
            await ref.read(meetingRepositoryProvider).getMarkdown(meeting.id);
        if (md == null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Il verbale non è ancora disponibile.')));
          }
          return;
        }
        await SharePlus.instance.share(
          ShareParams(text: md.contentMarkdown, subject: meeting.title),
        );
      case 'reanalyze':
        unawaited(
            ref.read(meetingProcessingProvider(meeting.id).notifier).process());
      case 'delete':
        final bool confirm = await AppDialog.confirm(
          context: context,
          title: 'Eliminare la riunione?',
          message: 'L\'operazione è irreversibile.',
          confirmLabel: 'Elimina',
          destructive: true,
        );
        if (confirm) {
          await ref.read(meetingRepositoryProvider).deleteMeeting(meeting.id);
          if (context.mounted) Navigator.of(context).pop();
        }
    }
  }
}

class _Banners extends ConsumerWidget {
  const _Banners({required this.meeting, required this.processing});
  final Meeting meeting;
  final ProcessingState processing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTokens t = context.tokens;
    final List<Widget> banners = [];

    if (processing.isBusy) {
      banners.add(GlassCard(
        tinted: true,
        child: StepProgressIndicator(
          label: processing.label,
          current: processing.current,
          total: processing.total,
        ),
      ));
    }

    if (meeting.needsReanalysis && !processing.isBusy) {
      banners.add(GlassCard(
        child: Row(
          children: [
            Icon(Icons.sync_problem_outlined, color: t.colors.warning),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Le registrazioni sono cambiate: rigenera il verbale.',
                style: AppTypography.bodyMedium
                    .copyWith(color: t.colors.textSecondary),
              ),
            ),
            GhostButton(
              label: 'Rigenera',
              onPressed: () => ref
                  .read(meetingProcessingProvider(meeting.id).notifier)
                  .process(),
            ),
          ],
        ),
      ));
    }

    if (meeting.status == MeetingStatus.failed &&
        processing.phase != ProcessingPhase.transcribing &&
        processing.phase != ProcessingPhase.analyzing) {
      final String errorText = meeting.errorMessage ?? 'Elaborazione fallita.';
      banners.add(GlassCard(
        onTap: () => AppDialog.info(
          context: context,
          title: 'Dettaglio errore',
          message: errorText,
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: t.colors.error),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    errorText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium
                        .copyWith(color: t.colors.textSecondary),
                  ),
                  Text(
                    'Tocca per i dettagli',
                    style: AppTypography.caption
                        .copyWith(color: t.colors.textTertiary),
                  ),
                ],
              ),
            ),
            GhostButton(
              label: 'Riprova',
              onPressed: () => ref
                  .read(meetingProcessingProvider(meeting.id).notifier)
                  .process(),
            ),
          ],
        ),
      ));
    }

    if (banners.isEmpty) return const SizedBox(height: AppSpacing.sm);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
      child: Column(
        children: [
          for (final Widget b in banners) ...[
            b,
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _VerbaleTab extends ConsumerWidget {
  const _VerbaleTab({required this.meetingId});
  final String meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<MeetingMarkdown?> md =
        ref.watch(markdownProvider(meetingId));
    final AppTokens t = context.tokens;

    return md.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, _) => Center(child: Text('Errore: $e')),
      data: (MeetingMarkdown? m) {
        if (m == null) {
          return const EmptyState(
            icon: Icons.description_outlined,
            title: 'Verbale non disponibile',
            message:
                'Il verbale verrà generato al termine di trascrizione e analisi.',
          );
        }
        return Markdown(
          data: m.contentMarkdown,
          padding: const EdgeInsets.all(AppSpacing.lg),
          styleSheet: MarkdownStyleSheet(
            h1: AppTypography.titleLarge.copyWith(color: t.colors.textPrimary),
            h2: AppTypography.titleMedium.copyWith(color: t.colors.textPrimary),
            p: AppTypography.bodyLarge.copyWith(color: t.colors.textSecondary),
            listBullet:
                AppTypography.bodyLarge.copyWith(color: t.colors.textSecondary),
            strong: AppTypography.bodyLarge.copyWith(
                color: t.colors.textPrimary, fontWeight: FontWeight.w700),
          ),
        );
      },
    );
  }
}

class _TrascrizioneTab extends ConsumerWidget {
  const _TrascrizioneTab({required this.meetingId});
  final String meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Transcript?> transcript =
        ref.watch(transcriptProvider(meetingId));
    final AppTokens t = context.tokens;

    return transcript.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, _) => Center(child: Text('Errore: $e')),
      data: (Transcript? tr) {
        if (tr == null || tr.fullText.trim().isEmpty) {
          return const EmptyState(
            icon: Icons.text_snippet_outlined,
            title: 'Trascrizione non disponibile',
            message: 'Comparirà qui al termine della trascrizione.',
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SelectableText(
            tr.fullText,
            style: AppTypography.bodyLarge.copyWith(color: t.colors.textSecondary),
          ),
        );
      },
    );
  }
}

class _RegistrazioniTab extends ConsumerWidget {
  const _RegistrazioniTab({required this.meeting});
  final Meeting meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Recording>> recordings =
        ref.watch(recordingsProvider(meeting.id));

    return recordings.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, _) => Center(child: Text('Errore: $e')),
      data: (List<Recording> list) => Column(
        children: [
          Expanded(
            child: list.isEmpty
                ? const EmptyState(
                    icon: Icons.mic_none_outlined,
                    title: 'Nessuna registrazione',
                    message: 'Aggiungi almeno una registrazione audio.',
                  )
                : ReorderableListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: list.length,
                    // onReorderItem: newIndex già aggiustato per l'elemento rimosso.
                    onReorderItem: (int oldIndex, int newIndex) async {
                      final List<Recording> reordered =
                          List<Recording>.from(list);
                      final Recording moved = reordered.removeAt(oldIndex);
                      reordered.insert(newIndex, moved);
                      await ref.read(meetingRepositoryProvider).reorderRecordings(
                            meeting.id,
                            reordered.map((Recording r) => r.id).toList(),
                          );
                      await _markReanalysis(ref);
                    },
                    itemBuilder: (BuildContext context, int i) => Padding(
                      key: ValueKey<String>(list[i].id),
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: _RecordingCard(
                        recording: list[i],
                        onDelete: () => _deleteRecording(context, ref, list[i]),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SecondaryButton(
              label: 'Aggiungi registrazione',
              icon: Icons.add,
              expand: true,
              onPressed: () => _addRecording(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addRecording(BuildContext context, WidgetRef ref) async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: AudioConstants.importableExtensions,
      allowMultiple: true,
    );
    if (result == null) return;
    final List<String> paths =
        result.files.map((PlatformFile f) => f.path).whereType<String>().toList();
    if (paths.isEmpty) return;
    await ref
        .read(importRecordingsProvider)
        .addToMeeting(meetingId: meeting.id, sourceFilePaths: paths);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Registrazione aggiunta. Rigenera il verbale per includerla.')));
    }
  }

  Future<void> _deleteRecording(
      BuildContext context, WidgetRef ref, Recording rec) async {
    final bool confirm = await AppDialog.confirm(
      context: context,
      title: 'Eliminare la registrazione?',
      message: rec.sourceFileName,
      confirmLabel: 'Elimina',
      destructive: true,
    );
    if (!confirm) return;
    await ref.read(meetingRepositoryProvider).deleteRecording(rec.id);
    await ref.read(fileStoreProvider).deleteRecordingFile(rec.localFilePath);
    await _markReanalysis(ref);
  }

  Future<void> _markReanalysis(WidgetRef ref) async {
    if (meeting.status == MeetingStatus.completed) {
      await ref.read(meetingRepositoryProvider).updateMeeting(
            meeting.copyWith(needsReanalysis: true),
          );
    }
  }
}

class _RecordingCard extends StatelessWidget {
  const _RecordingCard({required this.recording, required this.onDelete});
  final Recording recording;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final ({String label, StatusTone tone}) status =
        StatusUi.recording(recording.status);
    return GlassCard(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        children: [
          Icon(Icons.audiotrack_rounded, color: t.colors.accentPrimary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recording.sourceFileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyLarge
                        .copyWith(color: t.colors.textPrimary)),
                const SizedBox(height: 2),
                Text(
                  '${Formatters.bytes(recording.fileSizeBytes)} · ${Formatters.humanDuration(recording.audioDurationSeconds)}'
                  '${recording.chunkCount > 1 ? ' · ${recording.chunkCount} blocchi' : ''}',
                  style: AppTypography.caption
                      .copyWith(color: t.colors.textTertiary),
                ),
                if (recording.errorMessage != null) ...[
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () => AppDialog.info(
                      context: context,
                      title: 'Dettaglio errore',
                      message: recording.errorMessage!,
                    ),
                    child: Text(recording.errorMessage!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption
                            .copyWith(color: t.colors.error)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          StatusBadge(label: status.label, tone: status.tone),
          IconButton(
            icon: Icon(Icons.delete_outline, color: t.colors.textTertiary),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
