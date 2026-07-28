import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/openai_chat_api.dart';
import '../../data/datasources/remote/openai_client.dart';
import '../../data/datasources/remote/openai_transcription_api.dart';
import '../../data/repositories/drift_meeting_repository.dart';
import '../../data/repositories/drift_project_repository.dart';
import '../../data/repositories/drift_qa_repository.dart';
import '../../data/repositories/drift_usage_repository.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/services/ffmpeg_audio_processor.dart';
import '../../data/services/file_storage.dart';
import '../../data/services/knowledge_retrievers.dart';
import '../../data/services/openai_analysis_service.dart';
import '../../data/services/receive_share_intent_service.dart';
import '../../data/services/whisper_transcription_service.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/repositories/qa_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/usage_repository.dart';
import '../../domain/services/analysis_service.dart';
import '../../domain/services/audio_processor.dart';
import '../../domain/services/project_knowledge_retriever.dart';
import '../../domain/services/recording_file_store.dart';
import '../../domain/services/share_intent_service.dart';
import '../../domain/services/transcription_service.dart';
import '../../domain/usecases/analyze_meeting.dart';
import '../../domain/usecases/ask_project.dart';
import '../../domain/usecases/import_recordings.dart';
import '../../domain/usecases/transcribe_meeting.dart';
import '../../domain/usecases/update_project_context.dart';

/// Grafo di dependency injection (SRD §4). Un unico punto in cui i dettagli
/// (DB, API, servizi) vengono cablati; il resto dell'app dipende dalle
/// astrazioni tramite questi provider.

// ---------------- Infrastruttura ----------------

final Provider<AppDatabase> appDatabaseProvider = Provider<AppDatabase>((ref) {
  final AppDatabase db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final Provider<SettingsRepository> settingsRepositoryProvider =
    Provider<SettingsRepository>((ref) => SecureSettingsRepository());

final Provider<OpenAiClient> openAiClientProvider = Provider<OpenAiClient>((ref) {
  final SettingsRepository settings = ref.watch(settingsRepositoryProvider);
  return OpenAiClient(apiKeyProvider: settings.getApiKey);
});

// ---------------- Datasource remote ----------------

final Provider<OpenAiTranscriptionApi> transcriptionApiProvider =
    Provider<OpenAiTranscriptionApi>(
        (ref) => OpenAiTranscriptionApi(ref.watch(openAiClientProvider)));

final Provider<OpenAiChatApi> chatApiProvider =
    Provider<OpenAiChatApi>((ref) => OpenAiChatApi(ref.watch(openAiClientProvider)));

// ---------------- Servizi ----------------

final Provider<TranscriptionService> transcriptionServiceProvider =
    Provider<TranscriptionService>((ref) =>
        WhisperTranscriptionService(ref.watch(transcriptionApiProvider)));

final Provider<AnalysisService> analysisServiceProvider =
    Provider<AnalysisService>((ref) {
  final SettingsRepository settings = ref.watch(settingsRepositoryProvider);
  return OpenAiAnalysisService(
    chatApi: ref.watch(chatApiProvider),
    modelProvider: settings.getChatModel,
  );
});

final Provider<AudioProcessor> audioProcessorProvider =
    Provider<AudioProcessor>((ref) => const FfmpegAudioProcessor());

final Provider<RecordingFileStore> fileStoreProvider =
    Provider<RecordingFileStore>((ref) => const FileStorage());

final Provider<ShareIntentService> shareIntentServiceProvider =
    Provider<ShareIntentService>((ref) => const ReceiveShareIntentService());

final Provider<ProjectKnowledgeRetriever> retrieverProvider =
    Provider<ProjectKnowledgeRetriever>(
        (ref) => const DefaultKnowledgeRetriever());

// ---------------- Repository ----------------

final Provider<ProjectRepository> projectRepositoryProvider =
    Provider<ProjectRepository>(
        (ref) => DriftProjectRepository(ref.watch(appDatabaseProvider)));

final Provider<MeetingRepository> meetingRepositoryProvider =
    Provider<MeetingRepository>(
        (ref) => DriftMeetingRepository(ref.watch(appDatabaseProvider)));

final Provider<UsageRepository> usageRepositoryProvider =
    Provider<UsageRepository>(
        (ref) => DriftUsageRepository(ref.watch(appDatabaseProvider)));

final Provider<QaRepository> qaRepositoryProvider = Provider<QaRepository>(
    (ref) => DriftQaRepository(ref.watch(appDatabaseProvider)));

// ---------------- Use case ----------------

final Provider<ImportRecordings> importRecordingsProvider =
    Provider<ImportRecordings>((ref) => ImportRecordings(
          meetingRepository: ref.watch(meetingRepositoryProvider),
          fileStore: ref.watch(fileStoreProvider),
          audioProcessor: ref.watch(audioProcessorProvider),
        ));

final Provider<TranscribeMeeting> transcribeMeetingProvider =
    Provider<TranscribeMeeting>((ref) => TranscribeMeeting(
          meetingRepository: ref.watch(meetingRepositoryProvider),
          usageRepository: ref.watch(usageRepositoryProvider),
          settingsRepository: ref.watch(settingsRepositoryProvider),
          audioProcessor: ref.watch(audioProcessorProvider),
          transcriptionService: ref.watch(transcriptionServiceProvider),
        ));

final Provider<UpdateProjectContext> updateProjectContextProvider =
    Provider<UpdateProjectContext>((ref) => UpdateProjectContext(
          projectRepository: ref.watch(projectRepositoryProvider),
          meetingRepository: ref.watch(meetingRepositoryProvider),
          usageRepository: ref.watch(usageRepositoryProvider),
          settingsRepository: ref.watch(settingsRepositoryProvider),
          analysisService: ref.watch(analysisServiceProvider),
        ));

final Provider<AnalyzeMeeting> analyzeMeetingProvider =
    Provider<AnalyzeMeeting>((ref) => AnalyzeMeeting(
          meetingRepository: ref.watch(meetingRepositoryProvider),
          projectRepository: ref.watch(projectRepositoryProvider),
          usageRepository: ref.watch(usageRepositoryProvider),
          settingsRepository: ref.watch(settingsRepositoryProvider),
          analysisService: ref.watch(analysisServiceProvider),
          updateProjectContext: ref.watch(updateProjectContextProvider),
        ));

final Provider<AskProject> askProjectProvider =
    Provider<AskProject>((ref) => AskProject(
          projectRepository: ref.watch(projectRepositoryProvider),
          meetingRepository: ref.watch(meetingRepositoryProvider),
          qaRepository: ref.watch(qaRepositoryProvider),
          usageRepository: ref.watch(usageRepositoryProvider),
          settingsRepository: ref.watch(settingsRepositoryProvider),
          analysisService: ref.watch(analysisServiceProvider),
          retriever: ref.watch(retrieverProvider),
        ));
