import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_markdown.dart';
import '../../domain/entities/meeting_report.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/qa.dart';
import '../../domain/entities/recording.dart';
import '../../domain/entities/transcript.dart';
import '../../domain/entities/usage_record.dart';
import 'core_providers.dart';

/// Provider di sola lettura sui dati (stream reattivi da Drift). I tipi dei
/// provider family sono inferiti (in Riverpod 3 i tipi `*ProviderFamily` non
/// sono più esposti pubblicamente).

// ---------------- Progetti ----------------

final StreamProvider<List<Project>> projectsProvider =
    StreamProvider<List<Project>>(
        (ref) => ref.watch(projectRepositoryProvider).watchProjects());

final FutureProvider<Map<String, int>> meetingCountsProvider =
    FutureProvider<Map<String, int>>(
        (ref) => ref.watch(projectRepositoryProvider).meetingCounts());

final projectProvider = FutureProvider.family<Project?, String>(
    (ref, String id) => ref.watch(projectRepositoryProvider).getProject(id));

final projectContextProvider =
    StreamProvider.family<ProjectContext?, String>((ref, String projectId) =>
        ref.watch(projectRepositoryProvider).watchContext(projectId));

// ---------------- Riunioni ----------------

final projectMeetingsProvider =
    StreamProvider.family<List<Meeting>, String>((ref, String projectId) =>
        ref.watch(meetingRepositoryProvider).watchMeetingsForProject(projectId));

final meetingProvider =
    StreamProvider.family<Meeting?, String>((ref, String meetingId) =>
        ref.watch(meetingRepositoryProvider).watchMeeting(meetingId));

final recordingsProvider =
    StreamProvider.family<List<Recording>, String>((ref, String meetingId) =>
        ref.watch(meetingRepositoryProvider).watchRecordings(meetingId));

final reportProvider =
    FutureProvider.family<MeetingReport?, String>((ref, String meetingId) {
  // Si ricarica quando la riunione cambia stato.
  ref.watch(meetingProvider(meetingId));
  return ref.watch(meetingRepositoryProvider).getReport(meetingId);
});

final markdownProvider =
    FutureProvider.family<MeetingMarkdown?, String>((ref, String meetingId) {
  ref.watch(meetingProvider(meetingId));
  return ref.watch(meetingRepositoryProvider).getMarkdown(meetingId);
});

final transcriptProvider =
    FutureProvider.family<Transcript?, String>((ref, String meetingId) {
  ref.watch(meetingProvider(meetingId));
  return ref.watch(meetingRepositoryProvider).getTranscript(meetingId);
});

// ---------------- Q&A ----------------

final qaThreadsProvider =
    StreamProvider.family<List<ProjectQAThread>, String>((ref, String projectId) =>
        ref.watch(qaRepositoryProvider).watchThreads(projectId));

final qaMessagesProvider =
    StreamProvider.family<List<ProjectQAMessage>, String>((ref, String threadId) =>
        ref.watch(qaRepositoryProvider).watchMessages(threadId));

// ---------------- Consumi ----------------

final StreamProvider<List<UsageRecord>> usageProvider =
    StreamProvider<List<UsageRecord>>(
        (ref) => ref.watch(usageRepositoryProvider).watchAll());
