import 'package:meta/meta.dart';

/// Problematica emersa nella riunione (SRD §5, §8).
@immutable
class ProblemItem {
  const ProblemItem({required this.title, required this.detail});
  final String title;
  final String detail;
}

/// Decisione presa nella riunione (SRD §5, §8).
@immutable
class DecisionItem {
  const DecisionItem({required this.title, required this.detail});
  final String title;
  final String detail;
}

/// Cosa fare (action item), con responsabile/scadenza se deducibili (SRD §8).
@immutable
class ActionItem {
  const ActionItem({required this.task, this.owner, this.due});
  final String task;
  final String? owner;
  final String? due;
}

/// Verbale AI strutturato di una riunione (SRD §5, MeetingReport).
@immutable
class MeetingReport {
  const MeetingReport({
    required this.id,
    required this.meetingId,
    required this.summary,
    required this.problems,
    required this.decisions,
    required this.actionItems,
    required this.rawJson,
    required this.modelUsed,
    required this.generatedAt,
  });

  final String id;
  final String meetingId;
  final String summary;
  final List<ProblemItem> problems;
  final List<DecisionItem> decisions;
  final List<ActionItem> actionItems;

  /// Output JSON grezzo del modello, per debug/rigenerazione (SRD §5).
  final String rawJson;
  final String modelUsed;
  final DateTime generatedAt;
}
