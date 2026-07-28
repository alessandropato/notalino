# Notalino

**Trascrizione e analisi AI delle riunioni** — app mobile Flutter (focus iOS, Android pianificato).
Publisher: **Maketron** · [maketron.it](https://www.maketron.it) · © Maketron

Notalino importa registrazioni audio di riunioni (dalla share sheet iOS o dal file picker), le
**trascrive** con OpenAI Whisper, genera un **verbale strutturato** con GPT (sintesi, problematiche,
decisioni, action item) e organizza tutto in **progetti**, ognuno un *second brain* interrogabile in
linguaggio naturale.

Nessun backend: l'utente inserisce la propria **API key OpenAI**, l'app parla direttamente con OpenAI
e conserva i dati in un **database locale** sul dispositivo.

## Caratteristiche

- Import di una o più registrazioni per riunione (unite e analizzate come un'unica riunione).
- Gestione automatica dei file grandi (chunking ffmpeg: normalizza mono/16 kHz + segmenta per durata).
- Verbale AI strutturato + **recap Markdown canonico** per ogni riunione.
- **Contesto di progetto** vivo, generato e aggiornato dall'AI.
- **Q&A sul progetto**: domande in linguaggio naturale con risposte basate sui recap e riunioni citate.
- **Tracker costi** con stima mensile e breakdown per operazione.
- UI *liquid glass* con design system centralizzato (token light/dark) e API key nel Keychain.

## Stack

Flutter · Dart · **Riverpod** (state) · **Drift** (SQLite locale) · **dio** · **flutter_secure_storage**
· **ffmpeg_kit_flutter_new** · **receive_sharing_intent** · Clean Architecture (domain/data/presentation).

## Sviluppo

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera il codice Drift
flutter run
flutter test
flutter analyze
```

Requisiti di piattaforma (imposti da ffmpeg): **Android minSdk 24**, **iOS 14+**.

Inserire la propria API key OpenAI in **Impostazioni** al primo avvio.

## Documentazione di progetto

Il file [`CLAUDE.md`](CLAUDE.md) è la memoria/second brain del progetto: decisioni architetturali,
design system, note tecniche (chunking, prompt, template Markdown, tariffe), roadmap e TODO.
La specifica completa è in [`SRD_Notalino.md`](SRD_Notalino.md).
