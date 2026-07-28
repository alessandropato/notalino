/// Astrazione della persistenza dei file audio importati (SRD §6.1).
/// Mantiene il dominio indipendente dal file system concreto.
abstract interface class RecordingFileStore {
  /// Copia il file sorgente nell'area persistente e ritorna il nuovo percorso.
  Future<String> persistRecording(String sourcePath);

  /// Rimuove il file persistente, se esiste.
  Future<void> deleteRecordingFile(String path);
}
