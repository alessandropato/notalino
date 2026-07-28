/// Rappresentazione del "second brain" per export/import in Markdown (§export).
/// Le registrazioni sono usa-e-getta: il cuore è il Markdown (contesto progetto
/// + recap riunioni), round-trippabile.
library;

class BrainMeeting {
  const BrainMeeting({
    required this.title,
    required this.recapMarkdown,
    this.date,
    this.userContext = '',
  });

  final String title;
  final DateTime? date;
  final String userContext;
  final String recapMarkdown;
}

class BrainProject {
  const BrainProject({
    required this.name,
    this.description = '',
    this.contextMarkdown = '',
    this.meetings = const <BrainMeeting>[],
  });

  final String name;
  final String description;
  final String contextMarkdown;
  final List<BrainMeeting> meetings;
}

/// Costruisce e analizza l'archivio Markdown del second brain. Formato a
/// sezioni delimitate da marcatori `@@` a inizio riga (i recap generati non
/// iniziano mai una riga con `@@`, quindi il parsing è robusto).
abstract final class BrainArchive {
  static const String version = 'notalino-archive v1';

  static String _oneLine(String s) =>
      s.replaceAll('\r', ' ').replaceAll('\n', ' · ').trim();

  static String build(List<BrainProject> projects, {DateTime? exportedAt}) {
    final StringBuffer b = StringBuffer()
      ..writeln('# NOTALINO SECOND BRAIN')
      ..writeln('<!-- $version -->')
      ..writeln('<!-- esportato: ${(exportedAt ?? DateTime.now()).toIso8601String()} -->')
      ..writeln();

    for (final BrainProject p in projects) {
      b
        ..writeln('@@PROJECT')
        ..writeln('name: ${_oneLine(p.name)}')
        ..writeln('description: ${_oneLine(p.description)}')
        ..writeln();
      if (p.contextMarkdown.trim().isNotEmpty) {
        b
          ..writeln('@@CONTEXT')
          ..writeln(p.contextMarkdown.trim())
          ..writeln();
      }
      for (final BrainMeeting m in p.meetings) {
        b
          ..writeln('@@MEETING')
          ..writeln('title: ${_oneLine(m.title)}')
          ..writeln('date: ${m.date?.toIso8601String() ?? ''}')
          ..writeln('context: ${_oneLine(m.userContext)}')
          ..writeln()
          ..writeln(m.recapMarkdown.trim())
          ..writeln();
      }
    }
    return b.toString().trimRight();
  }

  static List<BrainProject> parse(String archive) {
    final List<String> lines = archive.split('\n');
    final List<_MutableProject> projects = <_MutableProject>[];
    _MutableProject? currentProject;

    int i = 0;
    while (i < lines.length) {
      final String line = lines[i];
      if (line.trimRight() == '@@PROJECT') {
        i++;
        final Map<String, String> header = <String, String>{};
        while (i < lines.length && lines[i].trim().isNotEmpty && !_isMarker(lines[i])) {
          _readHeader(lines[i], header);
          i++;
        }
        currentProject = _MutableProject(
          name: header['name'] ?? 'Senza nome',
          description: header['description'] ?? '',
        );
        projects.add(currentProject);
      } else if (line.trimRight() == '@@CONTEXT') {
        i++;
        final String body = _readBody(lines, () => i, (int v) => i = v);
        if (currentProject != null) currentProject.contextMarkdown = body;
      } else if (line.trimRight() == '@@MEETING') {
        i++;
        final Map<String, String> header = <String, String>{};
        while (i < lines.length && lines[i].trim().isNotEmpty && !_isMarker(lines[i])) {
          _readHeader(lines[i], header);
          i++;
        }
        // salta l'eventuale riga vuota tra header e corpo
        if (i < lines.length && lines[i].trim().isEmpty) i++;
        final String body = _readBody(lines, () => i, (int v) => i = v);
        currentProject?.meetings.add(BrainMeeting(
          title: header['title'] ?? 'Riunione',
          date: DateTime.tryParse(header['date'] ?? ''),
          userContext: header['context'] ?? '',
          recapMarkdown: body,
        ));
      } else {
        i++;
      }
    }

    return projects
        .map((_MutableProject p) => BrainProject(
              name: p.name,
              description: p.description,
              contextMarkdown: p.contextMarkdown,
              meetings: p.meetings,
            ))
        .toList();
  }

  static bool _isMarker(String line) {
    final String t = line.trimRight();
    return t == '@@PROJECT' || t == '@@CONTEXT' || t == '@@MEETING';
  }

  static void _readHeader(String line, Map<String, String> into) {
    final int c = line.indexOf(':');
    if (c > 0) {
      into[line.substring(0, c).trim()] = line.substring(c + 1).trim();
    }
  }

  /// Legge il corpo (fino al prossimo marcatore) e aggiorna l'indice.
  static String _readBody(List<String> lines, int Function() get, void Function(int) set) {
    int j = get();
    final StringBuffer body = StringBuffer();
    while (j < lines.length && !_isMarker(lines[j])) {
      body.writeln(lines[j]);
      j++;
    }
    set(j);
    return body.toString().trim();
  }
}

class _MutableProject {
  _MutableProject({required this.name, required this.description});
  final String name;
  final String description;
  String contextMarkdown = '';
  final List<BrainMeeting> meetings = <BrainMeeting>[];
}
