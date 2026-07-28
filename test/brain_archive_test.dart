import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/domain/usecases/brain_archive.dart';

/// Test round-trip dell'archivio second brain (§export).
void main() {
  test('build → parse ricostruisce progetti e riunioni', () {
    final List<BrainProject> input = [
      BrainProject(
        name: 'Halligan',
        description: 'Progetto firmware',
        contextMarkdown: '# Halligan — Contesto\n\n## Di cosa tratta\nFirmware.',
        meetings: [
          BrainMeeting(
            title: 'Kickoff',
            date: DateTime(2026, 1, 15),
            userContext: 'Presenti io, Marco e Paolo',
            recapMarkdown: '# Kickoff\n\n## Sintesi\nAvvio del progetto.',
          ),
          const BrainMeeting(
            title: 'Review',
            recapMarkdown: '# Review\n\n## Sintesi\nRevisione firmware.',
          ),
        ],
      ),
      const BrainProject(name: 'Progetto vuoto'),
    ];

    final String archive = BrainArchive.build(input);
    final List<BrainProject> parsed = BrainArchive.parse(archive);

    expect(parsed.length, 2);
    expect(parsed[0].name, 'Halligan');
    expect(parsed[0].description, 'Progetto firmware');
    expect(parsed[0].contextMarkdown, contains('Di cosa tratta'));
    expect(parsed[0].meetings.length, 2);
    expect(parsed[0].meetings[0].title, 'Kickoff');
    expect(parsed[0].meetings[0].userContext, 'Presenti io, Marco e Paolo');
    expect(parsed[0].meetings[0].recapMarkdown, contains('Avvio del progetto.'));
    expect(parsed[0].meetings[0].date?.year, 2026);
    expect(parsed[1].name, 'Progetto vuoto');
    expect(parsed[1].meetings, isEmpty);
  });

  test('parse tollera archivio vuoto', () {
    expect(BrainArchive.parse(''), isEmpty);
  });
}
