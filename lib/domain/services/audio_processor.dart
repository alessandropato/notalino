/// Astrazione dell'elaborazione audio per il chunking (SRD §7, §11).
/// L'implementazione concreta usa ffmpeg; il dominio non lo sa.
abstract interface class AudioProcessor {
  /// Ricava la durata in secondi di un file audio, se possibile.
  Future<int?> probeDurationSeconds(String filePath);

  /// Prepara un file per Whisper: se sotto la soglia, ritorna un singolo
  /// segmento (eventualmente ricompresso); se sopra, lo spezza per durata in
  /// più segmenti sotto il limite di dimensione (SRD §7).
  ///
  /// Ritorna i percorsi dei segmenti in ordine, più il conteggio.
  Future<AudioChunkingResult> prepareForTranscription(String filePath);
}

class AudioChunkingResult {
  const AudioChunkingResult({
    required this.segmentPaths,
    required this.durationSeconds,
  });

  /// Percorsi dei segmenti pronti per la trascrizione, in ordine.
  final List<String> segmentPaths;
  final int? durationSeconds;

  int get chunkCount => segmentPaths.length;
}
