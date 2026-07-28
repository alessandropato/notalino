import 'package:uuid/uuid.dart';

import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/meeting_report.dart';
import '../entities/meeting_status.dart';
import '../entities/project.dart';
import '../entities/recording.dart';
import '../entities/transcript.dart';
import '../entities/usage_record.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/project_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/usage_repository.dart';
import '../services/analysis_service.dart';
import 'cost_estimator.dart';
import 'generate_meeting_markdown.dart';
import 'update_project_context.dart';

/// Analizza la trascrizione aggregata e produce il verbale (SRD §6.3, §8):
/// report strutturato → MeetingMarkdown canonico → stato `completed` →
/// UsageRecord → aggiornamento del contesto di progetto.
class AnalyzeMeeting {
  AnalyzeMeeting({
    required MeetingRepository meetingRepository,
    required ProjectRepository projectRepository,
    required UsageRepository usageRepository,
    required SettingsRepository settingsRepository,
    required AnalysisService analysisService,
    required UpdateProjectContext updateProjectContext,
  })  : _meetingRepo = meetingRepository,
        _projectRepo = projectRepository,
        _usageRepo = usageRepository,
        _settingsRepo = settingsRepository,
        _analysis = analysisService,
        _updateContext = updateProjectContext;

  final MeetingRepository _meetingRepo;
  final ProjectRepository _projectRepo;
  final UsageRepository _usageRepo;
  final SettingsRepository _settingsRepo;
  final AnalysisService _analysis;
  final UpdateProjectContext _updateContext;
  static const Uuid _uuid = Uuid();

  Future<void> call(String meetingId) async {
    final Meeting? meeting = await _meetingRepo.getMeeting(meetingId);
    if (meeting == null) return;

    final Transcript? transcript = await _meetingRepo.getTranscript(meetingId);
    if (transcript == null || transcript.fullText.trim().isEmpty) {
      await _meetingRepo.updateMeeting(meeting.copyWith(
        status: MeetingStatus.failed,
        errorMessage: 'Nessuna trascrizione da analizzare.',
      ));
      return;
    }

    await _meetingRepo.updateMeeting(
      meeting.copyWith(status: MeetingStatus.analyzing, clearError: true),
    );

    try {
      final AnalysisResult result = await _analysis.analyzeTranscript(
        transcript.fullText,
        userContext: meeting.userContext,
      );

      final MeetingReport report = MeetingReport(
        id: _uuid.v4(),
        meetingId: meetingId,
        summary: result.summary,
        problems: result.problems,
        decisions: result.decisions,
        actionItems: result.actionItems,
        rawJson: result.rawJson,
        modelUsed: result.model,
        generatedAt: DateTime.now(),
      );
      await _meetingRepo.saveReport(report);

      // Genera il Markdown canonico (SRD §8ter.1).
      final Project? project = await _projectRepo.getProject(meeting.projectId);
      final List<Recording> recordings =
          await _meetingRepo.getRecordings(meetingId);
      final String markdown = GenerateMeetingMarkdown.call(
        meeting: meeting,
        projectName: project?.name ?? '—',
        recordings: recordings,
        report: report,
      );
      await _meetingRepo.saveMarkdown(MeetingMarkdown(
        id: _uuid.v4(),
        meetingId: meetingId,
        contentMarkdown: markdown,
        generatedAt: DateTime.now(),
      ));

      await _meetingRepo.updateMeeting(meeting.copyWith(
        status: MeetingStatus.completed,
        needsReanalysis: false,
        clearError: true,
      ));

      await _recordUsage(meeting, result);

      // Aggiorna il contesto di progetto (SRD §6.3.6). Non deve far fallire
      // l'analisi se va male: il verbale è comunque salvato.
      try {
        await _updateContext.call(meeting.projectId);
      } on Object {
        // Il contesto resterà disallineato; la UI lo segnala.
      }
    } on Object catch (e) {
      final Meeting? current = await _meetingRepo.getMeeting(meetingId);
      if (current != null) {
        await _meetingRepo.updateMeeting(current.copyWith(
          status: MeetingStatus.failed,
          errorMessage: e.toString(),
        ));
      }
      rethrow;
    }
  }

  Future<void> _recordUsage(Meeting meeting, AnalysisResult result) async {
    final pricing = await _settingsRepo.getChatPricing(result.model);
    await _usageRepo.record(UsageRecord(
      id: _uuid.v4(),
      meetingId: meeting.id,
      projectId: meeting.projectId,
      operationType: UsageOperationType.analysis,
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
