import '../entities/meeting_report.dart';

/// Astrazione del servizio di analisi/chat AI (SRD §8, §11). Copre analisi
/// verbale, generazione contesto e Q&A, tutte basate su chat completion.
abstract interface class AnalysisService {
  /// Analizza la trascrizione e produce il verbale strutturato (SRD §8).
  Future<AnalysisResult> analyzeTranscript(String transcript);

  /// Chiamata generica (contesto progetto, Q&A): system + user → testo.
  Future<ChatResult> complete({
    required String systemPrompt,
    required String userPrompt,
  });
}

/// Esito dell'analisi: report parsato + metadati per il costo (SRD §9).
class AnalysisResult {
  const AnalysisResult({
    required this.summary,
    required this.problems,
    required this.decisions,
    required this.actionItems,
    required this.rawJson,
    required this.model,
    required this.inputTokens,
    required this.outputTokens,
  });

  final String summary;
  final List<ProblemItem> problems;
  final List<DecisionItem> decisions;
  final List<ActionItem> actionItems;
  final String rawJson;
  final String model;
  final int inputTokens;
  final int outputTokens;
}

/// Esito di una chat completion generica.
class ChatResult {
  const ChatResult({
    required this.content,
    required this.model,
    required this.inputTokens,
    required this.outputTokens,
  });

  final String content;
  final String model;
  final int inputTokens;
  final int outputTokens;
}
