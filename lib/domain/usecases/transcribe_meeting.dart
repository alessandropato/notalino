import 'package:uuid/uuid.dart';

import '../../core/constants/audio_constants.dart';
import '../../core/constants/openai_constants.dart';
import '../entities/meeting.dart';
import '../entities/meeting_status.dart';
import '../entities/recording.dart';
import '../entities/transcript.dart';
import '../entities/usage_record.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/usage_repository.dart';
import '../services/audio_processor.dart';
import '../services/transcription_service.dart';
import 'cost_estimator.dart';

/// Avanzamento della trascrizione, per la UI (SRD §7.8, §10).
class TranscriptionProgress {
  const TranscriptionProgress({
    required this.recordingIndex,
    required this.recordingTotal,
    required this.chunkIndex,
    required this.chunkTotal,
  });

  final int recordingIndex; // 1-based
  final int recordingTotal;
  final int chunkIndex; // 1-based
  final int chunkTotal;
}

typedef ProgressCallback = void Function(TranscriptionProgress progress);

/// Trascrive tutte le registrazioni di una riunione (SRD §6.2). Lavora per
/// singola Recording; la riunione è `transcribed` quando tutte lo sono.
/// Solo le registrazioni non ancora trascritte vengono elaborate (SRD §6bis.6:
/// non si ripaga la trascrizione).
class TranscribeMeeting {
  TranscribeMeeting({
    required MeetingRepository meetingRepository,
    required UsageRepository usageRepository,
    required SettingsRepository settingsRepository,
    required AudioProcessor audioProcessor,
    required TranscriptionService transcriptionService,
  })  : _meetingRepo = meetingRepository,
        _usageRepo = usageRepository,
        _settingsRepo = settingsRepository,
        _audioProcessor = audioProcessor,
        _transcription = transcriptionService;

  final MeetingRepository _meetingRepo;
  final UsageRepository _usageRepo;
  final SettingsRepository _settingsRepo;
  final AudioProcessor _audioProcessor;
  final TranscriptionService _transcription;
  static const Uuid _uuid = Uuid();

  Future<void> call(String meetingId, {ProgressCallback? onProgress}) async {
    final Meeting? meeting = await _meetingRepo.getMeeting(meetingId);
    if (meeting == null) return;

    await _meetingRepo.updateMeeting(
      meeting.copyWith(status: MeetingStatus.transcribing, clearError: true),
    );

    try {
      final List<Recording> recordings =
          await _meetingRepo.getRecordings(meetingId);
      final double whisperRate = await _settingsRepo.getWhisperPerMinuteUsd();

      for (int i = 0; i < recordings.length; i++) {
        final Recording rec = recordings[i];
        // Riusa trascrizioni già presenti (SRD §6bis.6).
        if (rec.status == RecordingStatus.transcribed &&
            await _meetingRepo.getRecordingTranscript(rec.id) != null) {
          continue;
        }
        await _transcribeRecording(
          rec,
          recordingIndex: i + 1,
          recordingTotal: recordings.length,
          whisperRate: whisperRate,
          projectId: meeting.projectId,
          onProgress: onProgress,
        );
      }

      await _buildAggregateTranscript(meetingId);

      await _meetingRepo.updateMeeting(
        (await _meetingRepo.getMeeting(meetingId))!
            .copyWith(status: MeetingStatus.transcribed, clearError: true),
      );
    } on Object catch (e) {
      final Meeting? current = await _meetingRepo.getMeeting(meetingId);
      if (current != null) {
        await _meetingRepo.updateMeeting(
          current.copyWith(
            status: MeetingStatus.failed,
            errorMessage: e.toString(),
          ),
        );
      }
      rethrow;
    }
  }

  Future<void> _transcribeRecording(
    Recording rec, {
    required int recordingIndex,
    required int recordingTotal,
    required double whisperRate,
    required String projectId,
    ProgressCallback? onProgress,
  }) async {
    await _meetingRepo.updateRecording(
      rec.copyWith(status: RecordingStatus.transcribing, clearError: true),
    );

    try {
      // Chunking (SRD §7): pre-normalizza e, se serve, segmenta.
      final AudioChunkingResult chunking =
          await _audioProcessor.prepareForTranscription(rec.localFilePath);
      final List<String> segments = chunking.segmentPaths;

      final StringBuffer buffer = StringBuffer();
      int totalAudioSeconds = 0;
      String? language;

      for (int c = 0; c < segments.length; c++) {
        onProgress?.call(TranscriptionProgress(
          recordingIndex: recordingIndex,
          recordingTotal: recordingTotal,
          chunkIndex: c + 1,
          chunkTotal: segments.length,
        ));

        final TranscriptionResult result =
            await _transcription.transcribeFile(segments[c]);
        if (c > 0) buffer.write(' ');
        buffer.write(result.text.trim());
        totalAudioSeconds += result.audioSeconds ?? 0;
        language ??= result.language;

        // Un UsageRecord per chiamata Whisper (SRD §6.2.5).
        if ((result.audioSeconds ?? 0) > 0) {
          await _usageRepo.record(UsageRecord(
            id: _uuid.v4(),
            meetingId: rec.meetingId,
            projectId: projectId,
            operationType: UsageOperationType.transcription,
            model: OpenAiConstants.transcriptionModel,
            audioSeconds: result.audioSeconds,
            estimatedCostUsd: CostEstimator.transcription(
              audioSeconds: result.audioSeconds!,
              whisperPerMinuteUsd: whisperRate,
            ),
            timestamp: DateTime.now(),
          ));
        }
      }

      await _meetingRepo.saveRecordingTranscript(RecordingTranscript(
        id: _uuid.v4(),
        recordingId: rec.id,
        text: buffer.toString().trim(),
        language: language,
      ));

      await _meetingRepo.updateRecording(rec.copyWith(
        status: RecordingStatus.transcribed,
        chunkCount: segments.length,
        audioDurationSeconds:
            totalAudioSeconds > 0 ? totalAudioSeconds : rec.audioDurationSeconds,
        clearError: true,
      ));
    } on Object catch (e) {
      await _meetingRepo.updateRecording(
        rec.copyWith(status: RecordingStatus.failed, errorMessage: e.toString()),
      );
      rethrow;
    }
  }

  /// Concatena i RecordingTranscript in ordine di orderIndex con separatori
  /// leggibili (SRD §5 nota su fullText).
  Future<void> _buildAggregateTranscript(String meetingId) async {
    final List<Recording> recordings =
        await _meetingRepo.getRecordings(meetingId);
    final StringBuffer buffer = StringBuffer();
    String? language;
    int count = 0;

    for (final Recording rec in recordings) {
      final RecordingTranscript? rt =
          await _meetingRepo.getRecordingTranscript(rec.id);
      if (rt == null) continue;
      count++;
      if (count > 1) {
        buffer.write(AudioConstants.recordingSeparator(rec.orderIndex + 1));
      }
      buffer.write(rt.text);
      language ??= rt.language;
    }

    await _meetingRepo.saveTranscript(Transcript(
      id: _uuid.v4(),
      meetingId: meetingId,
      fullText: buffer.toString().trim(),
      recordingCount: count,
      language: language,
    ));
  }
}
