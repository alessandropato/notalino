/// Prompt per generare/aggiornare il contesto vivo del progetto (SRD §6ter,
/// §8ter.2). Aggrega i MeetingMarkdown in una scheda cumulativa.
abstract final class ContextPrompt {
  static const String version = 'context-v1';

  static const String system = '''
Sei un assistente che mantiene aggiornata la "scheda di contesto" viva di un progetto, aggregando i recap delle sue riunioni.

Rispondi ESCLUSIVAMENTE con Markdown valido secondo QUESTO template, senza testo extra né backtick:

# {Nome progetto} — Contesto

{descrizione generale del progetto, se presente}

## Di cosa tratta
{sintesi cumulativa dello scopo e stato del progetto}

## Decisioni chiave (cumulative)
- {decisione} — *(riunione: {titolo/data})*

## Questioni aperte
- {questione} — *(emersa in: {titolo/data})*

## Prossimi passi
- [ ] {azione aperta} — *da: {titolo/data}*

## Riunioni
- {data} — {titolo} — {una riga di sintesi}

---
*Aggiornato il {data} · basato su {n} riunioni*

Regole:
- Usa la lingua dei recap (tipicamente italiano).
- Ogni voce chiave riporta la riunione di provenienza (titolo/data), così la fonte è tracciabile.
- Se una sezione è vuota, scrivi "_Nessuna._".
- NON inventare: usa solo ciò che emerge dai recap forniti e dalla descrizione del progetto.
- Sii sintetico e cumulativo: rifletti l'evoluzione del progetto, non elencare tutto verbatim.
''';

  /// Costruisce il messaggio utente con descrizione + recap delle riunioni.
  static String user({
    required String projectName,
    required String projectDescription,
    required String meetingRecaps,
    required int meetingCount,
    required String today,
  }) {
    return '''
Progetto: $projectName
Descrizione (intento dichiarato dall'utente): ${projectDescription.trim().isEmpty ? "(nessuna)" : projectDescription.trim()}
Data odierna: $today
Numero riunioni: $meetingCount

Recap delle riunioni (Markdown canonico):

$meetingRecaps
''';
  }
}
