import '../../domain/entities/meeting_status.dart';
import '../widgets/status_badge.dart';

/// Mapping stato→(etichetta, tonalità) per i badge (SRD §10bis.1). Vive nella
/// presentazione così il dominio resta disaccoppiato dai colori.
abstract final class StatusUi {
  static ({String label, StatusTone tone}) meeting(MeetingStatus s) =>
      switch (s) {
        MeetingStatus.draft => (label: 'Bozza', tone: StatusTone.neutral),
        MeetingStatus.transcribing =>
          (label: 'Trascrizione…', tone: StatusTone.info),
        MeetingStatus.transcribed =>
          (label: 'Trascritta', tone: StatusTone.success),
        MeetingStatus.analyzing => (label: 'Analisi…', tone: StatusTone.info),
        MeetingStatus.completed => (label: 'Completata', tone: StatusTone.success),
        MeetingStatus.failed => (label: 'Errore', tone: StatusTone.error),
      };

  static ({String label, StatusTone tone}) recording(RecordingStatus s) =>
      switch (s) {
        RecordingStatus.imported => (label: 'Importata', tone: StatusTone.neutral),
        RecordingStatus.transcribing =>
          (label: 'Trascrizione…', tone: StatusTone.info),
        RecordingStatus.transcribed =>
          (label: 'Trascritta', tone: StatusTone.success),
        RecordingStatus.failed => (label: 'Errore', tone: StatusTone.error),
      };
}
