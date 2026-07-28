import 'dart:convert';

/// Estrae un oggetto JSON da una risposta del modello in modo tollerante
/// (SRD §8): rimuove eventuali fence ```json, scarta testo introduttivo,
/// ritaglia dal primo `{` all'ultimo `}`. Ritorna null se non parsabile.
abstract final class JsonExtractor {
  static Map<String, dynamic>? extractObject(String raw) {
    String s = raw.trim();
    if (s.startsWith('```')) {
      s = s.replaceFirst(RegExp(r'^```[a-zA-Z]*'), '').trim();
      if (s.endsWith('```')) s = s.substring(0, s.length - 3).trim();
    }
    final int start = s.indexOf('{');
    final int end = s.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      s = s.substring(start, end + 1);
    }
    try {
      final Object? decoded = jsonDecode(s);
      return decoded is Map<String, dynamic> ? decoded : null;
    } on FormatException {
      return null;
    }
  }
}
