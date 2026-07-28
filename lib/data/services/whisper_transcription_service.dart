import '../../domain/services/transcription_service.dart';
import '../datasources/remote/openai_transcription_api.dart';

/// Implementazione di [TranscriptionService] basata su Whisper (SRD §3).
/// Trascrive un singolo file già sotto il limite di dimensione; il chunking dei
/// file grandi è orchestrato a monte dallo use case con l'[AudioProcessor].
class WhisperTranscriptionService implements TranscriptionService {
  WhisperTranscriptionService(this._api);

  final OpenAiTranscriptionApi _api;

  @override
  Future<TranscriptionResult> transcribeFile(String filePath) =>
      _api.transcribe(filePath);
}
