import '../../domain/entities/meeting_markdown.dart';
import '../../domain/services/project_knowledge_retriever.dart';

/// Retriever MVP (SRD §8bis): include tutti i recap finché stanno comodamente
/// nel contesto (stima grezza sui caratteri ≈ token/4); oltre la soglia, ripiega
/// sulla ricerca per parole chiave. Evoluzione futura: embeddings/RAG, dietro la
/// stessa interfaccia [ProjectKnowledgeRetriever].
class DefaultKnowledgeRetriever implements ProjectKnowledgeRetriever {
  const DefaultKnowledgeRetriever({this.maxChars = 48000, this.maxKeywordDocs = 8});

  /// Budget di caratteri complessivo dei recap da passare al modello.
  final int maxChars;

  /// Numero massimo di recap in modalità keyword.
  final int maxKeywordDocs;

  @override
  Future<List<MeetingMarkdown>> retrieve({
    required List<MeetingMarkdown> allRecaps,
    required String question,
  }) async {
    final int totalChars =
        allRecaps.fold<int>(0, (int s, MeetingMarkdown m) => s + m.contentMarkdown.length);

    // Sotto soglia: passa tutto (comportamento MVP).
    if (totalChars <= maxChars) return allRecaps;

    // Sopra soglia: seleziona i recap più rilevanti per parole chiave.
    final List<String> keywords = _keywords(question);
    final List<_Scored> scored = allRecaps
        .map((MeetingMarkdown m) =>
            _Scored(m, _score(m.contentMarkdown.toLowerCase(), keywords)))
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    final List<MeetingMarkdown> selected = <MeetingMarkdown>[];
    int used = 0;
    for (final _Scored s in scored.take(maxKeywordDocs)) {
      if (used + s.recap.contentMarkdown.length > maxChars && selected.isNotEmpty) {
        break;
      }
      selected.add(s.recap);
      used += s.recap.contentMarkdown.length;
    }
    return selected;
  }

  List<String> _keywords(String question) => question
      .toLowerCase()
      .split(RegExp(r'[^a-zà-ù0-9]+'))
      .where((String w) => w.length > 3)
      .toSet()
      .toList();

  int _score(String content, List<String> keywords) {
    int score = 0;
    for (final String k in keywords) {
      int index = content.indexOf(k);
      while (index != -1) {
        score++;
        index = content.indexOf(k, index + k.length);
      }
    }
    return score;
  }
}

class _Scored {
  const _Scored(this.recap, this.score);
  final MeetingMarkdown recap;
  final int score;
}
