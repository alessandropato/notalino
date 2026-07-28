import '../../core/errors/app_exceptions.dart';
import '../../core/prompts/analysis_prompt.dart';
import '../../core/utils/json_extractor.dart';
import '../../domain/entities/meeting_report.dart';
import '../../domain/services/analysis_service.dart';
import '../datasources/remote/openai_chat_api.dart';

/// Implementazione di [AnalysisService] basata su GPT (SRD §8).
/// Parsing JSON tollerante: rimozione fence, validazione campi, retry di
/// correzione formato.
class OpenAiAnalysisService implements AnalysisService {
  OpenAiAnalysisService({
    required OpenAiChatApi chatApi,
    required Future<String> Function() modelProvider,
  })  : _chatApi = chatApi,
        _modelProvider = modelProvider;

  final OpenAiChatApi _chatApi;
  final Future<String> Function() _modelProvider;

  @override
  Future<AnalysisResult> analyzeTranscript(String transcript) async {
    final String model = await _modelProvider();

    ChatCompletionResponse res = await _chatApi.complete(
      model: model,
      systemPrompt: AnalysisPrompt.system,
      userPrompt: AnalysisPrompt.user(transcript),
      jsonMode: true,
    );

    Map<String, dynamic>? parsed = _tryParse(res.content);
    int inputTokens = res.inputTokens;
    int outputTokens = res.outputTokens;

    // Retry di correzione formato se il primo output non è JSON valido (§8).
    if (parsed == null) {
      res = await _chatApi.complete(
        model: model,
        systemPrompt: AnalysisPrompt.system,
        userPrompt:
            '${AnalysisPrompt.user(transcript)}\n\n${AnalysisPrompt.retryFixFormat}',
        jsonMode: true,
      );
      parsed = _tryParse(res.content);
      inputTokens += res.inputTokens;
      outputTokens += res.outputTokens;
    }

    if (parsed == null) {
      throw AnalysisParseException(
        'Il modello non ha prodotto un JSON valido per il verbale.',
        rawJson: res.content,
      );
    }

    return AnalysisResult(
      summary: (parsed['summary'] as String?)?.trim() ?? '',
      problems: _problems(parsed['problems']),
      decisions: _decisions(parsed['decisions']),
      actionItems: _actions(parsed['actionItems']),
      rawJson: res.content,
      model: res.model,
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
  }

  @override
  Future<ChatResult> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final String model = await _modelProvider();
    final ChatCompletionResponse res = await _chatApi.complete(
      model: model,
      systemPrompt: systemPrompt,
      userPrompt: userPrompt,
    );
    return ChatResult(
      content: res.content,
      model: res.model,
      inputTokens: res.inputTokens,
      outputTokens: res.outputTokens,
    );
  }

  static Map<String, dynamic>? _tryParse(String raw) =>
      JsonExtractor.extractObject(raw);

  static List<ProblemItem> _problems(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((m) => ProblemItem(
              title: (m['title'] as String?)?.trim() ?? '',
              detail: (m['detail'] as String?)?.trim() ?? '',
            ))
        .where((p) => p.title.isNotEmpty || p.detail.isNotEmpty)
        .toList();
  }

  static List<DecisionItem> _decisions(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((m) => DecisionItem(
              title: (m['title'] as String?)?.trim() ?? '',
              detail: (m['detail'] as String?)?.trim() ?? '',
            ))
        .where((d) => d.title.isNotEmpty || d.detail.isNotEmpty)
        .toList();
  }

  static List<ActionItem> _actions(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((m) => ActionItem(
              task: (m['task'] as String?)?.trim() ?? '',
              owner: _nullableString(m['owner']),
              due: _nullableString(m['due']),
            ))
        .where((a) => a.task.isNotEmpty)
        .toList();
  }

  static String? _nullableString(Object? v) {
    if (v == null) return null;
    if (v is String) {
      final String t = v.trim();
      if (t.isEmpty || t.toLowerCase() == 'null') return null;
      return t;
    }
    return v.toString();
  }
}
