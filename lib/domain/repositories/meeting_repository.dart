import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/meeting_report.dart';
import '../entities/recording.dart';
import '../entities/transcript.dart';

/// Repository di riunioni, registrazioni, trascrizioni, report e Markdown
/// (SRD §5). Il DB è source of truth; il Markdown è proiezione derivata.
abstract interface class MeetingRepository {
  // --- Meeting ---
  Future<Meeting?> getMeeting(String id);
  Stream<Meeting?> watchMeeting(String id);
  Future<List<Meeting>> getMeetingsForProject(String projectId);
  Stream<List<Meeting>> watchMeetingsForProject(String projectId);
  Future<Meeting> createMeeting({required String projectId, required String title});
  Future<void> updateMeeting(Meeting meeting);
  Future<void> deleteMeeting(String id);

  // --- Recording ---
  Future<List<Recording>> getRecordings(String meetingId);
  Stream<List<Recording>> watchRecordings(String meetingId);
  Future<Recording> addRecording(Recording recording);
  Future<void> updateRecording(Recording recording);
  Future<void> deleteRecording(String id);
  Future<void> reorderRecordings(String meetingId, List<String> orderedIds);

  // --- Transcript ---
  Future<RecordingTranscript?> getRecordingTranscript(String recordingId);
  Future<void> saveRecordingTranscript(RecordingTranscript transcript);
  Future<Transcript?> getTranscript(String meetingId);
  Future<void> saveTranscript(Transcript transcript);

  // --- Report + Markdown ---
  Future<MeetingReport?> getReport(String meetingId);
  Future<void> saveReport(MeetingReport report);
  Future<MeetingMarkdown?> getMarkdown(String meetingId);
  Future<void> saveMarkdown(MeetingMarkdown markdown);

  /// Recap Markdown di tutte le riunioni completate di un progetto (per
  /// contesto e Q&A, SRD §8bis).
  Future<List<MeetingMarkdown>> getMarkdownsForProject(String projectId);
}
