import 'package:uuid/uuid.dart';

import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/meeting_status.dart';
import '../entities/project.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/project_repository.dart';
import 'brain_archive.dart';

/// Esito dell'import (per un riepilogo in UI).
class ImportBrainResult {
  const ImportBrainResult({required this.projects, required this.meetings});
  final int projects;
  final int meetings;
}

/// Importa un second brain da un documento Markdown esportato (§export).
/// Ricostruisce progetti, contesti e recap riunioni. Le registrazioni non
/// vengono importate (sono usa-e-getta): il recap Markdown è la fonte di verità.
class ImportBrain {
  ImportBrain({
    required ProjectRepository projectRepository,
    required MeetingRepository meetingRepository,
  })  : _projectRepo = projectRepository,
        _meetingRepo = meetingRepository;

  final ProjectRepository _projectRepo;
  final MeetingRepository _meetingRepo;
  static const Uuid _uuid = Uuid();

  Future<ImportBrainResult> call(String archive) async {
    final List<BrainProject> brain = BrainArchive.parse(archive);
    final List<Project> existing = await _projectRepo.getProjects();

    int projectCount = 0;
    int meetingCount = 0;

    for (final BrainProject bp in brain) {
      // Upsert progetto per nome.
      Project? project;
      for (final Project p in existing) {
        if (p.name.trim() == bp.name.trim()) {
          project = p;
          break;
        }
      }
      project ??= await _projectRepo.createProject(name: bp.name);
      projectCount++;

      if (bp.description.trim().isNotEmpty &&
          project.description.trim().isEmpty) {
        await _projectRepo.updateProject(
            project.copyWith(description: bp.description.trim()));
      }

      // Riunioni → Meeting completata + MeetingMarkdown (recap).
      for (final BrainMeeting bm in bp.meetings) {
        final Meeting meeting = await _meetingRepo.createMeeting(
          projectId: project.id,
          title: bm.title,
          userContext: bm.userContext.isEmpty ? null : bm.userContext,
        );
        await _meetingRepo
            .updateMeeting(meeting.copyWith(status: MeetingStatus.completed));
        await _meetingRepo.saveMarkdown(MeetingMarkdown(
          id: _uuid.v4(),
          meetingId: meeting.id,
          contentMarkdown: bm.recapMarkdown,
          generatedAt: bm.date ?? DateTime.now(),
        ));
        meetingCount++;
      }

      // Contesto di progetto (se presente nell'archivio).
      if (bp.contextMarkdown.trim().isNotEmpty) {
        await _projectRepo.saveContext(ProjectContext(
          id: _uuid.v4(),
          projectId: project.id,
          overviewMarkdown: bp.contextMarkdown.trim(),
          updatedAt: DateTime.now(),
          sourceMeetingIds: const <String>[],
        ));
      }
    }

    return ImportBrainResult(projects: projectCount, meetings: meetingCount);
  }
}
