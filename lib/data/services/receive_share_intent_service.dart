import 'package:path/path.dart' as p;
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../domain/services/share_intent_service.dart';

/// Implementazione di [ShareIntentService] con `receive_sharing_intent`
/// (SRD §3bis, §6). Su iOS richiede una Share Extension configurata in Xcode
/// (App Group `group.it.maketron.notalino`) — vedi CLAUDE.md §6/§11.
class ReceiveShareIntentService implements ShareIntentService {
  const ReceiveShareIntentService();

  static const Set<String> _audioExtensions = <String>{
    '.m4a', '.mp3', '.wav', '.aac', '.aiff', '.aif', '.caf',
    '.ogg', '.oga', '.flac', '.mp4', '.mov', '.opus', '.wma',
  };

  static bool _isAudio(String path) =>
      _audioExtensions.contains(p.extension(path).toLowerCase());

  List<SharedAudioFile> _map(List<SharedMediaFile> files) => files
      .where((SharedMediaFile f) => _isAudio(f.path))
      .map((SharedMediaFile f) =>
          SharedAudioFile(path: f.path, fileName: p.basename(f.path)))
      .toList();

  @override
  Future<List<SharedAudioFile>> getInitialSharedFiles() async {
    final List<SharedMediaFile> files =
        await ReceiveSharingIntent.instance.getInitialMedia();
    return _map(files);
  }

  @override
  Stream<List<SharedAudioFile>> sharedFilesStream() =>
      ReceiveSharingIntent.instance.getMediaStream().map(_map);

  @override
  void reset() => ReceiveSharingIntent.instance.reset();
}
