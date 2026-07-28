# CLAUDE.md — Second brain di Notalino

> Memoria persistente del progetto. **Rileggere questo file a ogni sessione** (dopo il pull) per riallinearsi.
> Regola operativa: ogni decisione significativa o pezzo completato → aggiornare questo file **nello stesso commit**.

---

## 1. Identità dell'app (§1bis)

| Campo | Valore |
|---|---|
| Nome prodotto / display name | **Notalino** |
| Publisher / owner | **Maketron** — https://www.maketron.it |
| Bundle id iOS (`PRODUCT_BUNDLE_IDENTIFIER`) | `it.maketron.notalino` |
| Application id Android (`applicationId`) | `it.maketron.notalino` |
| App group / share extension iOS | `group.it.maketron.notalino` |
| Nome package Flutter | `notalino` |
| URL schema (deep link) | `notalino://` |
| Copyright | © Maketron |
| Support/privacy URL (placeholder) | https://www.maketron.it/notalino |

Sotto-identificatori (widget, extension, notification service) → prefisso `it.maketron.notalino.*`.

---

## 2. Visione e scope (§1)

App mobile Flutter (focus iOS, Android target di prima classe pianificato) che:
1. importa registrazioni audio di riunioni (dalla share sheet iOS o file picker);
2. le **trascrive** con OpenAI Whisper (`whisper-1`);
3. genera un **verbale strutturato** AI (GPT): sintesi, problematiche, decisioni, action item;
4. organizza le riunioni in **progetti**, ognuno un **second brain interrogabile** (contesto vivo + Q&A in linguaggio naturale).

Una riunione = 1..N **registrazioni** (scelta utente) → ciascuna eventualmente divisa in più **chunk** tecnici (automatico, §7 SRD) → trascrizioni ricomposte in un unico testo → **una sola** analisi AI.

**Filosofia**: nessun backend. L'utente mette la propria **API key OpenAI** nelle impostazioni; l'app parla direttamente con OpenAI. DB **locale** sul device.

**Non-obiettivi MVP**: registrazione in-app, diarizzazione, account/login, cloud sync, multi-utente. (Architettura predisposta per aggiungerli — §11 SRD.)

---

## 3. Decisioni architetturali

| Ambito | Scelta | Motivazione |
|---|---|---|
| State management | **Riverpod** (`flutter_riverpod` + code-gen) | Provider componibili, testabili, poco boilerplate; override facile nei test. |
| Database locale | **Drift** (SQLite tipizzato) | Query relazionali progetti↔riunioni↔registrazioni, migrazioni, type-safety. |
| Storage chiavi | **flutter_secure_storage** | Keychain iOS / Keystore Android. API key mai in DB/log/prefs. |
| Networking | **dio** | Interceptor per retry/backoff e mappatura errori tipizzata. |
| Audio processing | **ffmpeg_kit_flutter_new** | Fork mantenuto (l'originale `ffmpeg_kit_flutter` è stato ritirato). Segmentazione per durata + ricompressione mono 16kHz. |
| Share intent | **receive_sharing_intent** | Ricezione file audio da share sheet iOS / intent Android. |
| Architettura | **Clean Architecture** a strati | `domain/` puro (no Flutter/OpenAI/DB); dettagli in `data/`. |

Astrazioni chiave (per estensibilità §11): `TranscriptionService`, `AnalysisService`, `AudioProcessor`, `ShareIntentService`, `ProjectKnowledgeRetriever`, repository interfaces in `domain/repositories/`.

---

## 4. Struttura cartelle (§4)

```
lib/
├── main.dart                 # bootstrap: ProviderScope + init DB
├── app/
│   ├── theme/                # DESIGN SYSTEM (token + ThemeExtension)
│   ├── router/               # routing (GoRouter-like via Navigator 2 semplice)
│   └── app.dart              # MaterialApp + tema
├── core/
│   ├── constants/            # limiti chunking, tariffe, modelli, endpoint
│   ├── errors/               # eccezioni tipizzate (ApiKeyMissing, FileTooLarge, ...)
│   ├── prompts/              # prompt AI + template Markdown (costanti versionate)
│   └── utils/
├── data/
│   ├── datasources/
│   │   ├── local/            # Drift DB, DAO
│   │   └── remote/           # OpenAiTranscriptionApi, OpenAiChatApi
│   ├── repositories/         # impl repository
│   └── services/             # AudioProcessor(ffmpeg), ShareIntentService, retriever
├── domain/
│   ├── entities/             # Project, Meeting, Recording, Transcript, MeetingReport, UsageRecord, ...
│   ├── repositories/         # interfacce astratte
│   └── usecases/             # ImportRecordings, TranscribeMeeting, AnalyzeMeeting, ...
└── presentation/
    ├── screens/              # home, project detail, meeting detail, settings, usage, qa, import
    ├── widgets/              # componenti glass riutilizzabili
    └── providers/            # Riverpod providers/controllers
```

---

## 5. Design system (§10bis) — fonte unica di verità della UI

Vive in `lib/app/theme/`. **Nessun valore visivo hardcoded nelle schermate**: tutto dai token, esposti via `ThemeExtension` → `Theme.of(context).extension<...>()` (helper `context.tokens`).

Direzione: **liquid glass / vetro smerigliato**, palette **chiara**, minimale, arieggiata. Variante **dark** definita fin da subito.

**Token (file):**
- `AppColors` — superfici (`background #F5F7FA`, `surface`, `glassSurface`, `glassBorder`, `overlayTint`), testo (`textPrimary #1C2733`, `textSecondary`, `textTertiary`), accenti (`accentPrimary #4C8DFF`→`#6FA8FF`, `accentSecondary #7B8FF7`, `success #3FBF8F`, `warning #E8A13A`, `error #E5675C`, `info #4C8DFF`). Variante light + dark.
- `AppTypography` — ruoli nominati: `displayLarge` 34/700, `titleLarge` 24/600, `titleMedium` 20/600, `bodyLarge` 17/400, `bodyMedium` 15/400, `label` 13/500, `caption` 12/400.
- `AppSpacing` — step di 4: `xs 4, sm 8, md 12, lg 16, xl 24, xxl 32, xxxl 48`.
- `AppRadii` — `sm 8, md 12, lg 20, xl 28, pill 999`.
- `AppElevations` — ombre morbide (y+8, blur 24, `#0A2540` @ 8%).
- `AppGlass` — riempimento traslucido, blur sigma ~20, opacità bordo, tinta.
- `AppMotion` — `fast 150ms, base 250ms, slow 400ms`, curva `easeOutCubic`.

**Componenti riutilizzabili** (`presentation/widgets/`, tutti derivati dai token):
`GlassContainer` (primitiva `BackdropFilter`), `GlassCard`, `PrimaryButton`/`SecondaryButton`/`GhostButton` (stati normale/premuto/disabilitato/loading), `AppTextField` (+ variante mascherata API key), `StatusBadge` (mappa status→colore semantico), `SectionHeader`, `AppBottomSheet`, `AppDialog`, `StepProgressIndicator` ("blocco 2 di 3"), `EmptyState`, `ProjectListTile`, `MeetingListTile`.

Mappatura status→colore: `draft`/`imported` → `textTertiary`; `transcribing`/`analyzing` → `info`; `completed`/`transcribed` → `success`; `failed` → `error`.

**Regola**: componente nuovo nasce da token + libreria esistente. Serve un valore nuovo? Prima si aggiunge come token.

---

## 6. Strategia multi-piattaforma (§3bis)

- Nessuna logica di dominio platform-specific. iOS-only isolato dietro interfacce.
- Punti divergenti astratti: `ShareIntentService` (share extension iOS / intent Android), storage chiavi (già astratto da flutter_secure_storage), file system (`path_provider`), ffmpeg (verificato iOS+Android via `ffmpeg_kit_flutter_new`).
- Design system platform-agnostic (niente Cupertino-only nei componenti condivisi).

**Stato predisposizione Android:** manifest con intent-filter `ACTION_SEND`/`SEND_MULTIPLE` per audio già configurato. Percorso critico da verificare su Android (fase 16 SRD — TODO).

**Debito iOS-nativo da completare (non automatizzabile da qui):**
- **Share Extension iOS**: `receive_sharing_intent` richiede un target Share Extension in Xcode + App Group `group.it.maketron.notalino` + entitlements. Da creare in Xcode. Finché non c'è, l'import avviene via file picker in-app (funzionante) e "Apri in Notalino" (document types già in Info.plist).
- **App Group entitlement** iOS: da aggiungere in Xcode (Runner + extension).

---

## 7. Note tecniche importanti

### Chunking audio (§7) — costanti in `core/constants/audio_constants.dart`
- `maxWhisperFileBytes` = 25 MB; soglia di sicurezza `chunkThresholdBytes` = 24 MB.
- Pre-normalizzazione: transcodifica a **mono, 16 kHz, AAC/m4a ~32kbps** prima di stimare i chunk (riduce drasticamente dimensione e n. chiamate; qualità sufficiente per Whisper).
- Segmentazione **per durata** (ffmpeg `-f segment`), blocco target ~600s (10 min).
- `overlapSeconds` = 0 nell'MVP (segmentazione pulita; overlap+dedup previsto come miglioria — documentare se attivato).
- Resilienza: ogni chunk è ritentabile singolarmente; ricomposizione in ordine.

### Endpoint e modelli (`core/constants/openai_constants.dart`)
- Trascrizione: `POST https://api.openai.com/v1/audio/transcriptions`, modello `whisper-1`.
- Analisi/Q&A/contesto: `POST https://api.openai.com/v1/chat/completions`, modello default `gpt-4o` (configurabile in Impostazioni).

### Tariffe default (§9, `core/constants/pricing_constants.dart`) — modificabili in Impostazioni
- Whisper: **$0.006 / minuto**.
- gpt-4o: input **$2.50 / 1M token**, output **$10.00 / 1M token** (valori di riferimento, aggiornabili).
- Costo = stima basata sulle tariffe inserite, **non** la fattura reale OpenAI (chiarito in UI).

### Prompt e template (costanti versionate in `core/prompts/`)
- `analysis_prompt.dart` — system prompt che impone **solo JSON** con `summary`/`problems`/`decisions`/`actionItems`; lingua = lingua riunione; niente invenzioni; retry di correzione formato.
- `markdown_templates.dart` — template canonici `MeetingMarkdown` (§8ter.1) e `ProjectContext.overviewMarkdown` (§8ter.2). Sezioni sempre presenti, liste vuote → "_Nessuna._", action item come checkbox.
- `context_prompt.dart` — genera/aggiorna il contesto di progetto aggregando i MeetingMarkdown.
- `qa_prompt.dart` — risponde SOLO dal materiale fornito, cita riunioni (titolo/data), dichiara quando l'info non c'è.

### Q&A retriever (§8bis)
- `ProjectKnowledgeRetriever` astratto. MVP: `AllRecapsRetriever` (tutti i recap se stanno nel contesto) con fallback a ricerca per parole chiave sui Markdown (`KeywordRetriever`) oltre soglia token. Evoluzione futura: embeddings/RAG senza cambiare l'interfaccia.

---

## 8. Modello dati (§5)
Entità: `Project`, `ProjectContext`, `Meeting`, `Recording`, `RecordingTranscript`, `Transcript`, `MeetingReport` (+ liste figlie `problems`/`decisions`/`actionItems`), `MeetingMarkdown`, `UsageRecord`, `ProjectQAThread`, `ProjectQAMessage`.
DB = source of truth; il Markdown è **proiezione derivata** rigenerabile.
Stato Meeting aggregato dagli stati Recording. Modifica registrazioni dopo l'analisi → invalida il verbale (banner "rigenera").

---

## 9. Convenzioni (§13)
- Effective Dart + `flutter_lints` (config in `analysis_options.yaml`, regole extra).
- Null-safety piena, no `dynamic` evitabile, eccezioni tipizzate (no catch silenziosi).
- Test: unit su chunking/costi/usecase; widget test sui componenti chiave; percorso critico coperto.
- **Commit**: atomici, messaggi chiari, in italiano. **Nessun co-author.**
- File generati (`*.g.dart`) esclusi dall'analyzer, **committati** (build_runner).

---

## 10. Stato di avanzamento (roadmap viva)

Legenda: ✅ fatto · 🚧 in corso · ⬜ da fare

- ✅ **Fase 1 — Setup**: progetto `notalino`, identità `it.maketron.notalino`, iOS+Android config, lint, struttura cartelle, CLAUDE.md.
- ✅ **Fase 2 — Design system**: token (`AppColors`/`AppDimens`/`AppTypography`/`AppGlass`) + `AppTokens` ThemeExtension (light/dark) + libreria componenti glass (`GlassContainer`, `GlassCard`, bottoni, `AppTextField`, `StatusBadge`, `SectionHeader`, `EmptyState`, `StepProgressIndicator`, `AppBottomSheet`, `AppDialog`, `AppScaffold`).
- ✅ **Fase 3 — Dominio + DB Drift**: entità, interfacce repository/servizi, DB Drift con 14 tabelle + tabelle figlie report, repository impl.
- ✅ **Fase 4 — Impostazioni + API key**: `SecureSettingsRepository` (Keychain), test connessione, scelta modello, tariffe editabili; `SettingsScreen`.
- ✅ **Fase 5 — Import**: `ImportRecordings` + `FileStorage` (copia persistente), file picker in-app, `ShareImportListener` per la share sheet, `NewMeetingScreen`.
- ✅ **Fase 6 — Trascrizione**: `WhisperTranscriptionService`, `TranscribeMeeting` (per Recording → aggregato), UsageRecord.
- ✅ **Fase 7 — Registrazioni multiple**: N Recording per Meeting, riordino drag&drop, aggiunta/rimozione, riuso trascrizioni, invalidazione verbale.
- ✅ **Fase 8 — Chunking audio**: `FfmpegAudioProcessor` (normalizza mono/16kHz/AAC + segmenta per durata), avanzamento "blocco N di M".
- ✅ **Fase 9 — Analisi AI**: `OpenAiAnalysisService` (JSON mode + parsing tollerante + retry), `AnalyzeMeeting`, `GenerateMeetingMarkdown` (§8ter.1).
- ✅ **Fase 10 — Contesto progetto**: `UpdateProjectContext` (§8ter.2), aggiornato al completamento riunione.
- ✅ **Fase 11 — Q&A**: `DefaultKnowledgeRetriever` (tutti i recap / keyword), `AskProject`, thread persistenti, `QaThreadScreen` (chat).
- ✅ **Fase 12 — UI verbale/trascrizione/contesto**: `MeetingDetailScreen` (tab Verbale/Trascrizione/Registrazioni + banner), `ProjectDetailScreen` (Contesto/Riunioni/Chiedi).
- ✅ **Fase 13 — Progetti CRUD**: creazione, descrizione editabile, conteggio riunioni; spostamento riunione predisposto (`Meeting.copyWith(projectId:)`).
- ✅ **Fase 14 — Tracker costi**: `UsageRecord` per ogni operazione, `UsageScreen` (mese/totale/breakdown).
- 🚧 **Fase 15 — Rifinitura estetica**: base glass completa; micro-interazioni/transizioni da affinare.
- ⬜ **Fase 16 — Verifica Android + test end-to-end**: unit test presenti (costi, parsing JSON, markdown); build su device iOS/Android e percorso critico ancora da verificare.

**Test presenti**: `test/cost_estimator_test.dart`, `test/json_extractor_test.dart`, `test/markdown_templates_test.dart` (15 test, verdi). `flutter analyze`: 0 issue.

---

## 11. Problemi noti / TODO / decisioni rimandate
- iOS Share Extension + App Group entitlement da creare in Xcode (vedi §6). Import via file picker funziona nel frattempo.
- `ffmpeg_kit_flutter_new`: verificare build effettiva su device iOS/Android (aumenta dimensione binario ~ per il pacchetto full-gpl; valutare variante "min" se il peso è un problema — l'ffmpeg qui serve solo per segment/transcode, la variante audio-only basta).
- Overlap tra chunk disattivato nell'MVP: se emergono parole perse ai tagli, attivare `overlapSeconds` + dedup.
- Verifica percorso critico su Android non ancora eseguita.

## 12. Punti di estensione futuri (§11)
Diarizzazione (dietro `TranscriptionService`), retrieval RAG/embeddings (dietro `ProjectKnowledgeRetriever`), Q&A cross-progetto, accesso on-demand alla trascrizione integrale, backend+sync (repository già astratti), registrazione in-app, export avanzati (PDF, struttura file Markdown per progetto §8ter.3).
