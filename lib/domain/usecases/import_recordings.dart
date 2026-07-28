import 'dart:io';

import 'package:uuid/uuid.dart';

import '../entities/meeting.dart';
import '../entities/meeting_status.dart';
import '../entities/recording.dart';
import '../repositories/meeting_repository.dart';
import '../services/audio_processor.dart';
import '../services/recording_file_store.dart';

/// Importa una o più registrazioni (SRD §6.1, §6bis): copia i file nell'area
/// persistente, crea/aggiorna la Meeting e aggiunge una Recording per file.
class ImportRecordings {
  ImportRecordings({
    required MeetingRepository meetingRepository,
    required RecordingFileStore fileStore,
    required AudioProcessor audioProcessor,
  })  : _meetingRepo = meetingRepository,
        _fileStore = fileStore,
        _audioProcessor = audioProcessor;

  final MeetingRepository _meetingRepo;
  final RecordingFileStore _fileStore;
  final AudioProcessor _audioProcessor;
  static const Uuid _uuid = Uuid();

  /// Crea una nuova riunione con i file dati.
  Future<Meeting> createMeetingWithFiles({
    required String projectId,
    required String title,
    required List<String> sourceFilePaths,
  }) async {
    final Meeting meeting =
        await _meetingRepo.createMeeting(projectId: projectId, title: title);
    await _attach(meeting.id, sourceFilePaths, startIndex: 0);
    return meeting;
  }

  /// Aggiunge registrazioni a una riunione esistente (SRD §6bis.2). Se la
  /// riunione era già analizzata, la marca come da rigenerare (SRD §6bis.5).
  Future<void> addToMeeting({
    required String meetingId,
    required List<String> sourceFilePaths,
  }) async {
    final List<Recording> existing = await _meetingRepo.getRecordings(meetingId);
    await _attach(meetingId, sourceFilePaths, startIndex: existing.length);

    final Meeting? meeting = await _meetingRepo.getMeeting(meetingId);
    if (meeting != null && meeting.status == MeetingStatus.completed) {
      await _meetingRepo.updateMeeting(
        meeting.copyWith(
          status: MeetingStatus.transcribed,
          needsReanalysis: true,
        ),
      );
    }
  }

  Future<void> _attach(
    String meetingId,
    List<String> sourceFilePaths, {
    required int startIndex,
  }) async {
    for (int i = 0; i < sourceFilePaths.length; i++) {
      final String source = sourceFilePaths[i];
      final String persisted = await _fileStore.persistRecording(source);
      final int size = await File(persisted).length();
      final int? duration =
          await _audioProcessor.probeDurationSeconds(persisted);

      await _meetingRepo.addRecording(
        Recording(
          id: _uuid.v4(),
          meetingId: meetingId,
          orderIndex: startIndex + i,
          sourceFileName: _fileName(source),
          localFilePath: persisted,
          fileSizeBytes: size,
          status: RecordingStatus.imported,
          createdAt: DateTime.now(),
          audioDurationSeconds: duration,
        ),
      );
    }
  }

  String _fileName(String path) {
    final int slash = path.lastIndexOf(Platform.pathSeparator);
    return slash == -1 ? path : path.substring(slash + 1);
  }
}
