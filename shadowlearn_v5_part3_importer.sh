#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src"
ENGINE="$BASE/engine"
MODULES="$ENGINE/modules"
IMPORT="$BASE/app/importer"

mkdir -p "$MODULES"
mkdir -p "$IMPORT"

# ---------------------------------------------------------
# PDF/TXT Loader (Browser)
# ---------------------------------------------------------
cat << 'EOC' > "$IMPORT/FileLoader.ts"
export async function loadFile(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();

    reader.onload = (ev) => resolve(ev.target?.result as string);
    reader.onerror = () => reject("Fehler beim Lesen der Datei");

    reader.readAsText(file);
  });
}
EOC

# ---------------------------------------------------------
# Chunker (zerlegt große Texte in kleine Abschnitte)
# ---------------------------------------------------------
cat << 'EOC' > "$IMPORT/TextChunker.ts"
export function chunkText(text: string, size = 600): string[] {
  const chunks = [];
  for (let i = 0; i < text.length; i += size) {
    chunks.push(text.slice(i, i + size));
  }
  return chunks;
}
EOC

# ---------------------------------------------------------
# AI Flashcard Generator
# ---------------------------------------------------------
cat << 'EOC' > "$IMPORT/FlashcardGenerator.ts"
import { askAI } from "../../ai/OpenAIClient";

export async function generateCardsFromChunk(chunk: string) {
  const prompt = \`
Erzeuge 3-6 hochwertige Lernkarten aus folgendem Inhalt:

\${chunk}

Format:
[
  { "front": "", "back": "" },
  ...
]
  \`;

  const res = await askAI(prompt);
  try {
    const json = JSON.parse(res);
    return json;
  } catch {
    return [];
  }
}

export async function rewriteCard(card: any) {
  const p = \`
Verbessere diese Lernkarte, mach sie kürzer und klarer:
\${JSON.stringify(card)}
  \`;

  const out = await askAI(p);
  try {
    return JSON.parse(out);
  } catch {
    return card;
  }
}
EOC

# ---------------------------------------------------------
# Module Builder
# ---------------------------------------------------------
cat << 'EOC' > "$IMPORT/ModuleBuilder.ts"
export async function buildModule(name: string, cards: any[]) {
  const file = "/home/schattenmacher/Dokumente/ShadowLearn/app/src/engine/modules/" + name + ".json";

  const data = JSON.stringify(cards, null, 2);
  await window.electronAPI.writeFile(file, data);

  return file;
}
EOC

# ---------------------------------------------------------
# Importer UI (React)
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/app/views/ImporterView.tsx"
import React, { useState } from "react";
import { loadFile } from "../importer/FileLoader";
import { chunkText } from "../importer/TextChunker";
import { generateCardsFromChunk, rewriteCard } from "../importer/FlashcardGenerator";

export default function ImporterView() {
  const [status, setStatus] = useState("");
  const [cards, setCards] = useState<any[]>([]);

  async function handleFile(ev) {
    const file = ev.target.files[0];
    if (!file) return;

    setStatus("Lade Datei...");
    const raw = await loadFile(file);

    const chunks = chunkText(raw, 700);
    const allCards = [];

    setStatus("AI erzeugt Karten...");

    for (const ch of chunks) {
      const c = await generateCardsFromChunk(ch);
      for (const cc of c) {
        const better = await rewriteCard(cc);
        allCards.push(better);
      }
    }

    setCards(allCards);
    setStatus("Fertig – Karten bereit.");
  }

  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl font-bold mb-4">AutoImporter PRO</h1>

      <input
        type="file"
        className="mb-4"
        onChange={handleFile}
      />

      <p className="text-slate-400 mb-4">{status}</p>

      <div className="bg-slate-800 p-4 rounded-xl max-h-96 overflow-auto">
        {cards.map((c, i) => (
          <div key={i} className="mb-3 p-2 bg-slate-900 rounded">
            <p><b>Front:</b> {c.front}</p>
            <p><b>Back:</b> {c.back}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
EOC

echo "[✓] ShadowLearn v5 PRO – Teil 3 installiert!"
echo "-----------------------------------------------"
echo "Bereit für Teil 4 (Master-Installer)"
