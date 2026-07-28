import 'package:drift/drift.dart';

/// Schema del database locale (SRD §5). Chiavi primarie UUID (text).
/// Il DB è la source of truth; il Markdown è proiezione derivata.

@DataClassName('ProjectRow')
class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get colorValue => integer().nullable()();
  IntColumn get iconCodePoint => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ProjectContextRow')
class ProjectContexts extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get overviewMarkdown => text()();
  DateTimeColumn get updatedAt => dateTime()();

  /// Lista di meetingId incorporati, serializzata come JSON array.
  TextColumn get sourceMeetingIdsJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeetingRow')
class Meetings extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text()();
  TextColumn get errorMessage => text().nullable()();
  BoolColumn get needsReanalysis => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RecordingRow')
class Recordings extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(Meetings, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get sourceFileName => text()();
  TextColumn get localFilePath => text()();
  IntColumn get fileSizeBytes => integer()();
  IntColumn get audioDurationSeconds => integer().nullable()();
  TextColumn get status => text()();
  IntColumn get chunkCount => integer().withDefault(const Constant(1))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RecordingTranscriptRow')
class RecordingTranscripts extends Table {
  TextColumn get id => text()();
  TextColumn get recordingId => text().references(Recordings, #id, onDelete: KeyAction.cascade)();
  // 'content' e non 'text': 'text' collide con il builder Table.text().
  TextColumn get content => text()();
  TextColumn get language => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TranscriptRow')
class Transcripts extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(Meetings, #id, onDelete: KeyAction.cascade)();
  TextColumn get fullText => text()();
  TextColumn get language => text().nullable()();
  IntColumn get recordingCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeetingReportRow')
class MeetingReports extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(Meetings, #id, onDelete: KeyAction.cascade)();
  TextColumn get summary => text()();
  TextColumn get rawJson => text()();
  TextColumn get modelUsed => text()();
  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Tabelle figlie del report (SRD §5: preferire tabelle figlie con Drift).
@DataClassName('ProblemRow')
class ReportProblems extends Table {
  TextColumn get id => text()();
  TextColumn get reportId => text().references(MeetingReports, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get title => text()();
  TextColumn get detail => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DecisionRow')
class ReportDecisions extends Table {
  TextColumn get id => text()();
  TextColumn get reportId => text().references(MeetingReports, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get title => text()();
  TextColumn get detail => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ActionItemRow')
class ReportActionItems extends Table {
  TextColumn get id => text()();
  TextColumn get reportId => text().references(MeetingReports, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get task => text()();
  TextColumn get owner => text().nullable()();
  TextColumn get due => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MeetingMarkdownRow')
class MeetingMarkdowns extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(Meetings, #id, onDelete: KeyAction.cascade)();
  TextColumn get contentMarkdown => text()();
  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('UsageRecordRow')
class UsageRecords extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().nullable()();
  TextColumn get projectId => text().nullable()();
  TextColumn get operationType => text()();
  TextColumn get model => text()();
  IntColumn get audioSeconds => integer().nullable()();
  IntColumn get inputTokens => integer().nullable()();
  IntColumn get outputTokens => integer().nullable()();
  RealColumn get estimatedCostUsd => real()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QaThreadRow')
class QaThreads extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text().references(Projects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('QaMessageRow')
class QaMessages extends Table {
  TextColumn get id => text()();
  TextColumn get threadId => text().references(QaThreads, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get citedMeetingIdsJson => text().withDefault(const Constant('[]'))();
  TextColumn get usageRecordId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
