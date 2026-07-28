import 'package:meta/meta.dart';

import 'meeting_status.dart';

/// Thread di domande su un progetto (SRD §5, §8bis).
@immutable
class ProjectQAThread {
  const ProjectQAThread({
    required this.id,
    required this.projectId,
    required this.title,
    required this.createdAt,
  });

  final String id;
  final String projectId;

  /// Derivabile dalla prima domanda.
  final String title;
  final DateTime createdAt;
}

/// Singolo messaggio (domanda utente o risposta AI) in un thread (SRD §5).
@immutable
class ProjectQAMessage {
  const ProjectQAMessage({
    required this.id,
    required this.threadId,
    required this.role,
    required this.content,
    required this.timestamp,
    this.citedMeetingIds = const <String>[],
    this.usageRecordId,
  });

  final String id;
  final String threadId;
  final QaRole role;
  final String content;
  final DateTime timestamp;

  /// Riunioni citate nella risposta (SRD §8bis: "indicazione delle riunioni
  /// citate nella risposta").
  final List<String> citedMeetingIds;

  /// Collega il costo della risposta (SRD §5).
  final String? usageRecordId;
}
