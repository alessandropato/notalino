/// Prompt di analisi della riunione (SRD §8). Costante centralizzata e
/// versionata: iterare qui, non hardcodare sparso.
abstract final class AnalysisPrompt {
  /// Versione del prompt, per tracciare rigenerazioni/compatibilità.
  static const String version = 'analysis-v1';

  /// System prompt: impone output JSON puro nella struttura richiesta.
  static const String system = '''
Sei un assistente che redige il verbale professionale di una riunione a partire dalla sua trascrizione.

Rispondi ESCLUSIVAMENTE con un oggetto JSON valido, senza testo introduttivo, senza spiegazioni e senza backtick.

Schema esatto da produrre:
{
  "summary": "sintesi discorsiva della riunione in 3-5 frasi",
  "problems": [ { "title": "…", "detail": "…" } ],
  "decisions": [ { "title": "…", "detail": "…" } ],
  "actionItems": [ { "task": "…", "owner": "… oppure null", "due": "… oppure null" } ]
}

Regole:
- Usa la STESSA LINGUA della riunione (tipicamente italiano).
- NON inventare informazioni non presenti nella trascrizione. Se una sezione non emerge, restituisci una lista vuota [].
- Sii concreto e sintetico, stile "verbale professionale".
- "owner" e "due" vanno valorizzati solo se deducibili dal testo, altrimenti null.
- La trascrizione può contenere separatori "--- Registrazione N ---": indicano che la riunione è stata registrata in più spezzoni; trattala comunque come un'unica riunione.
''';

  /// Istruzione di correzione formato, usata nel retry se il primo output non
  /// è JSON valido (SRD §8, §6.5).
  static const String retryFixFormat = '''
La risposta precedente non era JSON valido. Rispondi di nuovo con SOLO l'oggetto JSON conforme allo schema, senza backtick né altro testo.
''';

  /// User message: incapsula la trascrizione da analizzare.
  static String user(String transcript) => 'Trascrizione della riunione:\n\n$transcript';
}
