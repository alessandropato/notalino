import '../entities/qa.dart';

/// Repository dei thread Q&A di progetto (SRD §5, §8bis).
abstract interface class QaRepository {
  Future<List<ProjectQAThread>> getThreads(String projectId);
  Stream<List<ProjectQAThread>> watchThreads(String projectId);
  Future<ProjectQAThread> createThread({
    required String projectId,
    required String title,
  });
  Future<void> updateThreadTitle(String id, String title);
  Future<void> deleteThread(String id);

  Future<List<ProjectQAMessage>> getMessages(String threadId);
  Stream<List<ProjectQAMessage>> watchMessages(String threadId);
  Future<void> addMessage(ProjectQAMessage message);
}
