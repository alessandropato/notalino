import 'package:dio/dio.dart';

import '../../../core/constants/openai_constants.dart';
import 'openai_client.dart';

/// Esito grezzo di una chat completion (contenuto + uso token).
class ChatCompletionResponse {
  const ChatCompletionResponse({
    required this.content,
    required this.model,
    required this.inputTokens,
    required this.outputTokens,
  });

  final String content;
  final String model;
  final int inputTokens;
  final int outputTokens;
}

/// Chiamata a `POST /v1/chat/completions` (SRD §3, §8).
class OpenAiChatApi {
  OpenAiChatApi(this._client);

  final OpenAiClient _client;

  Future<ChatCompletionResponse> complete({
    required String model,
    required String systemPrompt,
    required String userPrompt,
    bool jsonMode = false,
    double temperature = 0.3,
  }) async {
    final Options options = await _client.authorizedOptions();
    final Map<String, dynamic> body = <String, dynamic>{
      'model': model,
      'temperature': temperature,
      'messages': <Map<String, String>>[
        <String, String>{'role': 'system', 'content': systemPrompt},
        <String, String>{'role': 'user', 'content': userPrompt},
      ],
      if (jsonMode)
        'response_format': <String, String>{'type': 'json_object'},
    };

    try {
      final Response<dynamic> res = await _client.dio.post<dynamic>(
        OpenAiConstants.chatCompletionsPath,
        data: body,
        options: options,
      );
      final Map<String, dynamic> data =
          (res.data as Map).cast<String, dynamic>();
      final List<dynamic> choices = (data['choices'] as List<dynamic>?) ?? [];
      final String content = choices.isEmpty
          ? ''
          : (((choices.first as Map)['message'] as Map)['content'] as String? ??
              '');
      final Map<String, dynamic> usage =
          ((data['usage'] as Map?) ?? const {}).cast<String, dynamic>();
      return ChatCompletionResponse(
        content: content,
        model: (data['model'] as String?) ?? model,
        inputTokens: (usage['prompt_tokens'] as int?) ?? 0,
        outputTokens: (usage['completion_tokens'] as int?) ?? 0,
      );
    } on DioException catch (e) {
      OpenAiClient.mapError(e);
    }
  }
}
