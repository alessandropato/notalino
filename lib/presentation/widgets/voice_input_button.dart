import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

import '../../app/theme/app_tokens.dart';
import '../../core/constants/openai_constants.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/usage_record.dart';
import '../../domain/usecases/cost_estimator.dart';
import '../providers/core_providers.dart';

enum _VoiceState { idle, recording, transcribing }

/// Pulsante "nota vocale": registra un breve audio, lo trascrive con Whisper
/// (riusa il [TranscriptionService] già usato per le riunioni) e passa il
/// testo risultante a [onTranscribed]. L'audio non viene conservato: è solo
/// un tramite verso il testo.
class VoiceInputButton extends ConsumerStatefulWidget {
  const VoiceInputButton({super.key, required this.onTranscribed, this.size = 22});

  final ValueChanged<String> onTranscribed;
  final double size;

  @override
  ConsumerState<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends ConsumerState<VoiceInputButton> {
  static const Uuid _uuid = Uuid();

  final AudioRecorder _recorder = AudioRecorder();
  _VoiceState _state = _VoiceState.idle;
  Timer? _ticker;
  int _elapsedSeconds = 0;

  @override
  void dispose() {
    _ticker?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;

    switch (_state) {
      case _VoiceState.transcribing:
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(t.colors.accentPrimary),
            ),
          ),
        );
      case _VoiceState.recording:
        return GestureDetector(
          onTap: _stopAndTranscribe,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatElapsed(_elapsedSeconds),
                style: TextStyle(
                  fontSize: 12,
                  color: t.colors.error,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.stop_circle_rounded, size: widget.size, color: t.colors.error),
            ],
          ),
        );
      case _VoiceState.idle:
        return IconButton(
          tooltip: 'Nota vocale',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(Icons.mic_none_rounded, size: widget.size, color: t.colors.textSecondary),
          onPressed: _start,
        );
    }
  }

  String _formatElapsed(int seconds) {
    final int m = seconds ~/ 60;
    final int s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _start() async {
    final bool granted = await _recorder.hasPermission();
    if (!granted) {
      _showMessage('Serve il permesso al microfono per le note vocali.');
      return;
    }
    final Directory tmp = await getTemporaryDirectory();
    final String path = p.join(tmp.path, 'notalino_voice_${_uuid.v4()}.m4a');
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        sampleRate: 16000,
        numChannels: 1,
        bitRate: 32000,
      ),
      path: path,
    );
    _elapsedSeconds = 0;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsedSeconds++);
    });
    if (mounted) setState(() => _state = _VoiceState.recording);
  }

  Future<void> _stopAndTranscribe() async {
    _ticker?.cancel();
    final String? path = await _recorder.stop();
    if (!mounted) return;

    final int recordedSeconds = _elapsedSeconds;
    if (path == null || recordedSeconds < 1) {
      setState(() => _state = _VoiceState.idle);
      return;
    }

    setState(() => _state = _VoiceState.transcribing);
    try {
      final result = await ref.read(transcriptionServiceProvider).transcribeFile(path);
      final String text = result.text.trim();
      if (text.isNotEmpty) widget.onTranscribed(text);
      if (text.isEmpty) _showMessage('Non ho sentito nulla di trascrivibile.');
      // Traccia il costo come per le riunioni (SRD §9): anche una nota vocale
      // consuma Whisper e deve comparire nella spesa reale.
      if ((result.audioSeconds ?? 0) > 0) {
        final double rate =
            await ref.read(settingsRepositoryProvider).getWhisperPerMinuteUsd();
        await ref.read(usageRepositoryProvider).record(UsageRecord(
              id: _uuid.v4(),
              operationType: UsageOperationType.transcription,
              model: OpenAiConstants.transcriptionModel,
              audioSeconds: result.audioSeconds,
              estimatedCostUsd: CostEstimator.transcription(
                audioSeconds: result.audioSeconds!,
                whisperPerMinuteUsd: rate,
              ),
              timestamp: DateTime.now(),
            ));
      }
    } catch (e) {
      _showMessage('Trascrizione non riuscita: ${e.toString().replaceFirst("Exception: ", "")}');
    } finally {
      unawaited(_deleteQuietly(path));
      if (mounted) setState(() => _state = _VoiceState.idle);
    }
  }

  Future<void> _deleteQuietly(String path) async {
    try {
      final File f = File(path);
      if (f.existsSync()) await f.delete();
    } on Object {
      // Best-effort: la trascrizione è già stata completata o fallita.
    }
  }

  void _showMessage(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
