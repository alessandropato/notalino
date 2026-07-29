import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/data/datasources/local/app_database.dart';
import 'package:notalino/domain/entities/meeting.dart';
import 'package:notalino/domain/entities/meeting_status.dart';
import 'package:notalino/domain/entities/project.dart';
import 'package:notalino/presentation/providers/core_providers.dart';
import 'package:notalino/presentation/providers/meeting_processing_controller.dart';

/// Test della riconciliazione degli stati "orfani" (SRD §6.5): una riunione
/// bloccata su transcribing/analyzing nel DB, senza un job realmente in corso
/// in questa sessione (es. l'app è stata chiusa a metà elaborazione), deve
/// diventare visibilmente riprovabile invece di restare bloccata per sempre.
void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() {
    container.dispose();
    db.close();
  });

  test(
      'riunione orfana in transcribing → failed riprovabile alla prima lettura del controller',
      () async {
    final projectRepo = container.read(projectRepositoryProvider);
    final meetingRepo = container.read(meetingRepositoryProvider);
    final Project project = await projectRepo.createProject(name: 'P');
    final Meeting meeting =
        await meetingRepo.createMeeting(projectId: project.id, title: 'M');
    await meetingRepo
        .updateMeeting(meeting.copyWith(status: MeetingStatus.transcribing));

    // Prima lettura del controller in questa sessione: nessun job reale è mai
    // stato avviato per questo meetingId, quindi lo stato "transcribing" nel
    // DB non può che essere un residuo di una sessione precedente interrotta.
    container.read(meetingProcessingProvider(meeting.id));
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final Meeting? updated = await meetingRepo.getMeeting(meeting.id);
    expect(updated!.status, MeetingStatus.failed);
    expect(updated.errorMessage, contains('interrotta'));

    final ProcessingState state =
        container.read(meetingProcessingProvider(meeting.id));
    expect(state.phase, ProcessingPhase.error);
  });

  test('riunione già completata non viene toccata dalla riconciliazione',
      () async {
    final projectRepo = container.read(projectRepositoryProvider);
    final meetingRepo = container.read(meetingRepositoryProvider);
    final Project project = await projectRepo.createProject(name: 'P');
    final Meeting meeting =
        await meetingRepo.createMeeting(projectId: project.id, title: 'M');
    await meetingRepo
        .updateMeeting(meeting.copyWith(status: MeetingStatus.completed));

    container.read(meetingProcessingProvider(meeting.id));
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final Meeting? updated = await meetingRepo.getMeeting(meeting.id);
    expect(updated!.status, MeetingStatus.completed);

    final ProcessingState state =
        container.read(meetingProcessingProvider(meeting.id));
    expect(state.phase, ProcessingPhase.idle);
  });
}
