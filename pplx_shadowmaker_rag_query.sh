#!/usr/bin/env bash
set -euo pipefail

# Globale Env laden: /etc/environment + User-Profil + aktuelle Shell
set -a
[ -f /etc/environment ] && source /etc/environment
[ -f "$HOME/.profile" ] && source "$HOME/.profile" || true
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" || true
set +a

API_KEY="${PPLX_API_KEY:-${PERPLEXITY_API_KEY:-}}"

if [ -z "$API_KEY" ]; then
  echo "FEHLER: Kein Perplexity API-Key gefunden."
  echo "Erwartet global:"
  echo "  PPLX_API_KEY=dein_key"
  echo "oder:"
  echo "  PERPLEXITY_API_KEY=dein_key"
  echo ""
  echo "Global setzen z.B.:"
  echo "  echo 'PPLX_API_KEY=dein_key' | sudo tee -a /etc/environment"
  echo "Danach neu einloggen oder: source /etc/environment"
  exit 1
fi

MODEL="${PPLX_MODEL:-sonar-pro}"
QUESTION="${*:-Erstelle eine prüfungsnahe IHK-Antwort zum Thema Wissensmanagement mit Betriebsrat, Datenschutz und lokaler KI.}"

OUT_DIR="$HOME/Schreibtisch/shadowmaker_v7_km/output"
LOG_DIR="$HOME/Schreibtisch/shadowmaker_v7_km/logs"
TS="$(date +%Y%m%d_%H%M%S)"

OUT_JSON="$OUT_DIR/pplx_response_$TS.json"
OUT_TXT="$OUT_DIR/pplx_response_$TS.txt"

mkdir -p "$OUT_DIR" "$LOG_DIR"

jq -n \
  --arg model "$MODEL" \
  --arg question "$QUESTION" \
  '{
    model: $model,
    messages: [
      {
        role: "system",
        content: "Du bist ein IHK-Prüfungsassistent für Mitarbeiterführung, Personalmanagement, Projektmanagement und Arbeitsrecht. Antworte prüfungsnah, strukturiert und direkt. Nutze das 10-Punkte-Gerüst: 1 Situation, 2 SMART-Ziel, 3 Stakeholder, 4 Ursachen Mensch/Organisation/Prozess, 5 Alternativen, 6 Bewertung wirtschaftlich/organisatorisch/menschlich, 7 Entscheidung, 8 Umsetzung, 9 Kontrolle/KPIs, 10 Nachhaltigkeit/Kommunikation/Recht."
      },
      {
        role: "user",
        content: $question
      }
    ],
    max_tokens: 1800,
    stream: false
  }' > /tmp/pplx_payload.json

curl -sS --request POST \
  --url "https://api.perplexity.ai/v1/sonar" \
  --header "Authorization: Bearer $API_KEY" \
  --header "Content-Type: application/json" \
  --data @/tmp/pplx_payload.json \
  | tee "$OUT_JSON" \
  | jq -r '.choices[0].message.content // .error.message // .' \
  | tee "$OUT_TXT"

echo ""
echo "─────────────────────────────────────────"
echo "Perplexity Output gespeichert:"
echo "JSON: $OUT_JSON"
echo "TXT:  $OUT_TXT"
echo "Modell: $MODEL"
echo "Key:   aus globaler Env geladen"
echo "─────────────────────────────────────────"
