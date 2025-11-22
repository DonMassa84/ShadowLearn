#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/Dokumente/ShadowLearn/app/src"

echo "[1/6] Repariere WeaknessAnalyzer.ts …"
cat << 'EOC' > "$SRC/ai/WeaknessAnalyzer.ts"
import { askAI } from "./OpenAIClient";

export async function analyzeWeakness(history: any[]) {
  const prompt = `
Analysiere folgende Lernhistorie:

${JSON.stringify(history, null, 2)}

Gib zurück:
{
  "schwaechen": [],
  "empfehlungen": [],
  "wiederholung": []
}
`;
  return await askAI(prompt);
}
EOC

echo "[2/6] Repariere TutorEngine.ts …"
cat << 'EOC' > "$SRC/app/engine/TutorEngine.ts"
import { askAI } from "../../ai/OpenAIClient";
import { analyzeWeakness } from "../../ai/WeaknessAnalyzer";

export class TutorEngine {
  constructor() {
    this.history = [];
  }

  async evaluateAnswer(question: string, answer: string) {
    const prompt = `
Bewerte diese Antwort:

Frage: ${question}
Antwort: ${answer}

Gib zurück:
{
  "score": 0-100,
  "feedback": "",
  "improvement": ""
}
`;
    const res = await askAI(prompt);
    this.history.push({ question, answer, result: res });
    return res;
  }

  async getWeaknesses() {
    return await analyzeWeakness(this.history);
  }

  async rewriteFlashcard(text: string) {
    const prompt = `
Verbessere die Lernkarte:
${text}
`;
    return await askAI(prompt);
  }
}
EOC

echo "[3/6] Repariere FlashcardGenerator.ts …"
cat << 'EOC' > "$SRC/app/importer/FlashcardGenerator.ts"
import { askAI } from "../../ai/OpenAIClient";

export async function generateCardsFromChunk(chunk: string) {
  const prompt = `
Erzeuge 3-6 Lernkarten aus folgendem Inhalt:

${chunk}

Format:
[
  { "front": "", "back": "" }
]
`;
  const result = await askAI(prompt);
  try {
    return JSON.parse(result);
  } catch {
    return [];
  }
}

export async function rewriteCard(card: any) {
  const prompt = `
Verbessere diese Karte:
${JSON.stringify(card)}
`;
  try {
    const out = await askAI(prompt);
    return JSON.parse(out);
  } catch {
    return card;
  }
}
EOC

echo "[4/6] Erzeuge fehlende default.json …"
mkdir -p "$SRC/engine/data"
cat << 'EOC' > "$SRC/engine/data/default.json"
[
  {
    "front": "Willkommen in ShadowLearn v5 PRO!",
    "back": "Wähle 'Lernen', um mit den Flashcards zu starten."
  },
  {
    "front": "AI-Tutor",
    "back": "Im Tutor-Modul kannst du Antworten prüfen lassen."
  }
]
EOC

echo "[5/6] Fix: index.css (@import oben)"
CSS="$SRC/index.css"
if ! grep -q "@import" "$CSS"; then
  sed -i '1i @import "animate.css";' "$CSS"
fi

echo "[6/6] Starte App neu …"

cd "$HOME/Dokumente/ShadowLearn/app"
npm run dev

echo "----------------------------------------"
echo "[✓] ShadowLearn vollständig repariert!"
echo "Öffne jetzt: http://localhost:5173/ oder :5174/"
echo "----------------------------------------"
