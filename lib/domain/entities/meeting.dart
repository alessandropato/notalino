import 'package:meta/meta.dart';

import 'meeting_status.dart';

/// Riunione: unità di conoscenza composta da 1..N registrazioni (SRD §5).
/// Non contiene più un singolo file audio: i file stanno nelle [Recording].
@immutable
class Meeting {
  const Meeting({
    required this.id,
    required this.projectId,
    required this.title,
    required this.createdAt,
    required this.status,
    this.errorMessage,
    this.needsReanalysis = false,
  });

  final String id;
  final String projectId;
  final String title; // editabile; default = data o nome prima registrazione
  final DateTime createdAt;

  /// Stato aggregato derivato dalle registrazioni (SRD §5).
  final MeetingStatus status;
  final String? errorMessage;

  /// True se registrazioni aggiunte/rimosse/riordinate dopo l'ultima analisi
  /// hanno invalidato il verbale (SRD §6bis.5): serve rigenerare.
  final bool needsReanalysis;

  Meeting copyWith({
    String? title,
    MeetingStatus? status,
    String? errorMessage,
    bool clearError = false,
    bool? needsReanalysis,
    String? projectId,
  }) =>
      Meeting(
        id: id,
        projectId: projectId ?? this.projectId,
        title: title ?? this.title,
        createdAt: createdAt,
        status: status ?? this.status,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
        needsReanalysis: needsReanalysis ?? this.needsReanalysis,
      );
}
