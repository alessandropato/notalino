import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/core/prompts/markdown_templates.dart';
import 'package:notalino/domain/entities/meeting_report.dart';

/// Test del template Markdown canonico di riunione (SRD §8ter.1, §13).
void main() {
  MeetingReport report({
    List<ProblemItem> problems = const [],
    List<DecisionItem> decisions = const [],
    List<ActionItem> actions = const [],
  }) =>
      MeetingReport(
        id: 'r1',
        meetingId: 'm1',
        summary: 'Sintesi di prova.',
        problems: problems,
        decisions: decisions,
        actionItems: actions,
        rawJson: '{}',
        modelUsed: 'gpt-4o',
        generatedAt: DateTime(2026, 1, 15),
      );

  test('sezioni sempre presenti nell\'ordine dato', () {
    final String md = MarkdownTemplates.meeting(
      title: 'Kickoff',
      projectName: 'Halligan',
      date: DateTime(2026, 1, 15),
      recordingCount: 2,
      totalDuration: '01:05',
      report: report(),
    );
    final int sintesi = md.indexOf('## Sintesi');
    final int problematiche = md.indexOf('## Problematiche');
    final int decisioni = md.indexOf('## Decisioni');
    final int cose = md.indexOf('## Cose da fare');
    expect(sintesi, greaterThan(0));
    expect(problematiche, greaterThan(sintesi));
    expect(decisioni, greaterThan(problematiche));
    expect(cose, greaterThan(decisioni));
  });

  test('liste vuote riportano "_Nessuna._"', () {
    final String md = MarkdownTemplates.meeting(
      title: 'Kickoff',
      projectName: 'Halligan',
      date: DateTime(2026, 1, 15),
      recordingCount: 1,
      totalDuration: '00:30',
      report: report(),
    );
    expect(md.contains('_Nessuna._'), isTrue);
  });

  test('gli action item usano checkbox Markdown', () {
    final String md = MarkdownTemplates.meeting(
      title: 'Kickoff',
      projectName: 'Halligan',
      date: DateTime(2026, 1, 15),
      recordingCount: 1,
      totalDuration: '00:30',
      report: report(
        actions: [const ActionItem(task: 'Inviare preventivo', owner: 'Mario')],
      ),
    );
    expect(md.contains('- [ ] Inviare preventivo'), isTrue);
    expect(md.contains('Mario'), isTrue);
  });

  test('include i metadati progetto/registrazioni', () {
    final String md = MarkdownTemplates.meeting(
      title: 'Kickoff',
      projectName: 'Halligan',
      date: DateTime(2026, 1, 15),
      recordingCount: 3,
      totalDuration: '01:20',
      report: report(),
    );
    expect(md.contains('**Progetto:** Halligan'), isTrue);
    expect(md.contains('**Registrazioni:** 3'), isTrue);
    expect(md.contains('01:20'), isTrue);
  });
}
