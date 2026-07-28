import '../entities/project.dart';

/// Repository dei progetti e del loro contesto vivo (SRD §5, §6ter).
abstract interface class ProjectRepository {
  Future<List<Project>> getProjects();
  Stream<List<Project>> watchProjects();
  Future<Project?> getProject(String id);
  Future<Project> createProject({required String name, String description});
  Future<void> updateProject(Project project);
  Future<void> deleteProject(String id);

  /// Numero di riunioni per progetto (per la UI home).
  Future<Map<String, int>> meetingCounts();

  // --- Contesto di progetto ---
  Future<ProjectContext?> getContext(String projectId);
  Stream<ProjectContext?> watchContext(String projectId);
  Future<void> saveContext(ProjectContext context);
}
