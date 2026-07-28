import 'package:flutter_test/flutter_test.dart';
import 'package:notalino/core/utils/json_extractor.dart';

/// Test del parsing JSON tollerante dell'analisi (SRD §8, §13).
void main() {
  test('JSON puro', () {
    final Map<String, dynamic>? m =
        JsonExtractor.extractObject('{"summary":"ok","problems":[]}');
    expect(m?['summary'], 'ok');
  });

  test('rimuove i fence ```json', () {
    const String raw = '```json\n{"summary":"ok"}\n```';
    expect(JsonExtractor.extractObject(raw)?['summary'], 'ok');
  });

  test('scarta testo introduttivo attorno all\'oggetto', () {
    const String raw =
        'Ecco il verbale richiesto:\n{"summary":"ok"}\nSpero sia utile.';
    expect(JsonExtractor.extractObject(raw)?['summary'], 'ok');
  });

  test('ritorna null su input non-JSON', () {
    expect(JsonExtractor.extractObject('non è json'), isNull);
  });

  test('ritorna null su array (serve un oggetto)', () {
    expect(JsonExtractor.extractObject('[1,2,3]'), isNull);
  });
}
