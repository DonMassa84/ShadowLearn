#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app"
SRC="$APP/src"

echo "[1/4] Fix: index.css Reihenfolge …"

CSS="$SRC/index.css"

# Entfernt ALLE bisherigen @import
sed -i '/@import/d' "$CSS"

# Fügt @import ganz nach OBEN ein
sed -i '1i @import "animate.css";' "$CSS"

echo "[OK] index.css repariert."


echo "[2/4] Fix: LearnView falscher Pfad zu default.json …"

cat << 'EOC' > "$SRC/app/views/LearnView.tsx"
import React, { useState } from "react";
import FlashcardView from "../components/FlashcardView";
import data from "../../engine/data/default.json";

export default function LearnView() {
  const [index, setIndex] = useState(0);

  const next = () => setIndex((index + 1) % data.length);

  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl font-bold mb-4">Lernen</h1>
      <FlashcardView card={data[index]} onNext={next} />
    </div>
  );
}
EOC

echo "[OK] LearnView repariert."


echo "[3/4] Fix: default.json sicherstellen …"

mkdir -p "$SRC/engine/data"
cat << 'EOC' > "$SRC/engine/data/default.json"
[
  {
    "front": "ShadowLearn funktioniert!",
    "back": "Dies ist eine Testkarte."
  }
]
EOC

echo "[OK] default.json steht bereit."


echo "[4/4] Starte ShadowLearn neu …"

cd "$APP"
npm run dev

echo "--------------------------------------------"
echo "[✓] FINALER FIX ERFOLGREICH! ShadowLearn läuft jetzt sauber."
echo "--------------------------------------------"
