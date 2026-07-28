import 'package:drift/drift.dart';

import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/usage_record.dart';
import '../../domain/repositories/usage_repository.dart';
import '../datasources/local/app_database.dart';

/// Implementazione Drift di [UsageRepository] (SRD §9).
class DriftUsageRepository implements UsageRepository {
  DriftUsageRepository(this._db);

  final AppDatabase _db;

  UsageRecord _toEntity(UsageRecordRow r) => UsageRecord(
        id: r.id,
        meetingId: r.meetingId,
        projectId: r.projectId,
        operationType: UsageOperationType.fromName(r.operationType),
        model: r.model,
        audioSeconds: r.audioSeconds,
        inputTokens: r.inputTokens,
        outputTokens: r.outputTokens,
        estimatedCostUsd: r.estimatedCostUsd,
        timestamp: r.timestamp,
      );

  @override
  Future<void> record(UsageRecord record) async {
    await _db.into(_db.usageRecords).insert(
          UsageRecordsCompanion.insert(
            id: record.id,
            meetingId: Value(record.meetingId),
            projectId: Value(record.projectId),
            operationType: record.operationType.name,
            model: record.model,
            audioSeconds: Value(record.audioSeconds),
            inputTokens: Value(record.inputTokens),
            outputTokens: Value(record.outputTokens),
            estimatedCostUsd: record.estimatedCostUsd,
            timestamp: record.timestamp,
          ),
        );
  }

  @override
  Future<List<UsageRecord>> getAll() async {
    final List<UsageRecordRow> rows = await (_db.select(_db.usageRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Stream<List<UsageRecord>> watchAll() => (_db.select(_db.usageRecords)
        ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
      .watch()
      .map((List<UsageRecordRow> rows) => rows.map(_toEntity).toList());

  @override
  Future<double> currentMonthTotalUsd() async {
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month);
    final List<UsageRecordRow> rows = await (_db.select(_db.usageRecords)
          ..where((t) => t.timestamp.isBiggerOrEqualValue(start)))
        .get();
    return rows.fold<double>(0, (double s, UsageRecordRow r) => s + r.estimatedCostUsd);
  }

  @override
  Future<double> allTimeTotalUsd() async {
    final List<UsageRecordRow> rows = await _db.select(_db.usageRecords).get();
    return rows.fold<double>(0, (double s, UsageRecordRow r) => s + r.estimatedCostUsd);
  }

  @override
  Future<List<UsageRecord>> getForMeeting(String meetingId) async {
    final List<UsageRecordRow> rows = await (_db.select(_db.usageRecords)
          ..where((t) => t.meetingId.equals(meetingId)))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<List<UsageRecord>> getForProject(String projectId) async {
    final List<UsageRecordRow> rows = await (_db.select(_db.usageRecords)
          ..where((t) => t.projectId.equals(projectId)))
        .get();
    return rows.map(_toEntity).toList();
  }
}
