/// Astrazione della ricezione file dalla share sheet / intent (SRD §3bis, §6).
/// iOS: share extension; Android: intent ACTION_SEND. Dietro questa interfaccia
/// così il resto dell'app non conosce la piattaforma.
abstract interface class ShareIntentService {
  /// File audio ricevuti mentre l'app era chiusa (all'avvio).
  Future<List<SharedAudioFile>> getInitialSharedFiles();

  /// Stream di file audio ricevuti mentre l'app è in foreground/background.
  Stream<List<SharedAudioFile>> sharedFilesStream();

  /// Segnala che i file iniziali sono stati consumati.
  void reset();
}

class SharedAudioFile {
  const SharedAudioFile({required this.path, required this.fileName});
  final String path;
  final String fileName;
}
