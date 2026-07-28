/// Astrazione del servizio di trascrizione (SRD §11): permette di affiancare a
/// Whisper altre implementazioni (Deepgram/AssemblyAI, diarizzazione) senza
/// toccare il resto.
abstract interface class TranscriptionService {
  /// Trascrive un singolo file audio (già sotto il limite di dimensione).
  /// Ritorna testo e lingua rilevata.
  Future<TranscriptionResult> transcribeFile(String filePath);
}

class TranscriptionResult {
  const TranscriptionResult({
    required this.text,
    this.language,
    this.audioSeconds,
  });

  final String text;
  final String? language;
  final int? audioSeconds;
}
