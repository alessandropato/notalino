import 'package:meta/meta.dart';

import 'meeting_status.dart';

/// Registro di consumo di una singola operazione OpenAI (SRD §5, §9).
/// Salva i valori grezzi E il costo stimato.
@immutable
class UsageRecord {
  const UsageRecord({
    required this.id,
    required this.operationType,
    required this.model,
    required this.estimatedCostUsd,
    required this.timestamp,
    this.meetingId,
    this.projectId,
    this.audioSeconds,
    this.inputTokens,
    this.outputTokens,
  });

  final String id;
  final String? meetingId;

  /// Progetto di riferimento (per il breakdown per progetto, SRD §9).
  final String? projectId;
  final UsageOperationType operationType;
  final String model;

  /// Durata audio processata (per Whisper).
  final int? audioSeconds;

  /// Token GPT (per analisi/contesto/Q&A).
  final int? inputTokens;
  final int? outputTokens;

  final double estimatedCostUsd;
  final DateTime timestamp;
}
