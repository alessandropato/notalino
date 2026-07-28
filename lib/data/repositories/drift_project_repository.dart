import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/local/app_database.dart';

/// Implementazione Drift di [ProjectRepository] (SRD §5).
class DriftProjectRepository implements ProjectRepository {
  DriftProjectRepository(this._db);

  final AppDatabase _db;
  static const Uuid _uuid = Uuid();

  Project _toEntity(ProjectRow r) => Project(
        id: r.id,
        name: r.name,
        description: r.description,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
        colorValue: r.colorValue,
        iconCodePoint: r.iconCodePoint,
      );

  @override
  Future<List<Project>> getProjects() async {
    final List<ProjectRow> rows = await (_db.select(_db.projects)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  @override
  Stream<List<Project>> watchProjects() {
    return (_db.select(_db.projects)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch()
        .map((List<ProjectRow> rows) => rows.map(_toEntity).toList());
  }

  @override
  Future<Project?> getProject(String id) async {
    final ProjectRow? row = await (_db.select(_db.projects)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toEntity(row);
  }

  @override
  Future<Project> createProject({
    required String name,
    String description = '',
  }) async {
    final DateTime now = DateTime.now();
    final Project project = Project(
      id: _uuid.v4(),
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.projects).insert(
          ProjectsCompanion.insert(
            id: project.id,
            name: project.name,
            description: Value(project.description),
            createdAt: project.createdAt,
            updatedAt: project.updatedAt,
          ),
        );
    return project;
  }

  @override
  Future<void> updateProject(Project project) async {
    await (_db.update(_db.projects)..where((t) => t.id.equals(project.id)))
        .write(
      ProjectsCompanion(
        name: Value(project.name),
        description: Value(project.description),
        updatedAt: Value(DateTime.now()),
        colorValue: Value(project.colorValue),
        iconCodePoint: Value(project.iconCodePoint),
      ),
    );
  }

  @override
  Future<void> deleteProject(String id) async {
    await (_db.delete(_db.projects)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<Map<String, int>> meetingCounts() async {
    final Expression<int> count = _db.meetings.id.count();
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        _db.selectOnly(_db.meetings)
          ..addColumns([_db.meetings.projectId, count])
          ..groupBy([_db.meetings.projectId]);
    final List<TypedResult> rows = await query.get();
    final Map<String, int> result = <String, int>{};
    for (final TypedResult row in rows) {
      final String? pid = row.read(_db.meetings.projectId);
      final int? c = row.read(count);
      if (pid != null) result[pid] = c ?? 0;
    }
    return result;
  }

  // --- Contesto ---

  ProjectContext _ctxToEntity(ProjectContextRow r) => ProjectContext(
        id: r.id,
        projectId: r.projectId,
        overviewMarkdown: r.overviewMarkdown,
        updatedAt: r.updatedAt,
        sourceMeetingIds: (jsonDecode(r.sourceMeetingIdsJson) as List<dynamic>)
            .cast<String>(),
      );

  @override
  Future<ProjectContext?> getContext(String projectId) async {
    final ProjectContextRow? row = await (_db.select(_db.projectContexts)
          ..where((t) => t.projectId.equals(projectId)))
        .getSingleOrNull();
    return row == null ? null : _ctxToEntity(row);
  }

  @override
  Stream<ProjectContext?> watchContext(String projectId) {
    return (_db.select(_db.projectContexts)
          ..where((t) => t.projectId.equals(projectId)))
        .watchSingleOrNull()
        .map((ProjectContextRow? row) =>
            row == null ? null : _ctxToEntity(row));
  }

  @override
  Future<void> saveContext(ProjectContext context) async {
    // Un solo contesto per progetto: rimpiazza l'eventuale esistente.
    await _db.transaction(() async {
      await (_db.delete(_db.projectContexts)
            ..where((t) => t.projectId.equals(context.projectId)))
          .go();
      await _db.into(_db.projectContexts).insert(
            ProjectContextsCompanion.insert(
              id: context.id,
              projectId: context.projectId,
              overviewMarkdown: context.overviewMarkdown,
              updatedAt: context.updatedAt,
              sourceMeetingIdsJson:
                  Value(jsonEncode(context.sourceMeetingIds)),
            ),
          );
    });
  }
}
