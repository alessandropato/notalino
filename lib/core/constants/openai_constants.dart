/// Endpoint e modelli OpenAI (SRD §3, §8). Nessun backend proprietario:
/// tutte le chiamate partono dal client.
abstract final class OpenAiConstants {
  static const String baseUrl = 'https://api.openai.com/v1';
  static const String transcriptionsPath = '/audio/transcriptions';
  static const String chatCompletionsPath = '/chat/completions';
  static const String modelsPath = '/models';

  /// Modello di trascrizione (SRD §3).
  static const String transcriptionModel = 'whisper-1';

  /// Modello di analisi/Q&A/contesto di default (SRD §3, configurabile in
  /// Impostazioni).
  static const String defaultChatModel = 'gpt-4o';

  /// Modelli chat selezionabili in Impostazioni.
  static const List<String> selectableChatModels = <String>[
    'gpt-4o',
    'gpt-4o-mini',
    'gpt-4.1',
    'gpt-4.1-mini',
  ];
}
