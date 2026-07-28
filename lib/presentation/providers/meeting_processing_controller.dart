import 'package:flutter_riverpod/flutter_riverpod.dart';

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
class MeetingProcessingController extends FamilyNotifier<ProcessingState, String> {
  @override
  ProcessingState build(String meetingId) => const ProcessingState();

  Future<void> process() async {
    final String meetingId = arg;
    try {
      state = const ProcessingState(
        phase: ProcessingPhase.transcribing,
        label: 'Preparazione trascrizione…',
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
      await ref.read(analyzeMeetingProvider).call(arg);
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

final NotifierProviderFamily<MeetingProcessingController, ProcessingState, String>
    meetingProcessingProvider =
    NotifierProvider.family<MeetingProcessingController, ProcessingState, String>(
        MeetingProcessingController.new);
