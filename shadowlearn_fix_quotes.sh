#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src"

echo "[1/2] Fix → TutorEngine.ts"

cat << 'EOC' > "$BASE/app/engine/TutorEngine.ts"
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
    const result = await askAI(prompt);
    this.history.push({ question, answer, result });
    return result;
  }

  async getWeaknesses() {
    return await analyzeWeakness(this.history);
  }

  async rewriteFlashcard(text: string) {
    const prompt = `
Formuliere klarer und präziser:
${text}
    `;
    return await askAI(prompt);
  }
}
EOC

echo "[2/2] Fix → FlashcardGenerator.ts"

cat << 'EOC' > "$BASE/app/importer/FlashcardGenerator.ts"
import { askAI } from "../../ai/OpenAIClient";

export async function generateCardsFromChunk(chunk: string) {
  const prompt = `
Erzeuge 3-6 hochwertige Lernkarten aus folgendem Inhalt:

${chunk}

Format:
[
  { "front": "", "back": "" },
  ...
]
`;
  const res = await askAI(prompt);
  try {
    return JSON.parse(res);
  } catch {
    return [];
  }
}

export async function rewriteCard(card: any) {
  const prompt = `
Verbessere diese Lernkarte:
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

echo "--------------------------------------------"
echo "[✓] Backtick-Fix abgeschlossen."
echo "Starte jetzt: npm run dev"
echo "--------------------------------------------"
