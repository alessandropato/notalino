import '../../core/prompts/markdown_templates.dart';
import '../../core/utils/formatters.dart';
import '../entities/meeting.dart';
import '../entities/meeting_report.dart';
import '../entities/recording.dart';

/// Genera il Markdown canonico di una riunione dai dati strutturati (SRD
/// §8ter.1). Il Markdown è una proiezione derivata, non la fonte primaria.
abstract final class GenerateMeetingMarkdown {
  static String call({
    required Meeting meeting,
    required String projectName,
    required List<Recording> recordings,
    required MeetingReport report,
  }) {
    final int? totalSeconds = recordings.fold<int?>(0, (int? acc, Recording r) {
      if (acc == null) return null;
      final int? d = r.audioDurationSeconds;
      return d == null ? null : acc + d;
    });

    return MarkdownTemplates.meeting(
      title: meeting.title,
      projectName: projectName,
      date: meeting.createdAt,
      recordingCount: recordings.length,
      totalDuration: Formatters.hhmm(totalSeconds),
      report: report,
      userContext: meeting.userContext,
    );
  }
}
