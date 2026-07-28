import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_markdown.dart';
import '../../domain/entities/meeting_report.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/recording.dart';
import '../../domain/entities/transcript.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../datasources/local/app_database.dart';

/// Implementazione Drift di [MeetingRepository] (SRD §5).
class DriftMeetingRepository implements MeetingRepository {
  DriftMeetingRepository(this._db);

  final AppDatabase _db;
  static const Uuid _uuid = Uuid();

  // ---------------- Meeting ----------------

  Meeting _meetingToEntity(MeetingRow r) => Meeting(
        id: r.id,
        projectId: r.projectId,
        title: r.title,
        createdAt: r.createdAt,
        status: MeetingStatus.fromName(r.status),
        errorMessage: r.errorMessage,
        needsReanalysis: r.needsReanalysis,
      );

  @override
  Future<Meeting?> getMeeting(String id) async {
    final MeetingRow? row = await (_db.select(_db.meetings)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _meetingToEntity(row);
  }

  @override
  Stream<Meeting?> watchMeeting(String id) =>
      (_db.select(_db.meetings)..where((t) => t.id.equals(id)))
          .watchSingleOrNull()
          .map((MeetingRow? r) => r == null ? null : _meetingToEntity(r));

  @override
  Future<List<Meeting>> getMeetingsForProject(String projectId) async {
    final List<MeetingRow> rows = await (_db.select(_db.meetings)
          ..where((t) => t.projectId.equals(projectId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_meetingToEntity).toList();
  }

  @override
  Stream<List<Meeting>> watchMeetingsForProject(String projectId) =>
      (_db.select(_db.meetings)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch()
          .map((List<MeetingRow> rows) => rows.map(_meetingToEntity).toList());

  @override
  Future<Meeting> createMeeting({
    required String projectId,
    required String title,
  }) async {
    final Meeting m = Meeting(
      id: _uuid.v4(),
      projectId: projectId,
      title: title,
      createdAt: DateTime.now(),
      status: MeetingStatus.draft,
    );
    await _db.into(_db.meetings).insert(
          MeetingsCompanion.insert(
            id: m.id,
            projectId: m.projectId,
            title: m.title,
            createdAt: m.createdAt,
            status: m.status.name,
          ),
        );
    return m;
  }

  @override
  Future<void> updateMeeting(Meeting meeting) async {
    await (_db.update(_db.meetings)..where((t) => t.id.equals(meeting.id)))
        .write(
      MeetingsCompanion(
        title: Value(meeting.title),
        status: Value(meeting.status.name),
        projectId: Value(meeting.projectId),
        errorMessage: Value(meeting.errorMessage),
        needsReanalysis: Value(meeting.needsReanalysis),
      ),
    );
  }

  @override
  Future<void> deleteMeeting(String id) async {
    await (_db.delete(_db.meetings)..where((t) => t.id.equals(id))).go();
  }

  // ---------------- Recording ----------------

  Recording _recToEntity(RecordingRow r) => Recording(
        id: r.id,
        meetingId: r.meetingId,
        orderIndex: r.orderIndex,
        sourceFileName: r.sourceFileName,
        localFilePath: r.localFilePath,
        fileSizeBytes: r.fileSizeBytes,
        status: RecordingStatus.fromName(r.status),
        createdAt: r.createdAt,
        audioDurationSeconds: r.audioDurationSeconds,
        chunkCount: r.chunkCount,
        errorMessage: r.errorMessage,
      );

  @override
  Future<List<Recording>> getRecordings(String meetingId) async {
    final List<RecordingRow> rows = await (_db.select(_db.recordings)
          ..where((t) => t.meetingId.equals(meetingId))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
    return rows.map(_recToEntity).toList();
  }

  @override
  Stream<List<Recording>> watchRecordings(String meetingId) =>
      (_db.select(_db.recordings)
            ..where((t) => t.meetingId.equals(meetingId))
            ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
          .watch()
          .map((List<RecordingRow> rows) => rows.map(_recToEntity).toList());

  @override
  Future<Recording> addRecording(Recording recording) async {
    await _db.into(_db.recordings).insert(
          RecordingsCompanion.insert(
            id: recording.id,
            meetingId: recording.meetingId,
            orderIndex: recording.orderIndex,
            sourceFileName: recording.sourceFileName,
            localFilePath: recording.localFilePath,
            fileSizeBytes: recording.fileSizeBytes,
            status: recording.status.name,
            audioDurationSeconds: Value(recording.audioDurationSeconds),
            chunkCount: Value(recording.chunkCount),
            createdAt: recording.createdAt,
          ),
        );
    return recording;
  }

  @override
  Future<void> updateRecording(Recording recording) async {
    await (_db.update(_db.recordings)
          ..where((t) => t.id.equals(recording.id)))
        .write(
      RecordingsCompanion(
        orderIndex: Value(recording.orderIndex),
        status: Value(recording.status.name),
        audioDurationSeconds: Value(recording.audioDurationSeconds),
        chunkCount: Value(recording.chunkCount),
        errorMessage: Value(recording.errorMessage),
      ),
    );
  }

  @override
  Future<void> deleteRecording(String id) async {
    await (_db.delete(_db.recordings)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> reorderRecordings(
    String meetingId,
    List<String> orderedIds,
  ) async {
    await _db.transaction(() async {
      for (int i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.recordings)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(RecordingsCompanion(orderIndex: Value(i)));
      }
    });
  }

  // ---------------- Transcript ----------------

  @override
  Future<RecordingTranscript?> getRecordingTranscript(
    String recordingId,
  ) async {
    final RecordingTranscriptRow? row =
        await (_db.select(_db.recordingTranscripts)
              ..where((t) => t.recordingId.equals(recordingId)))
            .getSingleOrNull();
    return row == null
        ? null
        : RecordingTranscript(
            id: row.id,
            recordingId: row.recordingId,
            text: row.content,
            language: row.language,
          );
  }

  @override
  Future<void> saveRecordingTranscript(RecordingTranscript transcript) async {
    await _db.transaction(() async {
      await (_db.delete(_db.recordingTranscripts)
            ..where((t) => t.recordingId.equals(transcript.recordingId)))
          .go();
      await _db.into(_db.recordingTranscripts).insert(
            RecordingTranscriptsCompanion.insert(
              id: transcript.id,
              recordingId: transcript.recordingId,
              content: transcript.text,
              language: Value(transcript.language),
            ),
          );
    });
  }

  @override
  Future<Transcript?> getTranscript(String meetingId) async {
    final TranscriptRow? row = await (_db.select(_db.transcripts)
          ..where((t) => t.meetingId.equals(meetingId)))
        .getSingleOrNull();
    return row == null
        ? null
        : Transcript(
            id: row.id,
            meetingId: row.meetingId,
            fullText: row.fullText,
            recordingCount: row.recordingCount,
            language: row.language,
          );
  }

  @override
  Future<void> saveTranscript(Transcript transcript) async {
    await _db.transaction(() async {
      await (_db.delete(_db.transcripts)
            ..where((t) => t.meetingId.equals(transcript.meetingId)))
          .go();
      await _db.into(_db.transcripts).insert(
            TranscriptsCompanion.insert(
              id: transcript.id,
              meetingId: transcript.meetingId,
              fullText: transcript.fullText,
              recordingCount: transcript.recordingCount,
              language: Value(transcript.language),
            ),
          );
    });
  }

  // ---------------- Report + Markdown ----------------

  @override
  Future<MeetingReport?> getReport(String meetingId) async {
    final MeetingReportRow? row = await (_db.select(_db.meetingReports)
          ..where((t) => t.meetingId.equals(meetingId)))
        .getSingleOrNull();
    if (row == null) return null;

    final List<ProblemRow> problems = await (_db.select(_db.reportProblems)
          ..where((t) => t.reportId.equals(row.id))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
    final List<DecisionRow> decisions = await (_db.select(_db.reportDecisions)
          ..where((t) => t.reportId.equals(row.id))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
    final List<ActionItemRow> actions =
        await (_db.select(_db.reportActionItems)
              ..where((t) => t.reportId.equals(row.id))
              ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
            .get();

    return MeetingReport(
      id: row.id,
      meetingId: row.meetingId,
      summary: row.summary,
      problems: problems
          .map((p) => ProblemItem(title: p.title, detail: p.detail))
          .toList(),
      decisions: decisions
          .map((d) => DecisionItem(title: d.title, detail: d.detail))
          .toList(),
      actionItems: actions
          .map((a) => ActionItem(task: a.task, owner: a.owner, due: a.due))
          .toList(),
      rawJson: row.rawJson,
      modelUsed: row.modelUsed,
      generatedAt: row.generatedAt,
    );
  }

  @override
  Future<void> saveReport(MeetingReport report) async {
    await _db.transaction(() async {
      // Rimpiazza il report esistente della riunione e le sue liste figlie.
      final List<MeetingReportRow> existing =
          await (_db.select(_db.meetingReports)
                ..where((t) => t.meetingId.equals(report.meetingId)))
              .get();
      for (final MeetingReportRow e in existing) {
        await (_db.delete(_db.meetingReports)..where((t) => t.id.equals(e.id)))
            .go();
      }
      await _db.into(_db.meetingReports).insert(
            MeetingReportsCompanion.insert(
              id: report.id,
              meetingId: report.meetingId,
              summary: report.summary,
              rawJson: report.rawJson,
              modelUsed: report.modelUsed,
              generatedAt: report.generatedAt,
            ),
          );
      for (int i = 0; i < report.problems.length; i++) {
        final ProblemItem p = report.problems[i];
        await _db.into(_db.reportProblems).insert(
              ReportProblemsCompanion.insert(
                id: _uuid.v4(),
                reportId: report.id,
                orderIndex: i,
                title: p.title,
                detail: p.detail,
              ),
            );
      }
      for (int i = 0; i < report.decisions.length; i++) {
        final DecisionItem d = report.decisions[i];
        await _db.into(_db.reportDecisions).insert(
              ReportDecisionsCompanion.insert(
                id: _uuid.v4(),
                reportId: report.id,
                orderIndex: i,
                title: d.title,
                detail: d.detail,
              ),
            );
      }
      for (int i = 0; i < report.actionItems.length; i++) {
        final ActionItem a = report.actionItems[i];
        await _db.into(_db.reportActionItems).insert(
              ReportActionItemsCompanion.insert(
                id: _uuid.v4(),
                reportId: report.id,
                orderIndex: i,
                task: a.task,
                owner: Value(a.owner),
                due: Value(a.due),
              ),
            );
      }
    });
  }

  MeetingMarkdown _mdToEntity(MeetingMarkdownRow r) => MeetingMarkdown(
        id: r.id,
        meetingId: r.meetingId,
        contentMarkdown: r.contentMarkdown,
        generatedAt: r.generatedAt,
      );

  @override
  Future<MeetingMarkdown?> getMarkdown(String meetingId) async {
    final MeetingMarkdownRow? row = await (_db.select(_db.meetingMarkdowns)
          ..where((t) => t.meetingId.equals(meetingId)))
        .getSingleOrNull();
    return row == null ? null : _mdToEntity(row);
  }

  @override
  Future<void> saveMarkdown(MeetingMarkdown markdown) async {
    await _db.transaction(() async {
      await (_db.delete(_db.meetingMarkdowns)
            ..where((t) => t.meetingId.equals(markdown.meetingId)))
          .go();
      await _db.into(_db.meetingMarkdowns).insert(
            MeetingMarkdownsCompanion.insert(
              id: markdown.id,
              meetingId: markdown.meetingId,
              contentMarkdown: markdown.contentMarkdown,
              generatedAt: markdown.generatedAt,
            ),
          );
    });
  }

  @override
  Future<List<MeetingMarkdown>> getMarkdownsForProject(
    String projectId,
  ) async {
    final JoinedSelectStatement<HasResultSet, dynamic> query = _db
        .select(_db.meetingMarkdowns)
        .join([
      innerJoin(
        _db.meetings,
        _db.meetings.id.equalsExp(_db.meetingMarkdowns.meetingId),
      ),
    ])
      ..where(_db.meetings.projectId.equals(projectId))
      ..orderBy([OrderingTerm.asc(_db.meetings.createdAt)]);
    final List<TypedResult> rows = await query.get();
    return rows
        .map((TypedResult r) => _mdToEntity(r.readTable(_db.meetingMarkdowns)))
        .toList();
  }
}
