#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app/components"

echo "[+] Creating FlashcardView folder structure ..."
mkdir -p "$BASE"

FILE="$BASE/FlashcardView.tsx"

echo "[+] Writing FlashcardView.tsx ..."
cat << 'EOC' > "$FILE"
import React from "react";

export default function FlashcardView({ card, onRate }) {
  if (!card)
    return (
      <div className="bg-slate-800 p-6 rounded-xl text-slate-300">
        Keine Karte geladen.
      </div>
    );

  return (
    <div className="bg-slate-800 p-6 rounded-xl shadow-xl flex flex-col gap-4">
      <div className="text-xl font-semibold text-slate-200">
        {card.prompt}
      </div>

      <div className="text-cyan-300 text-lg">
        {card.answer}
      </div>

      <div className="flex gap-4 mt-4">
        <button
          onClick={() => onRate(1)}
          className="px-4 py-2 bg-emerald-700 rounded-lg text-white"
        >
          Gut
        </button>

        <button
          onClick={() => onRate(0)}
          className="px-4 py-2 bg-red-700 rounded-lg text-white"
        >
          Schlecht
        </button>
      </div>
    </div>
  );
}
EOC

echo "[✓] FlashcardView.tsx installed successfully."
echo "[!] Run with: bash flashcardview_install.sh"
