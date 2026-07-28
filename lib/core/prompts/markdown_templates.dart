import '../../domain/entities/meeting_report.dart';

/// Template Markdown canonici (SRD §8ter), costanti versionate come il prompt
/// di analisi. Il Markdown è una **proiezione derivata** dei dati del DB
/// (source of truth), rigenerabile in qualsiasi momento.
abstract final class MarkdownTemplates {
  static const String version = 'markdown-v1';

  static const String _emptyList = '_Nessuna._';

  /// Markdown di riunione (SRD §8ter.1). Sezioni sempre presenti nell'ordine
  /// dato; liste vuote → "_Nessuna._"; action item come checkbox.
  static String meeting({
    required String title,
    required String projectName,
    required DateTime date,
    required int recordingCount,
    required String totalDuration, // "hh:mm"
    required MeetingReport report,
    String? notes,
  }) {
    final StringBuffer b = StringBuffer()
      ..writeln('# $title')
      ..writeln()
      ..writeln('- **Progetto:** $projectName')
      ..writeln('- **Data:** ${_date(date)}')
      ..writeln(
          '- **Registrazioni:** $recordingCount · **Durata totale:** $totalDuration')
      ..writeln()
      ..writeln('## Sintesi')
      ..writeln(report.summary.trim().isEmpty ? _emptyList : report.summary.trim())
      ..writeln()
      ..writeln('## Problematiche');
    if (report.problems.isEmpty) {
      b.writeln(_emptyList);
    } else {
      for (final ProblemItem p in report.problems) {
        b.writeln('- **${p.title}** — ${p.detail}');
      }
    }
    b
      ..writeln()
      ..writeln('## Decisioni');
    if (report.decisions.isEmpty) {
      b.writeln(_emptyList);
    } else {
      for (final DecisionItem d in report.decisions) {
        b.writeln('- **${d.title}** — ${d.detail}');
      }
    }
    b
      ..writeln()
      ..writeln('## Cose da fare');
    if (report.actionItems.isEmpty) {
      b.writeln(_emptyList);
    } else {
      for (final ActionItem a in report.actionItems) {
        b.writeln(
            '- [ ] ${a.task} — *responsabile:* ${a.owner ?? "—"} · *scadenza:* ${a.due ?? "—"}');
      }
    }
    b
      ..writeln()
      ..writeln('## Note')
      ..writeln((notes == null || notes.trim().isEmpty) ? _emptyList : notes.trim());
    return b.toString().trimRight();
  }

  static String _date(DateTime d) =>
      '${d.year}-${_pad(d.month)}-${_pad(d.day)}';
  static String _pad(int n) => n.toString().padLeft(2, '0');
}
