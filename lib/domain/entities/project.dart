import 'package:meta/meta.dart';

/// Progetto: contenitore di riunioni e second brain interrogabile (SRD §5).
@immutable
class Project {
  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.colorValue,
    this.iconCodePoint,
  });

  final String id; // UUID
  final String name;
  final String description; // editabile dall'utente, può essere vuota
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Colore/icona opzionali per la UI (SRD §5).
  final int? colorValue;
  final int? iconCodePoint;

  Project copyWith({
    String? name,
    String? description,
    DateTime? updatedAt,
    int? colorValue,
    int? iconCodePoint,
  }) =>
      Project(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        colorValue: colorValue ?? this.colorValue,
        iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      );
}

/// Contesto vivo del progetto (SRD §5, §6ter) — sintesi generata dall'AI.
@immutable
class ProjectContext {
  const ProjectContext({
    required this.id,
    required this.projectId,
    required this.overviewMarkdown,
    required this.updatedAt,
    required this.sourceMeetingIds,
  });

  final String id;
  final String projectId;

  /// Sintesi corrente dello stato del progetto (Markdown §8ter.2).
  final String overviewMarkdown;
  final DateTime updatedAt;

  /// Quali riunioni sono già incorporate (per aggiornamento incrementale).
  final List<String> sourceMeetingIds;
}
