import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_status.dart';
import '../../domain/entities/qa.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../widgets/widgets.dart';

/// Chat Q&A su un progetto (SRD §8bis, §10 schermata 3).
class QaThreadScreen extends ConsumerStatefulWidget {
  const QaThreadScreen({
    super.key,
    required this.projectId,
    required this.threadId,
    required this.title,
  });

  final String projectId;
  final String threadId;
  final String title;

  @override
  ConsumerState<QaThreadScreen> createState() => _QaThreadScreenState();
}

class _QaThreadScreenState extends ConsumerState<QaThreadScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ProjectQAMessage>> messages =
        ref.watch(qaMessagesProvider(widget.threadId));
    final AppTokens t = context.tokens;

    return AppScaffold(
      appBar: AppBar(title: Text(widget.title, overflow: TextOverflow.ellipsis)),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object e, _) => Center(child: Text('Errore: $e')),
              data: (List<ProjectQAMessage> list) {
                if (list.isEmpty && !_sending) {
                  return const EmptyState(
                    icon: Icons.help_outline,
                    title: 'Fai una domanda',
                    message:
                        'Es. "Cosa avevamo deciso sul budget?" o "Quali action item sono ancora aperti?"',
                  );
                }
                return ListView(
                  controller: _scroll,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    for (final ProjectQAMessage m in list)
                      _MessageBubble(message: m, projectId: widget.projectId),
                    if (_sending) const _TypingBubble(),
                  ],
                );
              },
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(_error!,
                  style: AppTypography.caption.copyWith(color: t.colors.error)),
            ),
          _Composer(
            controller: _ctrl,
            sending: _sending,
            onSend: _send,
          ),
        ],
      ),
    );
  }

  Future<void> _send() async {
    final String question = _ctrl.text.trim();
    if (question.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    _ctrl.clear();

    // Titolo del thread derivato dalla prima domanda (SRD §5).
    final List<ProjectQAMessage> existing =
        ref.read(qaMessagesProvider(widget.threadId)).value ?? const [];
    if (existing.isEmpty) {
      final String title =
          question.length > 60 ? '${question.substring(0, 60)}…' : question;
      await ref
          .read(qaRepositoryProvider)
          .updateThreadTitle(widget.threadId, title);
    }

    try {
      await ref.read(askProjectProvider).ask(
            threadId: widget.threadId,
            projectId: widget.projectId,
            question: question,
          );
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }
}

class _MessageBubble extends ConsumerWidget {
  const _MessageBubble({required this.message, required this.projectId});
  final ProjectQAMessage message;
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTokens t = context.tokens;
    final bool isUser = message.role == QaRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.82),
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: isUser ? t.colors.accentGradient : null,
          color: isUser ? null : t.colors.glassSurface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadii.lg),
            topRight: const Radius.circular(AppRadii.lg),
            bottomLeft: Radius.circular(isUser ? AppRadii.lg : AppRadii.sm),
            bottomRight: Radius.circular(isUser ? AppRadii.sm : AppRadii.lg),
          ),
          border: isUser
              ? null
              : Border.all(color: t.colors.glassBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: AppTypography.bodyLarge.copyWith(
                color: isUser ? Colors.white : t.colors.textPrimary,
              ),
            ),
            if (message.citedMeetingIds.isNotEmpty)
              _Citations(
                  meetingIds: message.citedMeetingIds, projectId: projectId),
          ],
        ),
      ),
    );
  }
}

class _Citations extends ConsumerWidget {
  const _Citations({required this.meetingIds, required this.projectId});
  final List<String> meetingIds;
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTokens t = context.tokens;
    final AsyncValue<List<Meeting>> meetings =
        ref.watch(projectMeetingsProvider(projectId));
    final List<Meeting> all = meetings.value ?? const [];
    final List<Meeting> cited =
        all.where((Meeting m) => meetingIds.contains(m.id)).toList();
    if (cited.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.xs,
        children: [
          for (final Meeting m in cited)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: 2),
              decoration: BoxDecoration(
                color: t.colors.accentPrimary.withValues(alpha: 0.12),
                borderRadius: AppRadii.rPill,
              ),
              child: Text('↳ ${m.title}',
                  style: AppTypography.caption
                      .copyWith(color: t.colors.accentPrimary)),
            ),
        ],
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: t.colors.glassSurface,
          borderRadius: AppRadii.rLg,
          border: Border.all(color: t.colors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(t.colors.accentPrimary)),
            ),
            const SizedBox(width: AppSpacing.md),
            Text('Sto consultando i recap…',
                style: AppTypography.bodyMedium
                    .copyWith(color: t.colors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: controller,
                hint: 'Scrivi una domanda…',
                maxLines: 4,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            GestureDetector(
              onTap: sending ? null : onSend,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: t.colors.accentGradient,
                  shape: BoxShape.circle,
                ),
                child: sending
                    ? const Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                      )
                    : const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
