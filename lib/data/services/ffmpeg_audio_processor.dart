import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/media_information.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/audio_constants.dart';
import '../../core/errors/app_exceptions.dart';
import '../../domain/services/audio_processor.dart';

/// Implementazione di [AudioProcessor] con ffmpeg (SRD §7).
/// Strategia: pre-normalizza a mono/16kHz/AAC a basso bitrate (riduce
/// drasticamente la dimensione); se il risultato è ancora sopra soglia, lo
/// segmenta per durata in blocchi sotto il limite di Whisper.
class FfmpegAudioProcessor implements AudioProcessor {
  const FfmpegAudioProcessor();

  static const Uuid _uuid = Uuid();

  @override
  Future<int?> probeDurationSeconds(String filePath) async {
    final session = await FFprobeKit.getMediaInformation(filePath);
    final MediaInformation? info = session.getMediaInformation();
    final String? duration = info?.getDuration();
    if (duration == null) return null;
    final double? seconds = double.tryParse(duration);
    return seconds?.round();
  }

  @override
  Future<AudioChunkingResult> prepareForTranscription(String filePath) async {
    final Directory tmp = await getTemporaryDirectory();
    final Directory workDir =
        Directory(p.join(tmp.path, 'notalino_audio', _uuid.v4()));
    await workDir.create(recursive: true);

    // 1. Pre-normalizzazione a formato compatto (SRD §7.4).
    final String normalized = p.join(workDir.path, 'normalized.m4a');
    await _run(
      '-y -i "$filePath" '
      '-ac ${AudioConstants.targetChannels} '
      '-ar ${AudioConstants.targetSampleRateHz} '
      '-c:a aac -b:a ${AudioConstants.targetBitrateKbps}k '
      '"$normalized"',
      'normalizzazione audio',
    );

    final int? durationSeconds = await probeDurationSeconds(normalized);
    final int normalizedSize = await File(normalized).length();

    // 2. Se sta sotto soglia, una sola chiamata (SRD §7.2).
    if (normalizedSize <= AudioConstants.chunkThresholdBytes) {
      return AudioChunkingResult(
        segmentPaths: [normalized],
        durationSeconds: durationSeconds,
      );
    }

    // 3. Altrimenti segmenta per durata (SRD §7.3).
    final String pattern = p.join(workDir.path, 'seg_%03d.m4a');
    await _run(
      '-y -i "$normalized" '
      '-f segment -segment_time ${AudioConstants.segmentDurationSeconds} '
      '-c:a aac -b:a ${AudioConstants.targetBitrateKbps}k '
      '"$pattern"',
      'segmentazione audio',
    );

    final List<String> segments = workDir
        .listSync()
        .whereType<File>()
        .map((f) => f.path)
        .where((path) => p.basename(path).startsWith('seg_'))
        .toList()
      ..sort();

    if (segments.isEmpty) {
      throw const AudioProcessingException(
        'La segmentazione audio non ha prodotto alcun blocco.',
      );
    }

    return AudioChunkingResult(
      segmentPaths: segments,
      durationSeconds: durationSeconds,
    );
  }

  Future<void> _run(String command, String label) async {
    final session = await FFmpegKit.execute(command);
    final ReturnCode? rc = await session.getReturnCode();
    if (!ReturnCode.isSuccess(rc)) {
      final String? trace = await session.getFailStackTrace();
      throw AudioProcessingException(
        'Errore ffmpeg durante $label (codice ${rc?.getValue()}).'
        '${trace != null && trace.isNotEmpty ? ' $trace' : ''}',
      );
    }
  }
}
