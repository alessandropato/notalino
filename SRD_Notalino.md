# Software Requirement Document — Notalino

> **App**: Notalino — trascrizione e analisi AI delle riunioni
> **Publisher**: Maketron ([maketron.it](https://www.maketron.it))

> **Documento di specifica per lo sviluppo.** Questo file va passato a Claude Code come punto di partenza. La prima azione richiesta a Claude Code è la creazione di un file `CLAUDE.md` che funga da *second brain* del progetto (vedi §14).

---

## 1. Visione del prodotto

App mobile (Flutter, focus iOS) che consente di importare una registrazione audio di una riunione — condivisa dai Memo Vocali dell'iPhone/Apple Watch, dall'app Note o da qualsiasi app tramite la *share sheet* di iOS — e di ottenere automaticamente:

1. la **trascrizione** completa dell'audio (via OpenAI Whisper);
2. un **verbale strutturato** generato da AI (via OpenAI GPT): sintesi, problematiche emerse, decisioni prese, cose da fare (action items);
3. l'organizzazione delle riunioni in **progetti** (es. "Progetto Halligan").

Una singola riunione può essere composta da **più registrazioni separate** caricate dall'utente (es. una riunione registrata in 3 spezzoni distinti): tutte le registrazioni di una stessa riunione vengono trascritte, concatenate in ordine e analizzate come **un'unica riunione**, producendo un solo verbale complessivo. Vedi §5 e §6bis.

Ogni progetto è un **second brain interrogabile**: apre su un **contesto di progetto** vivo (una scheda che riassume di cosa tratta il progetto e come si è evoluto attraverso le riunioni), contiene l'**elenco delle riunioni passate** (ognuna con il suo recap schematico) e permette di **fare domande in linguaggio naturale sull'intero progetto** ottenendo risposte generate dall'AI a partire dai contenuti delle riunioni. Vedi §5, §6ter e §8bis.

L'app è **minimale nell'uso** ma **curata esteticamente**: interfaccia moderna in stile *liquid glass* / vetro smerigliato, palette chiara, tanto respiro, tipografia pulita.

**Filosofia**: nessun backend proprietario in questa fase. L'utente inserisce la propria **API key OpenAI** nelle impostazioni; l'app parla direttamente con le API OpenAI. Database **locale** sul device. Tutto ciò che serve per funzionare vive sul telefono più le chiamate alle API OpenAI.

---

## 1bis. Identità dell'app

- **Nome prodotto**: **Notalino**
- **Nome visualizzato** (home screen iOS/Android): `Notalino`
- **Publisher / owner**: Maketron — [www.maketron.it](https://www.maketron.it)
- **Bundle identifier iOS** (`PRODUCT_BUNDLE_IDENTIFIER`): `it.maketron.notalino`
- **Application ID Android** (`applicationId`): `it.maketron.notalino`
- **App group / share extension iOS** (per ricevere file dalla share sheet): `group.it.maketron.notalino`
- **Nome package Flutter / progetto**: `notalino`
- **Copyright**: © Maketron
- **URL di supporto / privacy** (placeholder da confermare): sotto dominio `maketron.it` (es. `https://www.maketron.it/notalino`)

Convenzioni derivate:
- Eventuali sotto-identificatori (widget, extension, notification service) usano il prefisso `it.maketron.notalino.*`.
- Lo schema URL personalizzato, se servirà per il deep linking, è `notalino://`.
- Asset di branding (icona, splash) vanno in un set dedicato e referenziati dal design system; il nome "Notalino" e l'eventuale wordmark seguono la tipografia dei token (§10bis).

Impostare questi valori fin dalla creazione del progetto (fase 1) per evitare rework su bundle id e signing.

**Utente singolo** (il committente): professionista che fa riunioni con clienti e partner e vuole verbali automatici organizzati per progetto.

**Caso d'uso canonico**:
1. L'utente registra una riunione con i Memo Vocali (anche 1 ora → ~100 MB).
2. Apre i Memo Vocali, tocca "Condividi", sceglie questa app.
3. L'app riceve il file, chiede in quale progetto inserirlo (o crea un nuovo progetto).
4. L'app trascrive (spezzando il file se necessario) e genera il verbale.
5. L'utente consulta il verbale strutturato dentro il progetto.

**Variante importante — riunione in più registrazioni**: capita che una stessa riunione sia registrata in **2 o 3 file separati** (interruzioni, batteria, pause). L'utente deve poter **aggiungere più registrazioni alla stessa riunione**, anche in momenti diversi. L'app le tratta come un unico insieme: le trascrive tutte, le concatena nell'ordine indicato dall'utente e genera **un solo verbale** per l'intera riunione.

> **Attenzione a non confondere due concetti diversi** (entrambi presenti nell'app):
> - **Registrazioni multiple** (livello utente): più file che *l'utente* carica come parti della stessa riunione. Scelta esplicita dell'utente.
> - **Chunking** (livello tecnico, §7): lo split *automatico* che l'app fa su una singola registrazione grande per rispettare il limite dei 25 MB di Whisper. Invisibile all'utente.
>
> Una riunione → una o più registrazioni (utente) → ciascuna eventualmente divisa in più chunk (automatico) → tutte le trascrizioni ricomposte in un unico testo → una sola analisi AI.

**Non-obiettivi di questa versione** (esplicitamente fuori scope):
- Nessuna registrazione audio *dentro* l'app (solo import da file esterni). *Opzionale come estensione futura.*
- Nessuna diarizzazione ("chi parla"): non necessaria per il verbale. Predisporre l'architettura per aggiungerla in futuro senza riscrivere (vedi §11).
- Nessun account utente, login, cloud sync, backend proprietario.
- Nessun supporto multi-utente.

---

## 3. Stack tecnico richiesto

- **Framework**: Flutter (ultima stabile), Dart. Codice conforme alle linee guida ufficiali Flutter (effective Dart, lint rules strette).
- **Target primario iniziale**: iOS (iPhone). **Android è un target di prima classe pianificato**: lo sviluppo si concentra prima su iOS, ma ogni scelta architetturale, di dipendenze e di design deve preservare la portabilità ad Android senza riscritture. Vedi §3bis.
- **State management**: Riverpod (preferito) o Bloc. Scegliere uno e restare coerenti. Motivare la scelta nel `CLAUDE.md`.
- **Database locale**: Drift (SQLite tipizzato) oppure Isar. Preferire Drift per query relazionali progetti↔riunioni. Motivare nel `CLAUDE.md`.
- **Storage sicuro chiavi**: `flutter_secure_storage` (Keychain su iOS). La API key **non** deve mai finire in database in chiaro, log, o SharedPreferences.
- **Networking**: `dio` (con interceptor per retry e gestione errori) o `http`. Preferire `dio`.
- **Share extension iOS**: `receive_sharing_intent` o equivalente, per ricevere file audio dalla share sheet di sistema.
- **Audio processing** (splitting/decodifica per il chunking): `ffmpeg_kit_flutter` o equivalente. Vedi §7.
- **API esterne**: OpenAI
  - Trascrizione: `POST https://api.openai.com/v1/audio/transcriptions` (modello `whisper-1`).
  - Analisi: `POST https://api.openai.com/v1/chat/completions` (modello `gpt-4o` o superiore, configurabile).

**Nessuna dipendenza da un backend proprietario.** Tutte le chiamate partono dal client.

---

## 3bis. Strategia multi-piattaforma (iOS ora, Android dopo)

Lo sviluppo iniziale è focalizzato su **iOS**, ma l'app è pensata **cross-platform** fin dall'inizio. Regole per non pregiudicare Android:

- **Nessuna logica di dominio o dati platform-specific.** Tutto ciò che è iOS-only va isolato dietro interfacce astratte in `domain/`, con implementazione in `data/` o in un layer `platform/`.
- **Punti che differiscono tra le piattaforme** e vanno astratti dietro interfacce, con implementazione iOS ora e Android predisposta:
  - *Share sheet / ricezione file*: su iOS share extension, su Android intent filter (`ACTION_SEND`). Astrarre dietro un `ShareIntentService`.
  - *Storage sicuro chiavi*: Keychain (iOS) / Keystore (Android) — già gestito da `flutter_secure_storage`, ma non assumere comportamenti iOS-only.
  - *File system / percorsi persistenti*: usare `path_provider`, mai percorsi hardcoded.
  - *Elaborazione audio (ffmpeg)*: verificare che la libreria scelta supporti entrambe le piattaforme.
- **Preferire dipendenze che dichiarano supporto iOS + Android.** Se una dipendenza è iOS-only, va isolata e segnalata come debito da colmare per Android nel `CLAUDE.md`.
- **Design system indipendente dalla piattaforma** (§10 e §10bis): niente widget Cupertino-only nei componenti riutilizzabili; il look "glass" è custom e coerente su entrambe. Eventuali adattamenti per convenzioni native (es. gesture di navigazione) restano confinati e documentati.
- **Testare presto su Android** almeno il percorso critico, anche se il rilascio iniziale è iOS, per non accumulare sorprese.

Documentare nel `CLAUDE.md` ogni punto in cui iOS e Android divergono e lo stato della predisposizione Android.

---

## 4. Architettura software

Adottare **Clean Architecture** a strati, con separazione netta:

```
lib/
├── main.dart
├── app/                  # setup app, theming, routing
│   ├── theme/            # design system (colori, tipografia, glass components)
│   └── router/
├── core/                 # utilità trasversali
│   ├── errors/           # eccezioni tipizzate (ApiKeyMissing, FileTooLarge, ...)
│   ├── constants/        # costanti (limiti dimensione, tariffe, modelli)
│   └── utils/
├── data/                 # implementazioni concrete
│   ├── datasources/
│   │   ├── local/        # DAO Drift/Isar
│   │   └── remote/       # OpenAiTranscriptionApi, OpenAiChatApi
│   ├── models/           # DTO / entità DB
│   └── repositories/     # implementazioni dei repository
├── domain/               # logica pura, indipendente da framework
│   ├── entities/         # Project, Meeting, Transcript, MeetingReport, UsageRecord
│   ├── repositories/     # interfacce astratte
│   └── usecases/         # ImportRecording, TranscribeMeeting, AnalyzeMeeting, ...
└── presentation/         # UI
    ├── screens/
    └── widgets/
```

**Principio**: il `domain/` non conosce Flutter né OpenAI né il DB. I dettagli (API, DB, file system) stanno in `data/`. Questo rende banale in futuro sostituire Whisper con Deepgram o aggiungere un backend.

---

## 5. Modello dati (database locale)

Entità minime da modellare:

**Project**
- `id` (UUID)
- `name` (string) — es. "Progetto Halligan"
- `description` (text) — descrizione generale del progetto, editabile dall'utente
- `createdAt`, `updatedAt`
- `color` / `icon` (opzionale, per la UI)

**ProjectContext** (il "contesto attuale" vivo del progetto — vedi §6ter)
- `id` (UUID)
- `projectId` (FK → Project)
- `overviewMarkdown` (long text) — sintesi corrente dello stato del progetto, rigenerata/aggiornata dall'AI man mano che si aggiungono riunioni: di cosa tratta il progetto, decisioni chiave cumulative, questioni aperte, prossimi passi
- `updatedAt`
- `sourceMeetingIds` (lista) — quali riunioni sono già state incorporate nel contesto (per aggiornarlo in modo incrementale)

> Il `ProjectContext` è ciò che l'utente vede aprendo il progetto ("informazioni"/"contesto attuale"). Non è scritto a mano: è generato dall'AI aggregando i recap delle riunioni, ed è anche il materiale base per il Q&A (§8bis).

**Meeting**
- `id` (UUID)
- `projectId` (FK → Project)
- `title` (string, editabile; default = data o nome della prima registrazione)
- `createdAt`
- `status` (enum: `draft`, `transcribing`, `transcribed`, `analyzing`, `completed`, `failed`) — stato **aggregato** della riunione, derivato dallo stato delle sue registrazioni
- `errorMessage` (nullable string)

> Nota: la Meeting **non** contiene più un singolo file audio. I file stanno nelle Recording figlie. Una Meeting può avere 1..N registrazioni.

**Recording** (una registrazione = un file audio caricato dall'utente)
- `id` (UUID)
- `meetingId` (FK → Meeting)
- `orderIndex` (int) — ordine della registrazione dentro la riunione (l'utente può riordinare)
- `sourceFileName` (string)
- `localFilePath` (string) — percorso del file copiato nell'area persistente dell'app
- `audioDurationSeconds` (int, se ricavabile)
- `fileSizeBytes` (int)
- `status` (enum: `imported`, `transcribing`, `transcribed`, `failed`)
- `chunkCount` (int) — in quanti chunk tecnici è stata divisa per Whisper (1 se non serviva split)
- `errorMessage` (nullable string)
- `createdAt`

**RecordingTranscript** (trascrizione di una singola registrazione)
- `id` (UUID)
- `recordingId` (FK → Recording)
- `text` (long text) — testo della singola registrazione (già ricomposto dagli eventuali chunk)
- `language` (string, se rilevata)

**Transcript** (trascrizione aggregata dell'intera riunione)
- `id` (UUID)
- `meetingId` (FK → Meeting)
- `fullText` (long text) — concatenazione ordinata dei `RecordingTranscript` secondo `orderIndex`
- `language` (string)
- `recordingCount` (int) — quante registrazioni sono state unite

> `fullText` si ottiene concatenando i testi delle registrazioni in ordine di `orderIndex`, con un separatore leggibile tra una registrazione e l'altra (es. `--- Registrazione 2 ---`), utile anche a GPT per capire che il flusso ha delle cesure. L'analisi AI (§8) gira **una sola volta** su questo `fullText`.

**MeetingReport** (il verbale AI)
- `id` (UUID)
- `meetingId` (FK → Meeting)
- `summary` (text) — sintesi discorsiva
- `problems` (lista strutturata) — problematiche emerse
- `decisions` (lista strutturata) — cosa si è deciso
- `actionItems` (lista strutturata) — cosa fare, con eventuale responsabile/scadenza se deducibili
- `rawJson` (text) — output JSON grezzo del modello, per debug/rigenerazione
- `modelUsed` (string)
- `generatedAt`

**UsageRecord** (tracker costi, vedi §9)
- `id` (UUID)
- `meetingId` (FK, nullable)
- `operationType` (enum: `transcription`, `analysis`, `context_update`, `qa`)
- `model` (string)
- `audioSeconds` (int, nullable — per Whisper)
- `inputTokens` (int, nullable — per GPT)
- `outputTokens` (int, nullable — per GPT)
- `estimatedCostUsd` (double)
- `timestamp`

Le liste strutturate (`problems`, `decisions`, `actionItems`) vanno serializzate in modo interrogabile (tabelle figlie o JSON tipizzato). Preferire tabelle figlie se si usa Drift.

**MeetingMarkdown** (rappresentazione Markdown canonica della riunione — vedi §8ter)
- `id` (UUID)
- `meetingId` (FK → Meeting)
- `contentMarkdown` (long text) — il recap schematico della riunione in Markdown, secondo il template definito in §8ter. È il formato "second brain" leggibile e riusabile.
- `generatedAt`

> Ogni riunione completata produce **un file Markdown** secondo un template fisso (§8ter). È ciò che l'utente legge come "recap schematico" ed è l'unità di conoscenza su cui si costruiscono il contesto di progetto e il Q&A.

**ProjectQAThread / ProjectQAMessage** (domande e risposte sul progetto — vedi §8bis)
- `ProjectQAThread`: `id`, `projectId` (FK), `createdAt`, `title` (derivabile dalla prima domanda)
- `ProjectQAMessage`: `id`, `threadId` (FK), `role` (`user` | `assistant`), `content` (text), `timestamp`, `usageRecordId` (FK nullable → UsageRecord, per tracciare il costo della risposta)

> Le domande sul progetto e le relative risposte AI vengono salvate come cronologia consultabile, così l'utente ritrova le risposte già ottenute senza ripagarle.

---

## 6. Flusso funzionale end-to-end

### 6.1 Import
1. L'utente condivide uno **o più** file audio via share sheet → l'app si apre (o va in foreground).
2. L'app copia ogni file in una cartella applicativa persistente (documenti dell'app), **non** lascia il riferimento al file originale (che potrebbe sparire).
3. Mostra una schermata "Nuova riunione": scelta del progetto (dropdown esistenti + "crea nuovo"), titolo editabile. L'utente sceglie se i file importati creano una **nuova riunione** o vanno aggiunti a una **riunione esistente** (vedi §6bis).
4. Crea il record `Meeting` con `status = draft` e una `Recording` per ogni file, con `orderIndex` progressivo.

### 6bis. Riunione in più registrazioni (flusso dedicato)
Requisito esplicito: una riunione può essere composta da più registrazioni, caricate anche in momenti diversi.

1. **Creazione con più file insieme**: se l'utente condivide più file in una volta, ognuno diventa una Recording della stessa Meeting, con `orderIndex` nell'ordine di selezione (riordinabile).
2. **Aggiunta successiva**: dalla schermata di dettaglio riunione, un pulsante **"Aggiungi registrazione"** permette di importare un altro file (via share sheet o file picker) e agganciarlo alla riunione esistente come nuova Recording in coda.
3. **Riordino**: l'utente può riordinare le registrazioni (drag & drop) — cambia `orderIndex` e quindi l'ordine del testo aggregato.
4. **Rimozione**: l'utente può eliminare una singola registrazione dalla riunione.
5. **Rielaborazione**: aggiungere, rimuovere o riordinare registrazioni **dopo** che l'analisi è già stata generata invalida il verbale: la Meeting torna in uno stato che richiede di **rigenerare** il `Transcript` aggregato e l'analisi. Segnalarlo in UI ("Le registrazioni sono cambiate: rigenera il verbale").
6. Solo le Recording nuove/modificate vanno ri-trascritte; quelle già `transcribed` e invariate riusano il loro `RecordingTranscript` (non si ripaga la trascrizione). L'analisi AI invece si rigenera sempre sull'intero testo aggregato.

### 6.2 Trascrizione (vedi §7 per il chunking)
La trascrizione lavora **per singola Recording**; la riunione è completa quando tutte le sue registrazioni lo sono.
1. Verifica presenza API key. Se manca → messaggio chiaro che rimanda a Impostazioni.
2. Per ogni Recording in stato `imported`: `Recording.status = transcribing`.
3. Se il file della Recording ≤ limite → una chiamata a Whisper. Se > limite → split in chunk + N chiamate + ricomposizione (§7). Il testo ricomposto è il `RecordingTranscript`.
4. Salva `RecordingTranscript`. `Recording.status = transcribed`.
5. Registra `UsageRecord` (durata audio → costo Whisper) per ogni chiamata.
6. Quando **tutte** le Recording della Meeting sono `transcribed`: costruisci il `Transcript` aggregato concatenando i `RecordingTranscript` in ordine di `orderIndex`. `Meeting.status = transcribed`.

> Le registrazioni possono essere trascritte in parallelo o in sequenza; l'ordine del testo finale dipende da `orderIndex`, non dall'ordine di completamento.

### 6.3 Analisi
1. `status = analyzing`.
2. Invia la trascrizione a GPT con il prompt strutturato (§8), richiedendo output **JSON**.
3. Fa il parsing robusto del JSON (gestione fence ```json, campi mancanti).
4. Salva `MeetingReport`. Genera il `MeetingMarkdown` (§8ter.1) dai dati strutturati. `status = completed`.
5. Registra `UsageRecord` (token in/out → costo GPT).
6. **Aggiorna il contesto di progetto**: rigenera o aggiorna incrementalmente il `ProjectContext` (§6ter) per incorporare la nuova riunione. Produce un ulteriore `UsageRecord`.

### 6ter. Apertura e uso del progetto (second brain)
Aprendo un progetto, l'utente accede a tre aree:

1. **Contesto attuale** (`ProjectContext`): schermata "informazioni"/"contesto" che mostra la sintesi viva del progetto — di cosa tratta, decisioni chiave cumulative, questioni aperte, prossimi passi. È generata e aggiornata dall'AI, non scritta a mano. All'apertura del progetto è la vista principale, così l'utente ha subito il quadro aggiornato.
2. **Riunioni**: elenco delle riunioni del progetto (passate e in elaborazione), ognuna con titolo, data e stato. Da qui si **carica una nuova riunione** (una o più registrazioni, §6/§6bis) e si apre ogni riunione per vederne il **recap schematico** completo (il `MeetingMarkdown`, §8ter).
3. **Chiedi al progetto** (Q&A): interfaccia per porre domande in linguaggio naturale sull'intero progetto e ricevere risposte AI (§8bis).

**Aggiornamento del contesto**: quando una nuova riunione viene completata (o rimossa/modificata), il `ProjectContext` va rigenerato o aggiornato in modo incrementale per riflettere la nuova conoscenza. Segnalare in UI se il contesto è "in aggiornamento" o disallineato rispetto alle riunioni attuali. L'aggiornamento del contesto è un'operazione AI e produce un `UsageRecord`.

**Descrizione manuale**: l'utente può comunque scrivere una `description` di progetto (campo libero) che affianca — senza sostituire — il contesto generato dall'AI, e che viene passata all'AI come indicazione di intento del progetto.

### 6.4 Consultazione
- Schermata riunione: tab o sezioni per **Verbale** (sintesi + problematiche + decisioni + azioni) e **Trascrizione** (testo integrale).
- Azioni: rigenera analisi, esporta (condividi il verbale come testo/markdown), modifica titolo, sposta di progetto, elimina.

### 6.5 Gestione errori (obbligatoria in ogni fase)
- Chiave API assente o invalida (401) → messaggio specifico.
- File troppo grande gestito da chunking, non da errore.
- Errore di rete / timeout → retry automatico (backoff) + possibilità di ripresa manuale.
- Errore parsing JSON → salva `rawJson`, segnala, offri "riprova analisi".
- Ogni `Meeting` fallito resta in stato `failed` con `errorMessage` leggibile e un pulsante "Riprova".

---

## 7. Gestione file audio grandi (requisito critico)

**Problema**: OpenAI Whisper accetta file fino a **25 MB**. Un'ora di registrazione può pesare ~100 MB. L'app **deve** gestirlo senza errori.

**Requisiti**:
1. Rilevare la dimensione del file all'import.
2. Se ≤ 25 MB (con un margine di sicurezza, es. soglia a 24 MB): singola chiamata.
3. Se > soglia: **spezzare l'audio in segmenti temporali** (non tagliare i byte a caso — usare ffmpeg per segmentare per durata, es. blocchi da ~10 minuti, ricomprimendo se serve per stare sotto i 25 MB per blocco).
4. Preferire, dove possibile, **ridurre il bitrate / convertire in formato compatto** (es. mono, 16 kHz, m4a/ogg) prima di stimare quanti blocchi servono — spesso riduce drasticamente la dimensione e il numero di chiamate. La qualità 16 kHz mono è più che sufficiente per Whisper.
5. Trascrivere ogni blocco con una chiamata separata a Whisper.
6. **Ricomporre** le trascrizioni parziali in un unico testo, nell'ordine corretto.
7. Gestire i blocchi in modo resiliente: se il blocco 2 di 3 fallisce, poter riprovare solo quello senza rifare gli altri.
8. Mostrare avanzamento all'utente ("Trascrizione blocco 2 di 3…").

**Nota implementativa**: valutare l'overlap di pochi secondi tra blocchi per non perdere parole a cavallo del taglio, e de-duplicare in ricomposizione. Documentare la scelta nel `CLAUDE.md`.

I parametri (soglia MB, durata blocco, bitrate target, overlap) devono essere **costanti configurabili** in `core/constants/`, non numeri magici sparsi.

---

## 8. Prompt di analisi AI

Il prompt di sistema per GPT deve produrre un **JSON valido e nient'altro**. Struttura richiesta:

```json
{
  "summary": "sintesi discorsiva della riunione in 3-5 frasi",
  "problems": [
    { "title": "…", "detail": "…" }
  ],
  "decisions": [
    { "title": "…", "detail": "…" }
  ],
  "actionItems": [
    { "task": "…", "owner": "… o null", "due": "… o null" }
  ]
}
```

Linee guida per il prompt (da rifinire in `CLAUDE.md` e mantenere versionato):
- Rispondere **solo** con JSON, senza testo introduttivo né backtick.
- Lingua dell'output = lingua della riunione (tipicamente italiano).
- Non inventare informazioni non presenti nella trascrizione; se un campo non emerge, lista vuota.
- Essere concreto e sintetico, stile "verbale professionale".
- Il prompt deve essere una **costante centralizzata e versionata**, non hardcoded sparso nel codice, così da poterlo iterare facilmente.

Gestire il parsing con tolleranza (rimozione di eventuali fence, validazione dei campi, fallback se il modello sbaglia formato → un retry con istruzione di correggere il formato).

---

## 8bis. Q&A sul progetto (interrogare il second brain)

Requisito centrale: l'utente deve poter **fare domande in linguaggio naturale su un intero progetto** e ricevere risposte AI basate sui contenuti delle sue riunioni. Esempio: "Cosa avevamo deciso sul budget del firmware?" o "Quali action item sono ancora aperti?".

**Come funziona (strategia a due livelli per contenere costi e limiti di contesto)**:

1. **Base di conoscenza = i Markdown**. La conoscenza del progetto è l'insieme dei `MeetingMarkdown` (recap compatti, §8ter) più il `ProjectContext` (§6ter). Questi sono molto più corti delle trascrizioni integrali, quindi economici da passare all'AI.
2. **Costruzione del contesto della domanda**: alla domanda dell'utente, l'app assembla un prompt che include: la descrizione del progetto, il `ProjectContext`, e i recap Markdown delle riunioni rilevanti.
3. **Selezione delle riunioni rilevanti**:
   - *Approccio iniziale (MVP)*: se il progetto ha poche riunioni e i recap stanno comodamente nel contesto del modello, includerli tutti.
   - *Approccio scalabile (predisporre)*: quando i recap superano una soglia di token, selezionare solo i più rilevanti alla domanda. Predisporre l'architettura per un retrieval (es. ricerca per parole chiave sui Markdown ora; embeddings/RAG in futuro). Astrarre dietro un `ProjectKnowledgeRetriever` così da poter evolvere da "tutti i recap" a "recap rilevanti" senza cambiare il resto.
4. **Solo se necessario, il testo integrale**: se la domanda richiede un dettaglio non presente nei recap, prevedere (come estensione) la possibilità di attingere alla trascrizione integrale della/e riunione/i indicata/e. Nell'MVP è sufficiente rispondere dai recap e, se l'informazione non c'è, dichiararlo.
5. **Prompt di risposta**: istruire il modello a rispondere **solo** sulla base del materiale fornito, citando a quali riunioni si riferisce (titolo/data), e a dichiarare esplicitamente quando l'informazione non è presente, senza inventare.
6. **Persistenza e costi**: domanda e risposta si salvano come `ProjectQAThread`/`ProjectQAMessage`; ogni risposta genera un `UsageRecord` (token in/out). L'utente ritrova le risposte passate senza ripagarle.

**Requisiti UI**: interfaccia in stile chat dentro il progetto ("Chiedi al progetto"), con cronologia delle domande, indicazione delle riunioni citate nella risposta, e stato di caricamento durante la generazione.

---

## 8ter. Formato Markdown canonico (organizzazione del second brain)

Tutta la conoscenza prodotta da Notalino è rappresentata anche come **Markdown strutturato secondo template fissi**. Questo rende il second brain leggibile, esportabile, riusabile e adatto a essere passato all'AI. I template devono essere **costanti versionate** (come il prompt di analisi) e documentati nel `CLAUDE.md`.

Il Markdown è **derivato** dai dati strutturati del DB (§5), non la fonte primaria: il DB resta la source of truth, il Markdown è la sua proiezione canonica. Rigenerabile in qualsiasi momento dai dati.

### 8ter.1 Markdown di riunione (`MeetingMarkdown`)

Template fisso per il recap di ogni riunione:

```markdown
# {Titolo riunione}

- **Progetto:** {nome progetto}
- **Data:** {data}
- **Registrazioni:** {n} · **Durata totale:** {hh:mm}

## Sintesi
{summary discorsiva, 3-5 frasi}

## Problematiche
- **{titolo}** — {dettaglio}
- …

## Decisioni
- **{titolo}** — {dettaglio}
- …

## Cose da fare
- [ ] {task} — *responsabile:* {owner o "—"} · *scadenza:* {due o "—"}
- …

## Note
{eventuali annotazioni; assente se vuoto}
```

Regole: sezioni sempre presenti nell'ordine dato; se una lista è vuota, riportare "_Nessuna._". Gli action item usano checkbox Markdown. Nessun contenuto inventato: rispecchia esattamente il `MeetingReport`.

### 8ter.2 Markdown di contesto progetto (`ProjectContext.overviewMarkdown`)

Template fisso per la scheda viva del progetto:

```markdown
# {Nome progetto} — Contesto

{descrizione generale del progetto, se presente}

## Di cosa tratta
{sintesi cumulativa dello scopo e stato del progetto}

## Decisioni chiave (cumulative)
- {decisione} — *(riunione: {titolo/data})*
- …

## Questioni aperte
- {questione} — *(emersa in: {titolo/data})*
- …

## Prossimi passi
- [ ] {azione aperta} — *da: {titolo/data}*
- …

## Riunioni
- {data} — {titolo} — {una riga di sintesi}
- …

---
*Aggiornato il {data} · basato su {n} riunioni*
```

Il contesto è generato dall'AI aggregando i `MeetingMarkdown`. Ogni voce chiave riporta la riunione di provenienza, così l'utente (e il Q&A) può risalire alla fonte.

### 8ter.3 Organizzazione logica del second brain

Struttura concettuale (mappata sul DB; se in futuro si esporta su file system o si sincronizza, questa è la gerarchia):

```
Progetto X/
├── _contesto.md          # ProjectContext (scheda viva del progetto)
├── riunioni/
│   ├── 2026-01-15_kickoff.md      # MeetingMarkdown
│   ├── 2026-02-03_review-firmware.md
│   └── …
└── (domande/risposte salvate come thread Q&A)
```

Prevedere un **export** che produca esattamente questa struttura di file Markdown (utile come backup leggibile e per un futuro second brain su file). Nell'MVP l'export può limitarsi al singolo recap e al contesto; l'export completo del progetto è predisposto ma può arrivare in una fase successiva.

---

## 9. Tracker dei costi (requisito)

L'app deve mostrare **quanto si sta spendendo** in API OpenAI.

**Meccanismo**:
- Ogni risposta delle API OpenAI include il consumo: Whisper → durata audio processata; Chat → `usage` con `prompt_tokens` e `completion_tokens`.
- Dopo ogni operazione, salvare un `UsageRecord` con i valori grezzi **e** il costo stimato, calcolato da tariffe configurabili in `core/constants/` (facilmente aggiornabili quando i prezzi cambiano).
- Tariffe di riferimento da inserire come default (aggiornabili):
  - Whisper: tariffa al minuto.
  - GPT: tariffa per 1K token input e per 1K token output (dipende dal modello).
- Le tariffe devono essere **modificabili dall'utente** in Impostazioni (o almeno costanti ben isolate), perché cambiano nel tempo.

**Schermata "Consumi"**:
- Totale stimato del **mese corrente**.
- Totale complessivo.
- Dettaglio per riunione / per progetto.
- Breakdown trascrizione vs analisi vs aggiornamento contesto vs Q&A.

Chiarire in UI che è una **stima** basata sulle tariffe inserite, non la fattura reale OpenAI.

---

## 10. Requisiti di interfaccia ed estetica

**Principi**: minimale, moderna, arieggiata, elegante. Ispirazione *liquid glass* / vetro smerigliato (superfici traslucide con blur, bordi morbidi, profondità leggera), palette **chiara**, accenti tenui.

**Requisiti concreti**:
- Design system centralizzato: un unico file per colori, tipografia, spaziature, raggi, ombre. Niente valori hardcoded nelle schermate.
- Componenti "glass" riutilizzabili (card, bottoni, bottom sheet) con effetto blur/traslucido, costruiti come widget dedicati.
- Tipografia pulita e gerarchica; ampio uso di spazio bianco.
- Micro-interazioni e transizioni fluide, ma sobrie.
- Dark mode: predisporre il theming per supportarla anche se il focus è la palette chiara.
- Accessibilità di base: contrasti adeguati, dimensioni tap ≥ 44px, supporto Dynamic Type.

**Schermate principali**:
1. **Home / Progetti** — griglia o lista di progetti, ognuno con conteggio riunioni; FAB per nuovo progetto.
2. **Dettaglio progetto** — apre sul **contesto attuale** (scheda viva, §6ter); tab/sezioni per *Contesto*, *Riunioni* (lista con badge di stato + carica nuova riunione), *Chiedi al progetto* (Q&A). FAB per caricare una riunione.
3. **Chiedi al progetto (Q&A)** — interfaccia chat dentro il progetto: campo domanda, cronologia thread, risposte AI con indicazione delle riunioni citate, stato di caricamento (§8bis).
4. **Dettaglio riunione** — recap schematico (il `MeetingMarkdown`) reso in modo leggibile + trascrizione integrale, con azioni; **lista delle registrazioni** che compongono la riunione (con stato di ognuna), pulsante "Aggiungi registrazione", riordino drag & drop e rimozione. Se le registrazioni sono cambiate dopo l'ultima analisi, banner "rigenera il verbale".
5. **Import / Nuova riunione** — scelta progetto + titolo, avvio elaborazione con avanzamento.
6. **Impostazioni** — API key OpenAI (campo mascherato, salvataggio sicuro, test connessione), scelta modello GPT, tariffe.
7. **Consumi** — dashboard costi (§9).

Nessuna schermata deve bloccarsi durante le elaborazioni lunghe: usare stati di caricamento chiari e permettere di navigare altrove mentre l'elaborazione procede.

---

## 10bis. Design system (fonte unica di verità della UI)

Requisito esplicito: prima di costruire le schermate, definire un **design system documentato e centralizzato**. Ogni componente attuale e futuro nasce da qui; nessun valore visivo (colore, spaziatura, raggio, font) è mai hardcoded nelle schermate. Il design system vive in `lib/app/theme/` ed è descritto nel `CLAUDE.md`.

Direzione visiva: **liquid glass / vetro smerigliato**, palette **chiara**, minimale, arieggiata, elegante. Superfici traslucide con blur, profondità leggera, accenti tenui.

### 10bis.1 Design token (valori di riferimento, rifinibili)

I valori qui sotto sono un punto di partenza coerente con la direzione richiesta; vanno consolidati in file di token Dart (es. `AppColors`, `AppTypography`, `AppSpacing`, `AppRadii`, `AppElevations`, `AppGlass`). Se in fase di build si affinano, aggiornare qui e nel `CLAUDE.md`.

**Colore — superfici (light)**
- `background` — `#F5F7FA` (grigio-azzurro chiarissimo, base dell'app)
- `surface` — `#FFFFFF` (card opache quando serve pieno contrasto)
- `glassSurface` — `#FFFFFF` con opacità ~60-70% + blur (materiale vetro)
- `glassBorder` — `#FFFFFF` con opacità ~40% (bordo luminoso del vetro)
- `overlayTint` — `#0A2540` con opacità ~4-6% (leggera ombreggiatura sotto il vetro)

**Colore — testo**
- `textPrimary` — `#1C2733` (quasi nero, blu molto scuro)
- `textSecondary` — `#5A6B7B` (grigio-blu medio)
- `textTertiary` — `#93A1AF` (disabilitato / caption)

**Colore — accenti**
- `accentPrimary` — `#4C8DFF` (blu tenue, azione principale) con gradiente verso `#6FA8FF`
- `accentSecondary` — `#7B8FF7` (viola-blu soft, secondario)
- `success` — `#3FBF8F`
- `warning` — `#E8A13A`
- `error` — `#E5675C`
- `info` — `#4C8DFF`

> La palette è deliberatamente fredda e chiara (blu/grigi) per distinguersi dal look "cream + terracotta" e dare un carattere pulito e professionale adatto a un tool di lavoro. Se si preferisce un accento diverso, cambiarlo **solo** qui e propagare via token.

**Stati semantici delle riunioni** (badge): mappare gli `status` a colori dei token — `draft`/`imported` → neutro (`textTertiary`), `transcribing`/`analyzing` → `info`, `completed` → `success`, `failed` → `error`.

**Tipografia**
- Font di riferimento: una famiglia sans moderna e leggibile (es. *Inter*, *SF Pro* come nativo iOS, o *Manrope* per un tocco più caratteristico). Definire un solo font di sistema più eventuale display.
- Scala tipografica con ruoli nominati (non dimensioni sparse):
  - `displayLarge` ~34/40, peso 700
  - `titleLarge` ~24/30, peso 600
  - `titleMedium` ~20/26, peso 600
  - `bodyLarge` ~17/24, peso 400
  - `bodyMedium` ~15/22, peso 400
  - `label` ~13/16, peso 500, tracking leggero
  - `caption` ~12/16, peso 400, colore `textTertiary`
- Supporto Dynamic Type (iOS): le dimensioni scalano con le impostazioni di sistema.

**Spaziatura** — scala a step di 4: `xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`, `xxxl 48`. Nessun margine/padding fuori scala.

**Raggi** — `sm 8`, `md 12`, `lg 20`, `xl 28`, `pill 999`. Il vetro usa raggi generosi (`lg`/`xl`).

**Elevazione / ombre** — ombre morbide e diffuse a bassa opacità (es. y+8, blur 24, colore `#0A2540` @ 8%). Il vetro combina ombra esterna leggera + bordo luminoso interno.

**Materiale "glass"** — token dedicati: colore di riempimento traslucido, intensità blur (es. sigma 18-24), opacità bordo, tinta. Un unico widget `GlassContainer` incapsula il `BackdropFilter` così che tutti i componenti vetro siano coerenti e modificabili da un punto solo.

**Motion** — durate e curve nominate: `fast 150ms`, `base 250ms`, `slow 400ms`; curva standard `easeOutCubic`. Rispettare *reduce motion* di sistema.

### 10bis.2 Libreria di componenti riutilizzabili

Costruire come widget dedicati, tutti derivati dai token (nessuno stile inline):
- `GlassContainer` (primitiva vetro) e `GlassCard`
- `PrimaryButton`, `SecondaryButton`, `GhostButton` (con stati: normale, premuto, disabilitato, loading)
- `AppTextField` (incluso il campo mascherato per la API key)
- `StatusBadge` (mappa gli status ai colori semantici)
- `SectionHeader` / eyebrow
- `AppBottomSheet` (glass), `AppDialog`
- `ProgressIndicator` per le elaborazioni lunghe ("blocco 2 di 3", "registrazione 2 di 3")
- `EmptyState` (schermate vuote come invito all'azione, testi in stile §13/§copy)
- `ListTile` custom per progetti e riunioni

### 10bis.3 Regole d'uso

- **Un componente nuovo si crea sempre a partire dai token e dalla libreria esistente.** Se serve un valore non previsto, prima si aggiunge come token, poi lo si usa — mai un literal nella schermata.
- Temi centralizzati via `ThemeData`/estensioni di tema Flutter (`ThemeExtension`) così che i token siano accessibili come `Theme.of(context)`.
- Predisporre **dark mode** definendo i token anche in variante scura fin da subito (anche se il focus iniziale è la palette chiara): ogni token colore ha la sua controparte dark.
- I componenti sono **platform-agnostic** (vedi §3bis): niente widget Cupertino-only nella libreria condivisa.
- Documentare la libreria nel `CLAUDE.md` con l'elenco dei componenti e dei token, così che un futuro sviluppo sappia cosa esiste già prima di crearne di nuovi.

---

## 11. Estensibilità futura (predisporre, non implementare)

Progettare in modo che questi sviluppi non richiedano riscritture:
- **Diarizzazione** ("chi parla"): astrarre la trascrizione dietro un'interfaccia `TranscriptionService` così da poter aggiungere un'implementazione Deepgram/AssemblyAI accanto a Whisper senza toccare il resto.
- **Retrieval avanzato per il Q&A**: il `ProjectKnowledgeRetriever` (§8bis) parte da una selezione semplice (tutti i recap / ricerca per parole chiave) e può evolvere a embeddings + ricerca semantica (RAG) per progetti con molte riunioni, senza cambiare l'interfaccia di Q&A.
- **Q&A cross-progetto** e attingere alla trascrizione integrale on-demand quando i recap non bastano.
- **Backend + sync cloud**: i repository sono già astratti; una futura implementazione remota deve poter affiancare quella locale.
- **Registrazione in-app**.
- **Export avanzati** (PDF, condivisione formattata).

Documentare questi punti di estensione nel `CLAUDE.md`.

---

## 12. Sicurezza e privacy

- API key solo in Keychain via `flutter_secure_storage`. Mai in log, mai in DB in chiaro, mai committata.
- I file audio e le trascrizioni restano **solo sul device** (più il transito verso OpenAI necessario alla trascrizione/analisi).
- Nessun file `.env` con segreti committato. `.gitignore` corretto fin da subito.
- Informare l'utente (nota in Impostazioni) che l'audio viene inviato ai server OpenAI per l'elaborazione.

---

## 13. Qualità del codice e convenzioni

- Seguire **Effective Dart** e le linee guida ufficiali Flutter.
- `analysis_options.yaml` con lint set rigoroso (es. `flutter_lints` o `very_good_analysis`).
- Codice tipizzato, niente `dynamic` se evitabile; null-safety piena.
- Nomi chiari, funzioni piccole, un solo compito per classe.
- **Test**: unit test per gli use case e la logica di chunking/costi; widget test per i componenti chiave. Almeno il percorso critico (import → trascrizione → analisi) coperto.
- Gestione errori tipizzata (eccezioni dedicate), niente `catch` silenziosi.
- Commenti solo dove serve spiegare il *perché*, non il *cosa*.
- Commit atomici e messaggi chiari.

---

## 14. `CLAUDE.md` — il *second brain* del progetto (richiesta prioritaria)

**Prima azione richiesta a Claude Code**: creare nella root del repository un file **`CLAUDE.md`** che funga da memoria persistente del progetto. Ad ogni sessione, facendo il pull della repo, questo file va riletto per riallinearsi.

Il `CLAUDE.md` deve contenere e mantenere aggiornati:
- **Identità dell'app**: nome *Notalino*, bundle id `it.maketron.notalino`, publisher Maketron (§1bis).
- **Visione e scope** del progetto (sintesi di questo SRD).
- **Decisioni architetturali** prese e loro motivazione (state management scelto, DB scelto, libreria audio scelta, ecc.).
- **Struttura delle cartelle** e dove sta cosa.
- **Design system**: elenco dei token (colori, tipografia, spaziature, raggi, motion, glass) e dei componenti riutilizzabili già esistenti, così da riusarli invece di ricrearli. Ogni nuovo componente parte da qui.
- **Strategia multi-piattaforma**: punti in cui iOS e Android divergono e stato della predisposizione Android (§3bis).
- **Convenzioni** di codice e di commit adottate.
- **Stato di avanzamento**: cosa è fatto, cosa è in corso, cosa manca (una roadmap viva).
- **Note tecniche importanti**: parametri del chunking scelti, formato del prompt di analisi, **template Markdown canonici** (riunione e contesto progetto, §8ter) come costanti versionate, prompt del Q&A e del contesto progetto, strategia del retriever (§8bis), tariffe di default per i costi, endpoint e modelli usati.
- **Problemi noti / TODO / decisioni rimandate.**
- **Punti di estensione** futuri (§11).

**Regola operativa**: ogni volta che si prende una decisione significativa o si completa un pezzo, aggiornare `CLAUDE.md` nello stesso commit. Il file è la fonte di verità del progetto tra una sessione e l'altra.

---

## 15. Piano di sviluppo suggerito (per fasi)

1. **Setup**: progetto Flutter denominato `notalino` con identità app impostata da subito (nome *Notalino*, bundle id / applicationId `it.maketron.notalino`, app group `group.it.maketron.notalino`, publisher Maketron — §1bis), iOS + Android configurati, lint, struttura cartelle, `CLAUDE.md` iniziale.
2. **Design system** (§10bis): token completi (colori, tipografia, spaziature, raggi, motion, glass) in `ThemeExtension`, variante light e dark, e libreria di componenti base (GlassContainer, bottoni, textfield, badge, ecc.). È la fondazione di tutta la UI successiva.
3. **Dominio + DB locale**: entità (Project, Meeting, Recording, RecordingTranscript, Transcript, MeetingReport, UsageRecord), repository, DAO, migrazioni.
4. **Impostazioni + API key**: storage sicuro, test connessione OpenAI.
5. **Import via share sheet**: ricezione file (uno o più), copia persistente, creazione Meeting + Recording.
6. **Trascrizione semplice** (una Recording, file < 25 MB): integrazione Whisper, salvataggio RecordingTranscript.
7. **Registrazioni multiple**: più Recording per Meeting, ordinamento, aggiunta successiva, rimozione, costruzione del Transcript aggregato.
8. **Chunking audio** (file grandi): split ffmpeg, N chiamate, ricomposizione, resilienza — a livello di singola Recording.
9. **Analisi AI**: prompt, chiamata GPT, parsing JSON, MeetingReport, sul testo aggregato. Generazione del `MeetingMarkdown` canonico (§8ter.1).
10. **Contesto di progetto**: generazione/aggiornamento del `ProjectContext` (§6ter, §8ter.2) al completamento delle riunioni.
11. **Q&A sul progetto**: retriever astratto sui Markdown, prompt di risposta, thread persistenti, UI chat (§8bis).
12. **UI verbale + trascrizione + contesto**: schermate di consultazione, lista registrazioni, azioni, export Markdown.
13. **Progetti**: CRUD progetti, descrizione, spostamento riunioni.
14. **Tracker costi**: UsageRecord, schermata Consumi.
15. **Rifinitura estetica** e micro-interazioni.
16. **Verifica Android** sul percorso critico + test e gestione errori end-to-end.

Aggiornare `CLAUDE.md` al termine di ogni fase.

---

## 16. Criteri di completamento (definition of done dell'MVP)

- [ ] Import di una registrazione dai Memo Vocali tramite share sheet funzionante.
- [ ] Trascrizione corretta anche di un file da ~100 MB / 1 ora (via chunking), senza errori di dimensione.
- [ ] Possibilità di comporre una singola riunione da più registrazioni separate (2-3 spezzoni), trascritte e analizzate come un'unica riunione con un solo verbale.
- [ ] Verbale AI strutturato (sintesi, problematiche, decisioni, azioni) generato e mostrato.
- [ ] Ogni riunione completata produce un recap in Markdown canonico secondo template (§8ter.1).
- [ ] Aprendo un progetto è visibile un contesto attuale (scheda viva) generato dall'AI e aggiornato all'arrivo di nuove riunioni.
- [ ] Q&A funzionante: l'utente pone domande sul progetto e riceve risposte AI basate sui recap, con riunioni citate e cronologia salvata.
- [ ] Organizzazione in progetti con creazione e assegnazione riunioni.
- [ ] Database locale persistente tra riavvii.
- [ ] API key OpenAI inserita e salvata in modo sicuro.
- [ ] Tracker costi con totale mensile.
- [ ] Interfaccia minimale, chiara, in stile glass, coerente su tutte le schermate.
- [ ] Design system centralizzato (token + libreria componenti) come unica fonte di verità, con variante light e dark, documentato nel `CLAUDE.md`.
- [ ] Nessun valore visivo hardcoded nelle schermate: tutto deriva dai token.
- [ ] Architettura e dipendenze predisposte per Android senza riscritture; percorso critico verificato anche su Android.
- [ ] Gestione errori robusta con possibilità di riprovare le operazioni fallite.
- [ ] `CLAUDE.md` presente, completo e aggiornato.
