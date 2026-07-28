import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../domain/services/recording_file_store.dart';

/// Copia i file audio importati nell'area persistente dell'app (SRD §6.1):
/// non si tiene il riferimento al file originale (che potrebbe sparire).
class FileStorage implements RecordingFileStore {
  const FileStorage();

  static const Uuid _uuid = Uuid();

  /// Copia [sourcePath] in `Documents/recordings/` con nome univoco.
  /// Ritorna il percorso persistente. Preserva l'estensione originale.
  @override
  Future<String> persistRecording(String sourcePath) async {
    final Directory docs = await getApplicationDocumentsDirectory();
    final Directory dir = Directory(p.join(docs.path, 'recordings'));
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final String ext = p.extension(sourcePath);
    final String destPath = p.join(dir.path, '${_uuid.v4()}$ext');
    await File(sourcePath).copy(destPath);
    return destPath;
  }

  /// Rimuove il file persistente di una registrazione, se esiste.
  @override
  Future<void> deleteRecordingFile(String path) async {
    final File f = File(path);
    if (f.existsSync()) await f.delete();
  }
}
