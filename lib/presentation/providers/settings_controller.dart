import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/pricing_constants.dart';
import '../../domain/repositories/settings_repository.dart';
import 'core_providers.dart';

/// Stato delle impostazioni (SRD §10.6, §9, §12).
class SettingsState {
  const SettingsState({
    required this.hasApiKey,
    required this.model,
    required this.whisperPerMinuteUsd,
    required this.chatPricing,
  });

  final bool hasApiKey;
  final String model;
  final double whisperPerMinuteUsd;
  final ModelPricing chatPricing;

  SettingsState copyWith({
    bool? hasApiKey,
    String? model,
    double? whisperPerMinuteUsd,
    ModelPricing? chatPricing,
  }) =>
      SettingsState(
        hasApiKey: hasApiKey ?? this.hasApiKey,
        model: model ?? this.model,
        whisperPerMinuteUsd: whisperPerMinuteUsd ?? this.whisperPerMinuteUsd,
        chatPricing: chatPricing ?? this.chatPricing,
      );
}

class SettingsController extends AsyncNotifier<SettingsState> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  Future<SettingsState> build() => _load();

  Future<SettingsState> _load() async {
    final String model = await _repo.getChatModel();
    return SettingsState(
      hasApiKey: await _repo.hasApiKey(),
      model: model,
      whisperPerMinuteUsd: await _repo.getWhisperPerMinuteUsd(),
      chatPricing: await _repo.getChatPricing(model),
    );
  }

  Future<void> saveApiKey(String key) async {
    await _repo.setApiKey(key);
    state = AsyncData(await _load());
  }

  Future<void> deleteApiKey() async {
    await _repo.deleteApiKey();
    state = AsyncData(await _load());
  }

  /// Test connessione: verifica la chiave contro OpenAI (SRD §10.6).
  Future<bool> testApiKey(String key) => _repo.testApiKey(key);

  Future<void> setModel(String model) async {
    await _repo.setChatModel(model);
    state = AsyncData(await _load());
  }

  Future<void> setWhisperRate(double value) async {
    await _repo.setWhisperPerMinuteUsd(value);
    state = AsyncData(await _load());
  }

  Future<void> setChatPricing(ModelPricing pricing) async {
    final SettingsState current = state.valueOrNull ?? await _load();
    await _repo.setChatPricing(current.model, pricing);
    state = AsyncData(await _load());
  }
}

final AsyncNotifierProvider<SettingsController, SettingsState>
    settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, SettingsState>(
        SettingsController.new);
