import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/data/datasources/local/app_database.dart';
import 'package:notalino/data/repositories/drift_meeting_repository.dart';
import 'package:notalino/data/repositories/drift_project_repository.dart';
import 'package:notalino/data/repositories/drift_usage_repository.dart';
import 'package:notalino/domain/entities/meeting_status.dart';
import 'package:notalino/domain/entities/project.dart';
import 'package:notalino/domain/entities/recording.dart';
import 'package:notalino/domain/entities/transcript.dart';
import 'package:notalino/domain/repositories/settings_repository.dart';
import 'package:notalino/domain/services/audio_processor.dart';
import 'package:notalino/domain/services/transcription_service.dart';
import 'package:notalino/domain/usecases/transcribe_meeting.dart';

/// Test d'integrazione del percorso critico (SRD §16): due registrazioni
/// vengono trascritte e ricomposte in un unico transcript aggregato, con i
/// separatori corretti e gli UsageRecord generati.
void main() {
  late AppDatabase db;
  late DriftMeetingRepository meetingRepo;
  late DriftUsageRepository usageRepo;
  late DriftProjectRepository projectRepo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    meetingRepo = DriftMeetingRepository(db);
    usageRepo = DriftUsageRepository(db);
    projectRepo = DriftProjectRepository(db);
  });

  tearDown(() async => db.close());

  test('due registrazioni → transcript aggregato ordinato con separatore',
      () async {
    final Project project = await projectRepo.createProject(name: 'Halligan');
    final meeting = await meetingRepo.createMeeting(
        projectId: project.id, title: 'Kickoff');

    await meetingRepo.addRecording(Recording(
      id: 'rec-1',
      meetingId: meeting.id,
      orderIndex: 0,
      sourceFileName: 'parte1.m4a',
      localFilePath: '/tmp/parte1.m4a',
      fileSizeBytes: 1000,
      status: RecordingStatus.imported,
      createdAt: DateTime.now(),
    ));
    await meetingRepo.addRecording(Recording(
      id: 'rec-2',
      meetingId: meeting.id,
      orderIndex: 1,
      sourceFileName: 'parte2.m4a',
      localFilePath: '/tmp/parte2.m4a',
      fileSizeBytes: 1000,
      status: RecordingStatus.imported,
      createdAt: DateTime.now(),
    ));

    final usecase = TranscribeMeeting(
      meetingRepository: meetingRepo,
      usageRepository: usageRepo,
      settingsRepository: _FakeSettings(),
      audioProcessor: _FakeAudioProcessor(),
      transcriptionService: _FakeTranscription(<String, String>{
        '/tmp/parte1.m4a': 'Prima parte della riunione.',
        '/tmp/parte2.m4a': 'Seconda parte della riunione.',
      }),
    );

    await usecase.call(meeting.id);

    final Transcript? aggregate = await meetingRepo.getTranscript(meeting.id);
    expect(aggregate, isNotNull);
    expect(aggregate!.recordingCount, 2);
    expect(aggregate.fullText, contains('Prima parte della riunione.'));
    expect(aggregate.fullText, contains('Seconda parte della riunione.'));
    // La prima parte precede la seconda (ordine per orderIndex).
    expect(
      aggregate.fullText.indexOf('Prima parte'),
      lessThan(aggregate.fullText.indexOf('Seconda parte')),
    );
    // Separatore tra registrazioni (SRD §5).
    expect(aggregate.fullText, contains('--- Registrazione 2 ---'));

    // Stato riunione aggiornato.
    final updated = await meetingRepo.getMeeting(meeting.id);
    expect(updated!.status, MeetingStatus.transcribed);

    // Un UsageRecord di trascrizione per registrazione.
    final usage = await usageRepo.getForMeeting(meeting.id);
    expect(usage.length, 2);
    expect(usage.every((u) => u.operationType == UsageOperationType.transcription),
        isTrue);
  });

  test('registrazione già trascritta non viene ri-trascritta (no doppio costo)',
      () async {
    final Project project = await projectRepo.createProject(name: 'P');
    final meeting =
        await meetingRepo.createMeeting(projectId: project.id, title: 'M');
    await meetingRepo.addRecording(Recording(
      id: 'rec-a',
      meetingId: meeting.id,
      orderIndex: 0,
      sourceFileName: 'a.m4a',
      localFilePath: '/tmp/a.m4a',
      fileSizeBytes: 1000,
      status: RecordingStatus.transcribed, // già trascritta
      createdAt: DateTime.now(),
    ));
    await meetingRepo.saveRecordingTranscript(const RecordingTranscript(
      id: 't-a',
      recordingId: 'rec-a',
      text: 'Testo già presente.',
    ));

    final usecase = TranscribeMeeting(
      meetingRepository: meetingRepo,
      usageRepository: usageRepo,
      settingsRepository: _FakeSettings(),
      audioProcessor: _FakeAudioProcessor(),
      transcriptionService: _FakeTranscription(const <String, String>{}),
    );

    await usecase.call(meeting.id);

    // Nessuna chiamata di trascrizione → nessun UsageRecord.
    final usage = await usageRepo.getForMeeting(meeting.id);
    expect(usage, isEmpty);
    final aggregate = await meetingRepo.getTranscript(meeting.id);
    expect(aggregate!.fullText, contains('Testo già presente.'));
  });
}

/// Processore audio finto: un segmento per file, durata fissa.
class _FakeAudioProcessor implements AudioProcessor {
  @override
  Future<int?> probeDurationSeconds(String filePath) async => 120;

  @override
  Future<AudioChunkingResult> prepareForTranscription(String filePath) async =>
      AudioChunkingResult(segmentPaths: [filePath], durationSeconds: 120);
}

/// Trascrizione finta: mappa path → testo.
class _FakeTranscription implements TranscriptionService {
  _FakeTranscription(this._texts);
  final Map<String, String> _texts;

  @override
  Future<TranscriptionResult> transcribeFile(String filePath) async =>
      TranscriptionResult(
        text: _texts[filePath] ?? '',
        language: 'it',
        audioSeconds: 120,
      );
}

/// Impostazioni finte: solo la tariffa Whisper serve allo use case.
class _FakeSettings implements SettingsRepository {
  @override
  Future<double> getWhisperPerMinuteUsd() async => 0.006;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError(invocation.memberName.toString());
}
