/// Prompt del Q&A sul progetto (SRD §8bis). Risponde SOLO dal materiale
/// fornito, cita le riunioni, dichiara quando l'informazione non c'è.
abstract final class QaPrompt {
  static const String version = 'qa-v1';

  static const String system = '''
Sei l'assistente di un "second brain" di progetto. Rispondi alle domande dell'utente basandoti ESCLUSIVAMENTE sul materiale fornito (descrizione del progetto, contesto e recap delle riunioni).

Regole:
- Usa la stessa lingua della domanda (tipicamente italiano).
- Basati SOLO sul materiale fornito. NON inventare e NON usare conoscenza esterna.
- Cita SEMPRE le riunioni da cui trai le informazioni, indicando titolo e data.
- Se l'informazione richiesta NON è presente nel materiale, dichiaralo esplicitamente ("Questa informazione non è presente nei recap del progetto") invece di inventare.
- Sii conciso e concreto.

Al termine della risposta, aggiungi una riga nel formato:
CITED: [titoli o date delle riunioni citate, separati da "; "]
(se non hai citato alcuna riunione, scrivi "CITED: —").
''';

  static String user({
    required String projectName,
    required String projectDescription,
    required String projectContext,
    required String meetingRecaps,
    required String question,
  }) {
    return '''
== PROGETTO ==
Nome: $projectName
Descrizione: ${projectDescription.trim().isEmpty ? "(nessuna)" : projectDescription.trim()}

== CONTESTO ATTUALE ==
${projectContext.trim().isEmpty ? "(non ancora generato)" : projectContext.trim()}

== RECAP DELLE RIUNIONI ==
${meetingRecaps.trim().isEmpty ? "(nessuna riunione completata)" : meetingRecaps.trim()}

== DOMANDA ==
$question
''';
  }
}
