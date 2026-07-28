import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/qa.dart';
import '../../domain/repositories/qa_repository.dart';
import '../datasources/local/app_database.dart';

/// Implementazione Drift di [QaRepository] (SRD §8bis).
class DriftQaRepository implements QaRepository {
  DriftQaRepository(this._db);

  final AppDatabase _db;
  static const Uuid _uuid = Uuid();

  ProjectQAThread _threadToEntity(QaThreadRow r) => ProjectQAThread(
        id: r.id,
        projectId: r.projectId,
        title: r.title,
        createdAt: r.createdAt,
      );

  ProjectQAMessage _msgToEntity(QaMessageRow r) => ProjectQAMessage(
        id: r.id,
        threadId: r.threadId,
        role: QaRole.fromName(r.role),
        content: r.content,
        timestamp: r.timestamp,
        citedMeetingIds:
            (jsonDecode(r.citedMeetingIdsJson) as List<dynamic>).cast<String>(),
        usageRecordId: r.usageRecordId,
      );

  @override
  Future<List<ProjectQAThread>> getThreads(String projectId) async {
    final List<QaThreadRow> rows = await (_db.select(_db.qaThreads)
          ..where((t) => t.projectId.equals(projectId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_threadToEntity).toList();
  }

  @override
  Stream<List<ProjectQAThread>> watchThreads(String projectId) =>
      (_db.select(_db.qaThreads)
            ..where((t) => t.projectId.equals(projectId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch()
          .map((List<QaThreadRow> rows) =>
              rows.map(_threadToEntity).toList());

  @override
  Future<ProjectQAThread> createThread({
    required String projectId,
    required String title,
  }) async {
    final ProjectQAThread thread = ProjectQAThread(
      id: _uuid.v4(),
      projectId: projectId,
      title: title,
      createdAt: DateTime.now(),
    );
    await _db.into(_db.qaThreads).insert(
          QaThreadsCompanion.insert(
            id: thread.id,
            projectId: thread.projectId,
            title: thread.title,
            createdAt: thread.createdAt,
          ),
        );
    return thread;
  }

  @override
  Future<void> updateThreadTitle(String id, String title) async {
    await (_db.update(_db.qaThreads)..where((t) => t.id.equals(id)))
        .write(QaThreadsCompanion(title: Value(title)));
  }

  @override
  Future<void> deleteThread(String id) async {
    await (_db.delete(_db.qaThreads)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<ProjectQAMessage>> getMessages(String threadId) async {
    final List<QaMessageRow> rows = await (_db.select(_db.qaMessages)
          ..where((t) => t.threadId.equals(threadId))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
        .get();
    return rows.map(_msgToEntity).toList();
  }

  @override
  Stream<List<ProjectQAMessage>> watchMessages(String threadId) =>
      (_db.select(_db.qaMessages)
            ..where((t) => t.threadId.equals(threadId))
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .watch()
          .map((List<QaMessageRow> rows) => rows.map(_msgToEntity).toList());

  @override
  Future<void> addMessage(ProjectQAMessage message) async {
    await _db.into(_db.qaMessages).insert(
          QaMessagesCompanion.insert(
            id: message.id,
            threadId: message.threadId,
            role: message.role.name,
            content: message.content,
            timestamp: message.timestamp,
            citedMeetingIdsJson: Value(jsonEncode(message.citedMeetingIds)),
            usageRecordId: Value(message.usageRecordId),
          ),
        );
  }
}
