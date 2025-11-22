#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app/src/engine"
DATA_DIR="/mnt/data"

MODULES="$APP/data/modules"
DECKS="$APP/data/decks"
CARDS="$APP/data/cards"

echo "[+] Initialisiere Ordnerstruktur ..."
mkdir -p "$MODULES"
mkdir -p "$DECKS"
mkdir -p "$CARDS"

echo "[+] Suche Dateien in $DATA_DIR ..."

FILES=$(ls $DATA_DIR/*.txt 2>/dev/null || true)

if [ -z "$FILES" ]; then
  echo "[!] Keine TXT-Dateien gefunden."
  exit 1
fi

echo "[+] Auto-Importer gestartet."
INDEX_FILE="$APP/data/index.json"

echo "[" > "$INDEX_FILE"

MODULE_COUNT=0

for FILE in $FILES; do
  NAME=$(basename "$FILE" .txt)
  SAFE_NAME=$(echo "$NAME" | tr ' ' '_' | tr '/' '_')

  JSON_MODULE="$MODULES/${SAFE_NAME}.json"
  JSON_DECK="$DECKS/${SAFE_NAME}.json"

  echo "[+] Verarbeite: $FILE"

  CONTENT=$(cat "$FILE")

  # primitive automatische Chunk-Erkennung
  CARDS_JSON=$(echo "$CONTENT" \
    | sed 's/\r//' \
    | awk 'BEGIN{RS="";ORS="\n\n"}{print}' \
    | awk -v module="$SAFE_NAME" '
        BEGIN { i=0; print "[" }
        {
          gsub(/"/, "\\\"");
          printf "{ \"id\": \"" module "_%d\", \"prompt\": \"%s\", \"answer\": \"(Erklärung folgt automatisch)\" },\n", i, $0;
          i++
        }
        END { print "]" }
      ')

  echo "$CARDS_JSON" > "$CARDS/${SAFE_NAME}_cards.json"

  # Modul-JSON
  cat << EOM > "$JSON_MODULE"
{
  "id": "$SAFE_NAME",
  "title": "$NAME",
  "source": "$FILE",
  "cards_file": "$CARDS/${SAFE_NAME}_cards.json"
}
EOM

  # Deck-JSON für LearnView
  cat << EOD > "$JSON_DECK"
{
  "id": "$SAFE_NAME",
  "title": "$NAME",
  "cards": $(cat "$CARDS/${SAFE_NAME}_cards.json")
}
EOD

  if [ $MODULE_COUNT -gt 0 ]; then
    echo "," >> "$INDEX_FILE"
  fi

  echo "  { \"id\": \"$SAFE_NAME\", \"title\": \"$NAME\" }" >> "$INDEX_FILE"
  MODULE_COUNT=$((MODULE_COUNT+1))
done

echo "]" >> "$INDEX_FILE"

echo "[✓] Full Import abgeschlossen."
echo "[✓] Module: $MODULE_COUNT"
echo "[!] Starte ShadowLearn neu: npm run dev"
