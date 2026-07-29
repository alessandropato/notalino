import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/usecases/transcribe_meeting.dart';
import 'core_providers.dart';

enum ProcessingPhase { idle, transcribing, analyzing, done, error }

/// Stato dell'elaborazione di una riunione, per la UI (SRD §6, §10).
class ProcessingState {
  const ProcessingState({
    this.phase = ProcessingPhase.idle,
    this.label = '',
    this.current,
    this.total,
    this.errorMessage,
  });

  final ProcessingPhase phase;
  final String label;
  final int? current;
  final int? total;
  final String? errorMessage;

  bool get isBusy =>
      phase == ProcessingPhase.transcribing || phase == ProcessingPhase.analyzing;
}

/// Orchestrazione trascrizione → analisi con avanzamento (SRD §6.2, §6.3).
/// Non blocca la UI: si può navigare altrove mentre elabora (SRD §10).
///
/// È un notifier family (chiave = meetingId, ricevuto dal costruttore) per
/// tenere stati di elaborazione distinti per riunione.
class MeetingProcessingController extends Notifier<ProcessingState> {
  MeetingProcessingController(this.meetingId);

  final String meetingId;

  static const String _orphanedMessage =
      'L\'elaborazione è stata interrotta (probabilmente l\'app è stata chiusa mentre era in corso). Riprova.';

  @override
  ProcessingState build() {
    // `build()` gira una sola volta per meetingId per sessione dell'app, alla
    // PRIMA volta che questo controller viene letto in questa sessione. Se in
    // quel momento il DB dice già transcribing/analyzing, non può esserci
    // un'elaborazione realmente in corso in questa sessione (altrimenti
    // sarebbe stata avviata da `process()`, che passa da qui prima):
    // significa che una sessione precedente è stata interrotta (es. l'OS ha
    // terminato l'app in background) lasciando la riunione bloccata nel DB.
    // La riconciliamo subito in modo che l'utente veda un errore riprovabile
    // invece di uno stato "in corso" che non finirà mai (SRD §6.5).
    Future<void>.microtask(_reconcileOrphanedState);
    return const ProcessingState();
  }

  Future<void> _reconcileOrphanedState() async {
    final meetingRepo = ref.read(meetingRepositoryProvider);
    final Meeting? meeting = await meetingRepo.getMeeting(meetingId);
    if (meeting == null) return;
    if (meeting.status != MeetingStatus.transcribing &&
        meeting.status != MeetingStatus.analyzing) {
      return;
    }
    await meetingRepo.updateMeeting(meeting.copyWith(
      status: MeetingStatus.failed,
      errorMessage: _orphanedMessage,
    ));
    state = const ProcessingState(
      phase: ProcessingPhase.error,
      errorMessage: _orphanedMessage,
    );
  }

  Future<void> process() async {
    try {
      state = const ProcessingState(
        phase: ProcessingPhase.transcribing,
        label:
            'Preparazione audio… (per registrazioni lunghe può richiedere qualche minuto)',
      );

      await ref.read(transcribeMeetingProvider).call(
        meetingId,
        onProgress: (TranscriptionProgress p) {
          state = ProcessingState(
            phase: ProcessingPhase.transcribing,
            label: p.recordingTotal > 1
                ? 'Registrazione ${p.recordingIndex} di ${p.recordingTotal} · blocco ${p.chunkIndex} di ${p.chunkTotal}'
                : 'Trascrizione blocco ${p.chunkIndex} di ${p.chunkTotal}',
            current: p.chunkIndex,
            total: p.chunkTotal,
          );
        },
      );

      state = const ProcessingState(
        phase: ProcessingPhase.analyzing,
        label: 'Generazione del verbale…',
      );
      await ref.read(analyzeMeetingProvider).call(meetingId);

      state = const ProcessingState(phase: ProcessingPhase.done);
    } on Object catch (e) {
      state = ProcessingState(
        phase: ProcessingPhase.error,
        errorMessage: _humanError(e),
      );
    }
  }

  /// Solo rigenerazione dell'analisi (SRD §6bis.5), quando serve ri-analizzare.
  Future<void> reanalyzeOnly() async {
    try {
      state = const ProcessingState(
        phase: ProcessingPhase.analyzing,
        label: 'Rigenerazione del verbale…',
      );
      await ref.read(analyzeMeetingProvider).call(meetingId);
      state = const ProcessingState(phase: ProcessingPhase.done);
    } on Object catch (e) {
      state = ProcessingState(
        phase: ProcessingPhase.error,
        errorMessage: _humanError(e),
      );
    }
  }

  void reset() => state = const ProcessingState();

  String _humanError(Object e) => e.toString().replaceFirst('Exception: ', '');
}

final meetingProcessingProvider = NotifierProvider.family<
    MeetingProcessingController, ProcessingState, String>(
  MeetingProcessingController.new,
);
