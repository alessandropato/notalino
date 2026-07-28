import 'package:meta/meta.dart';

import 'meeting_status.dart';

/// Una registrazione = un file audio caricato dall'utente (SRD §5).
@immutable
class Recording {
  const Recording({
    required this.id,
    required this.meetingId,
    required this.orderIndex,
    required this.sourceFileName,
    required this.localFilePath,
    required this.fileSizeBytes,
    required this.status,
    required this.createdAt,
    this.audioDurationSeconds,
    this.chunkCount = 1,
    this.errorMessage,
  });

  final String id;
  final String meetingId;

  /// Ordine dentro la riunione; l'utente può riordinare (SRD §6bis.3).
  final int orderIndex;
  final String sourceFileName;

  /// Percorso nell'area persistente dell'app (copia, non riferimento originale).
  final String localFilePath;
  final int fileSizeBytes;
  final RecordingStatus status;
  final DateTime createdAt;

  final int? audioDurationSeconds;

  /// In quanti chunk tecnici è stata divisa per Whisper (1 = non serviva).
  final int chunkCount;
  final String? errorMessage;

  Recording copyWith({
    int? orderIndex,
    RecordingStatus? status,
    int? audioDurationSeconds,
    int? chunkCount,
    String? errorMessage,
    bool clearError = false,
  }) =>
      Recording(
        id: id,
        meetingId: meetingId,
        orderIndex: orderIndex ?? this.orderIndex,
        sourceFileName: sourceFileName,
        localFilePath: localFilePath,
        fileSizeBytes: fileSizeBytes,
        status: status ?? this.status,
        createdAt: createdAt,
        audioDurationSeconds: audioDurationSeconds ?? this.audioDurationSeconds,
        chunkCount: chunkCount ?? this.chunkCount,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );
}
