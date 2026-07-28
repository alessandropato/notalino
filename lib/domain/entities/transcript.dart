import 'package:meta/meta.dart';

/// Trascrizione di una singola registrazione, già ricomposta dagli eventuali
/// chunk (SRD §5, RecordingTranscript).
@immutable
class RecordingTranscript {
  const RecordingTranscript({
    required this.id,
    required this.recordingId,
    required this.text,
    this.language,
  });

  final String id;
  final String recordingId;
  final String text;
  final String? language;
}

/// Trascrizione aggregata dell'intera riunione (SRD §5, Transcript):
/// concatenazione ordinata dei RecordingTranscript. L'analisi AI gira una sola
/// volta su questo `fullText`.
@immutable
class Transcript {
  const Transcript({
    required this.id,
    required this.meetingId,
    required this.fullText,
    required this.recordingCount,
    this.language,
  });

  final String id;
  final String meetingId;
  final String fullText;
  final int recordingCount;
  final String? language;
}
