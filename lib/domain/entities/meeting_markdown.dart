import 'package:meta/meta.dart';

/// Rappresentazione Markdown canonica di una riunione (SRD §5, §8ter.1):
/// il recap schematico "second brain", derivato dal [MeetingReport].
@immutable
class MeetingMarkdown {
  const MeetingMarkdown({
    required this.id,
    required this.meetingId,
    required this.contentMarkdown,
    required this.generatedAt,
  });

  final String id;
  final String meetingId;
  final String contentMarkdown;
  final DateTime generatedAt;
}
