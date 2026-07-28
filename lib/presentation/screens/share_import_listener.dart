import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/share_intent_service.dart';
import '../providers/core_providers.dart';
import 'new_meeting_screen.dart';

/// Ascolta i file audio in arrivo dalla share sheet / intent e li instrada alla
/// schermata di import (SRD §6). Avvolge la home.
///
/// NB: su iOS richiede la Share Extension configurata in Xcode (App Group
/// `group.it.maketron.notalino`) — vedi CLAUDE.md. Nel frattempo l'import
/// funziona comunque tramite file picker in-app.
class ShareImportListener extends ConsumerStatefulWidget {
  const ShareImportListener({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ShareImportListener> createState() =>
      _ShareImportListenerState();
}

class _ShareImportListenerState extends ConsumerState<ShareImportListener> {
  StreamSubscription<List<SharedAudioFile>>? _sub;

  @override
  void initState() {
    super.initState();
    final ShareIntentService service = ref.read(shareIntentServiceProvider);

    // File ricevuti mentre l'app è in foreground/background.
    _sub = service.sharedFilesStream().listen(_handle);

    // File ricevuti all'avvio (app chiusa).
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<SharedAudioFile> initial =
          await service.getInitialSharedFiles();
      if (initial.isNotEmpty) {
        _handle(initial);
        service.reset();
      }
    });
  }

  void _handle(List<SharedAudioFile> files) {
    if (files.isEmpty || !mounted) return;
    final List<String> paths =
        files.map((SharedAudioFile f) => f.path).toList();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NewMeetingScreen(initialFilePaths: paths),
      ),
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
