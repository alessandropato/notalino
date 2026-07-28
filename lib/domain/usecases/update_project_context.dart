import 'package:uuid/uuid.dart';

import '../../core/prompts/context_prompt.dart';
import '../../core/utils/formatters.dart';
import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/meeting_status.dart';
import '../entities/project.dart';
import '../entities/usage_record.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/project_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/usage_repository.dart';
import '../services/analysis_service.dart';
import 'cost_estimator.dart';

/// Rigenera il contesto vivo del progetto aggregando i recap Markdown delle
/// riunioni completate (SRD §6ter, §8ter.2). Operazione AI → UsageRecord.
class UpdateProjectContext {
  UpdateProjectContext({
    required ProjectRepository projectRepository,
    required MeetingRepository meetingRepository,
    required UsageRepository usageRepository,
    required SettingsRepository settingsRepository,
    required AnalysisService analysisService,
  })  : _projectRepo = projectRepository,
        _meetingRepo = meetingRepository,
        _usageRepo = usageRepository,
        _settingsRepo = settingsRepository,
        _analysis = analysisService;

  final ProjectRepository _projectRepo;
  final MeetingRepository _meetingRepo;
  final UsageRepository _usageRepo;
  final SettingsRepository _settingsRepo;
  final AnalysisService _analysis;
  static const Uuid _uuid = Uuid();

  Future<void> call(String projectId) async {
    final Project? project = await _projectRepo.getProject(projectId);
    if (project == null) return;

    final List<MeetingMarkdown> recaps =
        await _meetingRepo.getMarkdownsForProject(projectId);
    if (recaps.isEmpty) return;

    final List<Meeting> meetings =
        await _meetingRepo.getMeetingsForProject(projectId);
    final List<String> completedIds = meetings
        .where((Meeting m) => m.status == MeetingStatus.completed)
        .map((Meeting m) => m.id)
        .toList();

    final String joined =
        recaps.map((MeetingMarkdown m) => m.contentMarkdown).join('\n\n---\n\n');

    final ChatResult result = await _analysis.complete(
      systemPrompt: ContextPrompt.system,
      userPrompt: ContextPrompt.user(
        projectName: project.name,
        projectDescription: project.description,
        meetingRecaps: joined,
        meetingCount: recaps.length,
        today: Formatters.isoDate(DateTime.now()),
      ),
    );

    await _projectRepo.saveContext(ProjectContext(
      id: _uuid.v4(),
      projectId: projectId,
      overviewMarkdown: result.content.trim(),
      updatedAt: DateTime.now(),
      sourceMeetingIds: completedIds,
    ));

    await _recordUsage(projectId, result);
  }

  Future<void> _recordUsage(String projectId, ChatResult result) async {
    final pricing = await _settingsRepo.getChatPricing(result.model);
    await _usageRepo.record(UsageRecord(
      id: _uuid.v4(),
      projectId: projectId,
      operationType: UsageOperationType.contextUpdate,
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
  }
}
