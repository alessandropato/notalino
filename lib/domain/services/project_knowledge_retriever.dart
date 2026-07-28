import '../entities/meeting_markdown.dart';

/// Recupera i recap di riunione rilevanti per una domanda (SRD §8bis, §11).
/// MVP: tutti i recap / ricerca per parole chiave. Evoluzione: embeddings/RAG,
/// senza cambiare questa interfaccia.
abstract interface class ProjectKnowledgeRetriever {
  /// Seleziona i recap (Markdown) da includere nel contesto della domanda.
  Future<List<MeetingMarkdown>> retrieve({
    required List<MeetingMarkdown> allRecaps,
    required String question,
  });
}
