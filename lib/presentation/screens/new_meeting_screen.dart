import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/audio_constants.dart';
import '../../core/utils/formatters.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/project.dart';
import '../providers/core_providers.dart';
import '../providers/data_providers.dart';
import '../providers/meeting_processing_controller.dart';
import '../providers/settings_controller.dart';
import '../widgets/widgets.dart';
import 'meeting_detail_screen.dart';
import 'settings_screen.dart';

/// Nuova riunione / Import (SRD §6.1, §6bis, §10 schermata 5).
/// Riceve file già selezionati (share sheet) oppure lascia sceglierli in-app.
class NewMeetingScreen extends ConsumerStatefulWidget {
  const NewMeetingScreen({
    super.key,
    this.initialFilePaths = const <String>[],
    this.presetProjectId,
  });

  final List<String> initialFilePaths;
  final String? presetProjectId;

  @override
  ConsumerState<NewMeetingScreen> createState() => _NewMeetingScreenState();
}

class _NewMeetingScreenState extends ConsumerState<NewMeetingScreen> {
  static const String _newProjectSentinel = '__new__';

  final List<String> _files = <String>[];
  final TextEditingController _titleCtrl = TextEditingController();

  /// Scelta corrente: id progetto esistente, [_newProjectSentinel], o null.
  String? _projectChoice;
  final TextEditingController _newProjectCtrl = TextEditingController();
  bool _busy = false;

  bool get _creatingNewProject => _projectChoice == _newProjectSentinel;

  @override
  void initState() {
    super.initState();
    _files.addAll(widget.initialFilePaths);
    _projectChoice = widget.presetProjectId;
    _titleCtrl.text = 'Riunione ${Formatters.date(DateTime.now())}';
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _newProjectCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final AsyncValue<List<Project>> projects = ref.watch(projectsProvider);
    final AsyncValue<SettingsState> settings =
        ref.watch(settingsControllerProvider);
    final bool hasApiKey = settings.value?.hasApiKey ?? false;

    return AppScaffold(
      appBar: AppBar(title: const Text('Nuova riunione')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxl),
        children: [
          if (!hasApiKey)
            _ApiKeyWarning(
              onOpenSettings: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
              ),
            ),

          // --- File ---
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: 'Registrazioni',
                  eyebrow: 'Audio',
                  trailing: GhostButton(
                    label: 'Aggiungi',
                    icon: Icons.add,
                    onPressed: _pickFiles,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (_files.isEmpty)
                  Text(
                    'Nessun file selezionato. Aggiungi una o più registrazioni: verranno unite e analizzate come un\'unica riunione.',
                    style: AppTypography.bodyMedium
                        .copyWith(color: t.colors.textTertiary),
                  )
                else
                  ..._files.asMap().entries.map((MapEntry<int, String> e) =>
                      _FileRow(
                        index: e.key + 1,
                        path: e.value,
                        onRemove: () =>
                            setState(() => _files.removeAt(e.key)),
                      )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // --- Titolo ---
          GlassCard(
            child: AppTextField(
              controller: _titleCtrl,
              label: 'Titolo della riunione',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // --- Progetto ---
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader(title: 'Progetto', eyebrow: 'Organizza'),
                const SizedBox(height: AppSpacing.md),
                projects.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (Object e, _) => Text('Errore: $e'),
                  data: (List<Project> list) => RadioGroup<String>(
                    groupValue: _projectChoice,
                    onChanged: (String? v) =>
                        setState(() => _projectChoice = v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...list.map((Project p) => RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              title: Text(p.name,
                                  style: AppTypography.bodyLarge
                                      .copyWith(color: t.colors.textPrimary)),
                              value: p.id,
                              activeColor: t.colors.accentPrimary,
                            )),
                        RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Crea nuovo progetto',
                              style: AppTypography.bodyLarge
                                  .copyWith(color: t.colors.accentPrimary)),
                          value: _newProjectSentinel,
                          activeColor: t.colors.accentPrimary,
                        ),
                        if (_creatingNewProject)
                          Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.sm),
                            child: AppTextField(
                              controller: _newProjectCtrl,
                              hint: 'Nome del nuovo progetto',
                              // Riabilita il bottone "Crea" mentre si digita.
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          PrimaryButton(
            label: 'Crea e avvia elaborazione',
            icon: Icons.auto_awesome,
            loading: _busy,
            onPressed: _canSubmit(hasApiKey) ? _submit : null,
          ),
        ],
      ),
    );
  }

  bool _canSubmit(bool hasApiKey) {
    if (_busy || _files.isEmpty) return false;
    if (_creatingNewProject) return _newProjectCtrl.text.trim().isNotEmpty;
    return _projectChoice != null;
  }

  Future<void> _pickFiles() async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: AudioConstants.importableExtensions,
      allowMultiple: true,
    );
    if (result == null) return;
    setState(() {
      _files.addAll(result.files
          .map((PlatformFile f) => f.path)
          .whereType<String>());
    });
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      String projectId = _projectChoice ?? '';
      if (_creatingNewProject) {
        final Project created = await ref
            .read(projectRepositoryProvider)
            .createProject(name: _newProjectCtrl.text.trim());
        projectId = created.id;
      }

      final Meeting meeting =
          await ref.read(importRecordingsProvider).createMeetingWithFiles(
                projectId: projectId,
                title: _titleCtrl.text.trim().isEmpty
                    ? 'Riunione ${Formatters.date(DateTime.now())}'
                    : _titleCtrl.text.trim(),
                sourceFilePaths: _files,
              );

      // Avvia l'elaborazione in background (SRD §10: non bloccare la UI).
      unawaited(
        ref.read(meetingProcessingProvider(meeting.id).notifier).process(),
      );
      ref.invalidate(meetingCountsProvider);

      if (!mounted) return;
      unawaited(Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => MeetingDetailScreen(meetingId: meeting.id),
        ),
      ));
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Errore: $e')));
    }
  }
}

class _FileRow extends StatelessWidget {
  const _FileRow({
    required this.index,
    required this.path,
    required this.onRemove,
  });

  final int index;
  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final String name = path.split('/').last;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: t.colors.accentPrimary.withValues(alpha: 0.15),
            child: Text('$index',
                style: AppTypography.caption
                    .copyWith(color: t.colors.accentPrimary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium
                    .copyWith(color: t.colors.textPrimary)),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18, color: t.colors.textTertiary),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _ApiKeyWarning extends StatelessWidget {
  const _ApiKeyWarning({required this.onOpenSettings});
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: GlassCard(
        onTap: onOpenSettings,
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: t.colors.warning),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Manca la API key OpenAI. Toccami per aprire le Impostazioni.',
                style: AppTypography.bodyMedium
                    .copyWith(color: t.colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
