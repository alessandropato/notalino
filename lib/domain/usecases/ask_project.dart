import 'package:uuid/uuid.dart';

import '../../core/prompts/qa_prompt.dart';
import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/meeting_status.dart';
import '../entities/project.dart';
import '../entities/qa.dart';
import '../entities/usage_record.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/project_repository.dart';
import '../repositories/qa_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/usage_repository.dart';
import '../services/analysis_service.dart';
import '../services/project_knowledge_retriever.dart';
import 'cost_estimator.dart';

/// Risponde a una domanda sul progetto basandosi sui recap (SRD §8bis).
/// Salva domanda e risposta nel thread e traccia il costo.
class AskProject {
  AskProject({
    required ProjectRepository projectRepository,
    required MeetingRepository meetingRepository,
    required QaRepository qaRepository,
    required UsageRepository usageRepository,
    required SettingsRepository settingsRepository,
    required AnalysisService analysisService,
    required ProjectKnowledgeRetriever retriever,
  })  : _projectRepo = projectRepository,
        _meetingRepo = meetingRepository,
        _qaRepo = qaRepository,
        _usageRepo = usageRepository,
        _settingsRepo = settingsRepository,
        _analysis = analysisService,
        _retriever = retriever;

  final ProjectRepository _projectRepo;
  final MeetingRepository _meetingRepo;
  final QaRepository _qaRepo;
  final UsageRepository _usageRepo;
  final SettingsRepository _settingsRepo;
  final AnalysisService _analysis;
  final ProjectKnowledgeRetriever _retriever;
  static const Uuid _uuid = Uuid();

  Future<void> ask({
    required String threadId,
    required String projectId,
    required String question,
  }) async {
    // Persisti subito la domanda dell'utente.
    await _qaRepo.addMessage(ProjectQAMessage(
      id: _uuid.v4(),
      threadId: threadId,
      role: QaRole.user,
      content: question,
      timestamp: DateTime.now(),
    ));

    final Project? project = await _projectRepo.getProject(projectId);
    final ProjectContext? context = await _projectRepo.getContext(projectId);
    final List<MeetingMarkdown> allRecaps =
        await _meetingRepo.getMarkdownsForProject(projectId);

    final List<MeetingMarkdown> relevant =
        await _retriever.retrieve(allRecaps: allRecaps, question: question);

    final ChatResult result = await _analysis.complete(
      systemPrompt: QaPrompt.system,
      userPrompt: QaPrompt.user(
        projectName: project?.name ?? '—',
        projectDescription: project?.description ?? '',
        projectContext: context?.overviewMarkdown ?? '',
        meetingRecaps: relevant
            .map((MeetingMarkdown m) => m.contentMarkdown)
            .join('\n\n---\n\n'),
        question: question,
      ),
    );

    final _ParsedAnswer parsed = _parseAnswer(result.content);
    final List<String> citedIds =
        await _resolveCitations(projectId, parsed.citations);

    // Traccia il costo (SRD §8bis.6).
    final String usageId = _uuid.v4();
    final pricing = await _settingsRepo.getChatPricing(result.model);
    await _usageRepo.record(UsageRecord(
      id: usageId,
      projectId: projectId,
      operationType: UsageOperationType.qa,
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      estimatedCostUsd: CostEstimator.chat(
        inputTokens: result.inputTokens,
        outputTokens: result.outputTokens,
        pricing: pricing,
      ),
      timestamp: DateTime.now(),
    ));

    await _qaRepo.addMessage(ProjectQAMessage(
      id: _uuid.v4(),
      threadId: threadId,
      role: QaRole.assistant,
      content: parsed.body,
      timestamp: DateTime.now(),
      citedMeetingIds: citedIds,
      usageRecordId: usageId,
    ));
  }

  /// Separa il corpo della risposta dalla riga "CITED: …".
  _ParsedAnswer _parseAnswer(String content) {
    final List<String> lines = content.trimRight().split('\n');
    for (int i = lines.length - 1; i >= 0; i--) {
      final String line = lines[i].trim();
      if (line.toUpperCase().startsWith('CITED:')) {
        final String raw = line.substring(6).trim();
        final List<String> citations = (raw == '—' || raw.isEmpty)
            ? <String>[]
            : raw.split(';').map((String s) => s.trim()).where((String s) => s.isNotEmpty).toList();
        final String body = lines.sublist(0, i).join('\n').trimRight();
        return _ParsedAnswer(body: body, citations: citations);
      }
    }
    return _ParsedAnswer(body: content.trim(), citations: const <String>[]);
  }

  /// Best-effort: mappa i riferimenti citati (titolo/data) sugli id riunione.
  Future<List<String>> _resolveCitations(
    String projectId,
    List<String> citations,
  ) async {
    if (citations.isEmpty) return const <String>[];
    final List<Meeting> meetings =
        await _meetingRepo.getMeetingsForProject(projectId);
    final List<String> ids = <String>[];
    for (final String citation in citations) {
      final String c = citation.toLowerCase();
      for (final Meeting m in meetings) {
        if (c.contains(m.title.toLowerCase()) ||
            m.title.toLowerCase().contains(c)) {
          if (!ids.contains(m.id)) ids.add(m.id);
        }
      }
    }
    return ids;
  }
}

class _ParsedAnswer {
  const _ParsedAnswer({required this.body, required this.citations});
  final String body;
  final List<String> citations;
}
