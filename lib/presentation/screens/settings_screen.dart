import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/openai_constants.dart';
import '../../core/constants/pricing_constants.dart';
import '../../core/utils/formatters.dart';
import '../providers/core_providers.dart';
import '../providers/settings_controller.dart';
import '../widgets/widgets.dart';

/// Impostazioni (SRD §10 schermata 6, §9, §12).
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _keyCtrl = TextEditingController();
  bool _testing = false;
  String? _testResult;

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    final AsyncValue<SettingsState> settings =
        ref.watch(settingsControllerProvider);

    return AppScaffold(
      appBar: AppBar(title: const Text('Impostazioni')),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, _) => Center(child: Text('Errore: $e')),
        data: (SettingsState s) => ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxl),
          children: [
            // --- API key ---
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(
                      title: 'API key OpenAI', eyebrow: 'Connessione'),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Icon(
                        s.hasApiKey ? Icons.check_circle : Icons.error_outline,
                        size: 18,
                        color: s.hasApiKey ? t.colors.success : t.colors.warning,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        s.hasApiKey
                            ? 'Chiave salvata in modo sicuro (Keychain)'
                            : 'Nessuna chiave impostata',
                        style: AppTypography.bodyMedium
                            .copyWith(color: t.colors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _keyCtrl,
                    label: 'Inserisci / aggiorna la chiave',
                    hint: 'sk-…',
                    obscure: true,
                    prefixIcon: Icons.key_outlined,
                    // Ricostruisce per aggiornare lo stato abilitato dei bottoni
                    // mentre l'utente digita/incolla la chiave.
                    onChanged: (_) => setState(() => _testResult = null),
                  ),
                  if (_testResult != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(_testResult!,
                        style: AppTypography.caption.copyWith(
                          color: _testResult!.startsWith('✓')
                              ? t.colors.success
                              : t.colors.error,
                        )),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'Test connessione',
                          loading: _testing,
                          expand: true,
                          onPressed: _keyCtrl.text.trim().isEmpty
                              ? null
                              : _testConnection,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Salva',
                          onPressed: _keyCtrl.text.trim().isEmpty
                              ? null
                              : () async {
                                  await ref
                                      .read(settingsControllerProvider.notifier)
                                      .saveApiKey(_keyCtrl.text.trim());
                                  _keyCtrl.clear();
                                  if (mounted) {
                                    setState(() => _testResult = null);
                                    _snack('Chiave salvata');
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'L\'audio e le trascrizioni vengono inviati ai server OpenAI per l\'elaborazione. La chiave non lascia mai il dispositivo se non come header di autorizzazione verso OpenAI.',
                    style: AppTypography.caption
                        .copyWith(color: t.colors.textTertiary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // --- Modello ---
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(title: 'Modello GPT', eyebrow: 'Analisi'),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: OpenAiConstants.selectableChatModels
                        .map((String m) => _ModelChip(
                              label: m,
                              selected: m == s.model,
                              onTap: () => ref
                                  .read(settingsControllerProvider.notifier)
                                  .setModel(m),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // --- Tariffe ---
            _PricingCard(state: s),
            const SizedBox(height: AppSpacing.lg),

            // --- Second brain (export/import) ---
            const _BrainCard(),
          ],
        ),
      ),
    );
  }

  Future<void> _testConnection() async {
    setState(() {
      _testing = true;
      _testResult = null;
    });
    final bool ok = await ref
        .read(settingsControllerProvider.notifier)
        .testApiKey(_keyCtrl.text.trim());
    if (!mounted) return;
    setState(() {
      _testing = false;
      _testResult = ok
          ? '✓ Connessione riuscita'
          : '✗ Chiave non valida o rete non raggiungibile';
    });
  }

  void _snack(String msg) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}

class _ModelChip extends StatelessWidget {
  const _ModelChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.rPill,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.sm + 2),
          decoration: BoxDecoration(
            color: selected
                ? t.colors.accentPrimary.withValues(alpha: 0.16)
                : t.colors.surface.withValues(alpha: 0.5),
            borderRadius: AppRadii.rPill,
            border: Border.all(
              color: selected ? t.colors.accentPrimary : t.colors.glassBorder,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.label.copyWith(
              color: selected ? t.colors.accentPrimary : t.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _PricingCard extends ConsumerWidget {
  const _PricingCard({required this.state});
  final SettingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTokens t = context.tokens;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Tariffe (stima costi)', eyebrow: 'Consumi'),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Valori usati per stimare i costi. Non sono la fattura reale OpenAI.',
            style: AppTypography.caption.copyWith(color: t.colors.textTertiary),
          ),
          const SizedBox(height: AppSpacing.lg),
          _RateRow(
            label: 'Whisper — \$/minuto',
            value: state.whisperPerMinuteUsd,
            onSubmit: (double v) => ref
                .read(settingsControllerProvider.notifier)
                .setWhisperRate(v),
          ),
          const SizedBox(height: AppSpacing.md),
          _RateRow(
            label: '${state.model} input — \$/1M token',
            value: state.chatPricing.inputPerMillionUsd,
            onSubmit: (double v) => ref
                .read(settingsControllerProvider.notifier)
                .setChatPricing(ModelPricing(
                  inputPerMillionUsd: v,
                  outputPerMillionUsd: state.chatPricing.outputPerMillionUsd,
                )),
          ),
          const SizedBox(height: AppSpacing.md),
          _RateRow(
            label: '${state.model} output — \$/1M token',
            value: state.chatPricing.outputPerMillionUsd,
            onSubmit: (double v) => ref
                .read(settingsControllerProvider.notifier)
                .setChatPricing(ModelPricing(
                  inputPerMillionUsd: state.chatPricing.inputPerMillionUsd,
                  outputPerMillionUsd: v,
                )),
          ),
        ],
      ),
    );
  }
}

class _RateRow extends StatefulWidget {
  const _RateRow({
    required this.label,
    required this.value,
    required this.onSubmit,
  });

  final String label;
  final double value;
  final ValueChanged<double> onSubmit;

  @override
  State<_RateRow> createState() => _RateRowState();
}

class _RateRowState extends State<_RateRow> {
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.value.toString());

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Row(
      children: [
        Expanded(
          child: Text(widget.label,
              style: AppTypography.bodyMedium
                  .copyWith(color: t.colors.textSecondary)),
        ),
        SizedBox(
          width: 110,
          child: AppTextField(
            controller: _ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (String v) {
              final double? parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null) widget.onSubmit(parsed);
            },
          ),
        ),
      ],
    );
  }
}

/// Export/Import del second brain in Markdown (§export). Le registrazioni non
/// sono incluse: il cuore è il .md (contesto progetti + recap riunioni).
class _BrainCard extends ConsumerStatefulWidget {
  const _BrainCard();

  @override
  ConsumerState<_BrainCard> createState() => _BrainCardState();
}

class _BrainCardState extends ConsumerState<_BrainCard> {
  bool _exporting = false;
  bool _importing = false;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Second brain', eyebrow: 'Backup'),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Esporta o importa tutto in Markdown (progetti, contesti e recap). Le registrazioni audio non sono incluse: il cuore è il .md.',
            style: AppTypography.caption.copyWith(color: t.colors.textTertiary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Esporta',
                  icon: Icons.ios_share,
                  loading: _exporting,
                  expand: true,
                  onPressed: _export,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: SecondaryButton(
                  label: 'Importa',
                  icon: Icons.download,
                  loading: _importing,
                  expand: true,
                  onPressed: _import,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _export() async {
    setState(() => _exporting = true);
    try {
      final String archive = await ref.read(exportBrainProvider).call();
      final Directory dir = await getTemporaryDirectory();
      final String name = 'notalino-brain-${Formatters.isoDate(DateTime.now())}.md';
      final File file = File(p.join(dir.path, name));
      await file.writeAsString(archive);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: 'Notalino second brain'),
      );
    } catch (e) {
      _snack('Errore export: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _import() async {
    setState(() => _importing = true);
    try {
      final FilePickerResult? res = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['md', 'markdown', 'txt'],
      );
      final String? path = res?.files.single.path;
      if (path == null) {
        if (mounted) setState(() => _importing = false);
        return;
      }
      final String content = await File(path).readAsString();
      final result = await ref.read(importBrainProvider).call(content);
      _snack(
          'Importati ${result.projects} progetti e ${result.meetings} riunioni.');
    } catch (e) {
      _snack('Errore import: $e');
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
