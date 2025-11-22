#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/engine/data"

echo "[+] Creating data folder ..."
mkdir -p "$BASE"

FILE="$BASE/default.json"

echo "[+] Writing default.json ..."
cat << 'EOC' > "$FILE"
[
  {
    "id": "leadership_1",
    "prompt": "Was ist der Unterschied zwischen Führungsstil und Führungstechnik?",
    "answer": "Führungsstil = langfristiges, stabiles Verhalten; Führungstechnik = kurzfristige, situative Methode."
  },
  {
    "id": "leadership_2",
    "prompt": "Was bedeutet situative Führung?",
    "answer": "Die Führungskraft passt ihren Stil an die Reifegrade und Bedürfnisse des Mitarbeiters an."
  },
  {
    "id": "kommunikation_1",
    "prompt": "Was ist aktives Zuhören?",
    "answer": "Paraphrasieren, Verständnis zeigen, nachfragen, nonverbale Signale beachten."
  },
  {
    "id": "motivation_1",
    "prompt": "Was ist intrinsische Motivation?",
    "answer": "Motivation aus innerem Antrieb, Interesse oder persönlichem Sinn."
  },
  {
    "id": "recht_1",
    "prompt": "Was ist der Unterschied zwischen Abmahnung und Ermahnung?",
    "answer": "Abmahnung = rechtliche Warnfunktion; Ermahnung = nicht formal, nur Hinweis."
  },
  {
    "id": "pm_1",
    "prompt": "Was ist das magische Dreieck des Projektmanagements?",
    "answer": "Ziel: Zeit, Kosten, Qualität gleichzeitig optimieren."
  }
]
EOC

echo "[✓] default.json installed successfully."
echo "[!] Run with: bash defaultjson_install.sh"
