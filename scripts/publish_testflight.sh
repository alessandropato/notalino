#!/usr/bin/env bash
#
# Notalino — pubblicazione su TestFlight.
#
# Cosa fa:
#   1. Builda l'IPA con la versione CORRENTE in pubspec.yaml (la prima è 0.0.1+1).
#   2. Carica l'IPA su App Store Connect / TestFlight.
#   3. SOLO se l'upload riesce, bumpa versione (patch) e build (+1) in pubspec.yaml
#      per il prossimo upload. Così ogni build su TestFlight ha un numero univoco
#      e crescente (requisito Apple).
#
# Prerequisiti (una tantum):
#   - Signing automatico configurato nel progetto (team, bundle id) — già fatto.
#   - App Group `group.it.maketron.notalino` registrato e associato sia
#     all'App ID `it.maketron.notalino` che a `it.maketron.notalino.ShareExtension`
#     su developer.apple.com (richiesto dalla Share Extension). Se in futuro
#     Apple richiede un NUOVO profilo (es. dopo rotazione certificati) e questo
#     script fallisce con errori di tipo "No profiles found" o "doesn't include
#     the App Groups capability", va rigenerato UNA VOLTA con:
#       xcodebuild archive -project ios/Runner.xcodeproj -scheme Runner \
#         -configuration Release -archivePath build/ios/archive/Runner.xcarchive \
#         -destination 'generic/platform=iOS' -allowProvisioningUpdates \
#         -authenticationKeyPath <path.p8> -authenticationKeyID <id> \
#         -authenticationKeyIssuerID <issuer>
#     (richiede una chiave API con ruolo che includa Certificates/Identifiers/
#     Profiles — il semplice ruolo di upload non basta per CREARE profili nuovi).
#   - Credenziali App Store Connect via variabili d'ambiente. Due modi:
#       A) API key (consigliato):
#            export ASC_KEY_ID=XXXXXXXXXX
#            export ASC_ISSUER_ID=aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
#          e metti la chiave .p8 in  ~/.appstoreconnect/private_keys/AuthKey_<ASC_KEY_ID>.p8
#       B) Apple ID + password specifica per app:
#            export APPLE_ID="tuo@apple.id"
#            export APPLE_APP_PASSWORD="xxxx-xxxx-xxxx-xxxx"
#   - export APPLE_TEAM_ID=XXXXXXXXXX per l'export automatico.
#
# Uso:
#   ./scripts/publish_testflight.sh
#
set -euo pipefail

# CocoaPods/Ruby richiede un locale UTF-8 esplicito, non sempre presente in
# shell non interattive (script/CI): senza, `pod install` va in crash.
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# --- vai alla root del progetto (cartella superiore a scripts/) ---
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PUBSPEC="pubspec.yaml"

if [[ -z "${ASC_KEY_ID:-}" && -z "${APPLE_ID:-}" ]]; then
  echo "✗ Credenziali mancanti. Imposta ASC_KEY_ID+ASC_ISSUER_ID oppure APPLE_ID+APPLE_APP_PASSWORD." >&2
  exit 1
fi

# --- leggi la versione corrente: "name+build" (es. 0.0.1+1) ---
current="$(grep -E '^version:' "$PUBSPEC" | head -1 | sed -E 's/^version:[[:space:]]*//')"
name="${current%%+*}"      # 0.0.1
build="${current##*+}"     # 1
IFS='.' read -r major minor patch <<< "$name"

echo "▶ Versione corrente: $current"

# --- ExportOptions.plist per method app-store (generato al volo) ---
EXPORT_PLIST="$(mktemp -t notalino_export).plist"
TEAM_LINE=""
if [[ -n "${APPLE_TEAM_ID:-}" ]]; then
  TEAM_LINE="<key>teamID</key><string>${APPLE_TEAM_ID}</string>"
fi
cat > "$EXPORT_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key><string>app-store</string>
  <key>signingStyle</key><string>automatic</string>
  <key>destination</key><string>export</string>
  ${TEAM_LINE}
</dict>
</plist>
PLIST

# --- build IPA con la versione corrente ---
echo "▶ flutter pub get…"
flutter pub get

# Bug noto del tool Flutter: `flutter pub get` rigenera il package-ombrello
# FlutterGeneratedPluginSwiftPackage dichiarando iOS 13.0 come minimo, mentre
# ffmpeg_kit_flutter_new richiede 14.0 (come il resto del progetto) → l'archivio
# fallisce. Si corregge il file rigenerato (non versionato, va rifatto ogni volta).
GENERATED_PKG="ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift"
if [[ -f "$GENERATED_PKG" ]]; then
  sed -i '' 's/\.iOS("13\.0")/.iOS("14.0")/' "$GENERATED_PKG"
fi

echo "▶ flutter build ipa (versione $current)…"
flutter build ipa --release --export-options-plist "$EXPORT_PLIST"

IPA="$(ls -t build/ios/ipa/*.ipa 2>/dev/null | head -1 || true)"
if [[ -z "$IPA" ]]; then
  echo "✗ Nessun .ipa trovato in build/ios/ipa/. Build fallita?" >&2
  exit 1
fi
echo "▶ IPA: $IPA"

# --- upload su TestFlight (con retry: altool ogni tanto fallisce con
#     "Error: (null) 'Defaults.properties'..." in modo transitorio) ---
do_upload() {
  if [[ -n "${ASC_KEY_ID:-}" && -n "${ASC_ISSUER_ID:-}" ]]; then
    xcrun altool --upload-app -f "$IPA" --type ios \
      --apiKey "$ASC_KEY_ID" --apiIssuer "$ASC_ISSUER_ID"
  else
    xcrun altool --upload-app -f "$IPA" --type ios \
      --username "$APPLE_ID" --password "$APPLE_APP_PASSWORD"
  fi
}

uploaded=false
for attempt in 1 2 3; do
  echo "▶ Upload su TestFlight (tentativo $attempt/3)…"
  if do_upload; then
    uploaded=true
    break
  fi
  echo "… tentativo $attempt fallito (spesso è un flake di altool), ritento tra 10s…"
  sleep 10
done

if [[ "$uploaded" != true ]]; then
  echo "✗ Upload fallito dopo 3 tentativi. L'IPA è pronto in $IPA: puoi ricaricarlo con Transporter." >&2
  exit 1
fi

echo "✓ Upload completato."

# --- bump versione (patch) e build (+1) per il prossimo upload ---
patch=$((patch + 1))
build=$((build + 1))
newversion="${major}.${minor}.${patch}+${build}"
# sed compatibile macOS (BSD)
sed -i '' -E "s/^version:.*/version: ${newversion}/" "$PUBSPEC"
echo "✓ Versione bumpata per il prossimo upload: ${current} → ${newversion}"
echo "  (ricorda di committare pubspec.yaml)"
