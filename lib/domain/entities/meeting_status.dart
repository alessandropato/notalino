/// Stato aggregato di una riunione (SRD §5), derivato dagli stati delle sue
/// registrazioni.
enum MeetingStatus {
  draft,
  transcribing,
  transcribed,
  analyzing,
  completed,
  failed;

  static MeetingStatus fromName(String value) =>
      MeetingStatus.values.firstWhere((MeetingStatus s) => s.name == value,
          orElse: () => MeetingStatus.draft);
}

/// Stato di una singola registrazione (SRD §5, Recording).
enum RecordingStatus {
  imported,
  transcribing,
  transcribed,
  failed;

  static RecordingStatus fromName(String value) =>
      RecordingStatus.values.firstWhere((RecordingStatus s) => s.name == value,
          orElse: () => RecordingStatus.imported);
}

/// Tipo di operazione tracciata per i costi (SRD §5, UsageRecord).
enum UsageOperationType {
  transcription,
  analysis,
  contextUpdate,
  qa;

  static UsageOperationType fromName(String value) =>
      UsageOperationType.values.firstWhere((UsageOperationType s) => s.name == value,
          orElse: () => UsageOperationType.transcription);
}

/// Ruolo in un messaggio Q&A (SRD §5, ProjectQAMessage).
enum QaRole {
  user,
  assistant;

  static QaRole fromName(String value) => QaRole.values
      .firstWhere((QaRole r) => r.name == value, orElse: () => QaRole.user);
}
