import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Database locale Drift (SRD §3, §5). Query relazionali progetti↔riunioni.
@DriftDatabase(
  tables: [
    Projects,
    ProjectContexts,
    Meetings,
    Recordings,
    RecordingTranscripts,
    Transcripts,
    MeetingReports,
    ReportProblems,
    ReportDecisions,
    ReportActionItems,
    MeetingMarkdowns,
    UsageRecords,
    QaThreads,
    QaMessages,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Costruttore per i test (DB in memoria).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        beforeOpen: (OpeningDetails details) async {
          // Abilita i vincoli di foreign key (cascade delete).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dir.path, 'notalino.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
