/// Parametri del chunking audio (SRD §7). Costanti configurabili, mai numeri
/// magici sparsi. Il chunking è lo split *tecnico* automatico di una singola
/// registrazione grande per rispettare il limite di Whisper (≠ registrazioni
/// multiple, che sono scelta dell'utente — §1bis).
abstract final class AudioConstants {
  /// Limite hard di Whisper per file singolo.
  static const int maxWhisperFileBytes = 25 * 1024 * 1024; // 25 MB

  /// Soglia con margine di sicurezza: oltre questa si spezza (SRD §7.2).
  static const int chunkThresholdBytes = 24 * 1024 * 1024; // 24 MB

  /// Durata target di un segmento (SRD §7.3): ~10 minuti.
  static const int segmentDurationSeconds = 600;

  /// Pre-normalizzazione (SRD §7.4): mono, 16 kHz, AAC a basso bitrate.
  /// La qualità 16 kHz mono è più che sufficiente per Whisper.
  static const int targetSampleRateHz = 16000;
  static const int targetChannels = 1; // mono
  static const int targetBitrateKbps = 32; // AAC ~32 kbps

  /// Overlap tra segmenti (SRD §7 nota). 0 nell'MVP: segmentazione pulita.
  /// Se emergono parole perse ai tagli, attivare + dedup in ricomposizione.
  static const int overlapSeconds = 0;

  /// Separatore leggibile tra le trascrizioni delle registrazioni nel testo
  /// aggregato (SRD §5, nota su `fullText`).
  static String recordingSeparator(int order) => '\n\n--- Registrazione $order ---\n\n';

  /// Estensioni audio importabili dal file picker (senza punto). Si usa
  /// `FileType.custom` con queste estensioni perché su iOS `FileType.audio`
  /// limita alla libreria musicale (esclude i Memo Vocali e i file in File).
  /// Set volutamente conservativo verso UTI iOS note per non far fallire il
  /// picker; i Memo Vocali dell'iPhone esportano `.m4a`.
  static const List<String> importableExtensions = <String>[
    'm4a', 'mp3', 'wav', 'aac', 'aiff', 'aif', 'caf', 'mp4', 'm4v', 'mov',
  ];
}
