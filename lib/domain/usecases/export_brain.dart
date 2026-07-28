import '../entities/meeting.dart';
import '../entities/meeting_markdown.dart';
import '../entities/project.dart';
import '../repositories/meeting_repository.dart';
import '../repositories/project_repository.dart';
import 'brain_archive.dart';

/// Esporta l'intero second brain (progetti, contesti, recap riunioni) in un
/// unico documento Markdown round-trippabile (§export).
class ExportBrain {
  ExportBrain({
    required ProjectRepository projectRepository,
    required MeetingRepository meetingRepository,
  })  : _projectRepo = projectRepository,
        _meetingRepo = meetingRepository;

  final ProjectRepository _projectRepo;
  final MeetingRepository _meetingRepo;

  Future<String> call() async {
    final List<Project> projects = await _projectRepo.getProjects();
    final List<BrainProject> brain = <BrainProject>[];

    for (final Project p in projects) {
      final ProjectContext? ctx = await _projectRepo.getContext(p.id);
      final List<Meeting> meetings =
          await _meetingRepo.getMeetingsForProject(p.id);

      final List<BrainMeeting> brainMeetings = <BrainMeeting>[];
      for (final Meeting m in meetings) {
        final MeetingMarkdown? md = await _meetingRepo.getMarkdown(m.id);
        if (md == null) continue; // esporta solo riunioni con recap
        brainMeetings.add(BrainMeeting(
          title: m.title,
          date: m.createdAt,
          userContext: m.userContext ?? '',
          recapMarkdown: md.contentMarkdown,
        ));
      }

      brain.add(BrainProject(
        name: p.name,
        description: p.description,
        contextMarkdown: ctx?.overviewMarkdown ?? '',
        meetings: brainMeetings,
      ));
    }

    return BrainArchive.build(brain);
  }
}
