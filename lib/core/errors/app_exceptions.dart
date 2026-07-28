/// Eccezioni tipizzate dell'app (SRD §6.5, §13). Niente catch silenziosi:
/// ogni errore ha un tipo e un messaggio leggibile per la UI.
sealed class AppException implements Exception {
  const AppException(this.message);

  /// Messaggio in italiano, mostrabile all'utente.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// API key OpenAI mancante nelle impostazioni.
class ApiKeyMissingException extends AppException {
  const ApiKeyMissingException()
      : super('Manca la API key OpenAI. Inseriscila nelle Impostazioni.');
}

/// API key rifiutata dal server (HTTP 401).
class ApiKeyInvalidException extends AppException {
  const ApiKeyInvalidException()
      : super('La API key OpenAI non è valida (401). Controlla in Impostazioni.');
}

/// File audio oltre il limite e impossibile da segmentare.
class FileTooLargeException extends AppException {
  const FileTooLargeException(super.message);
}

/// Errore durante l'elaborazione audio (ffmpeg).
class AudioProcessingException extends AppException {
  const AudioProcessingException(super.message);
}

/// Errore di rete / timeout verso OpenAI.
class NetworkException extends AppException {
  const NetworkException(super.message, {this.isRetryable = true});
  final bool isRetryable;
}

/// Il server OpenAI ha risposto con un errore generico (5xx / 4xx non 401).
class OpenAiApiException extends AppException {
  const OpenAiApiException(super.message, {this.statusCode});
  final int? statusCode;
}

/// Il modello ha restituito un JSON non parsabile per l'analisi (SRD §8).
class AnalysisParseException extends AppException {
  const AnalysisParseException(super.message, {required this.rawJson});

  /// Output grezzo salvato per debug/rigenerazione (SRD §5 MeetingReport.rawJson).
  final String rawJson;
}

/// Errore di accesso ai dati locali (Drift / file system).
class DataException extends AppException {
  const DataException(super.message);
}
