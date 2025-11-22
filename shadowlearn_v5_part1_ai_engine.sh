#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src"

mkdir -p "$BASE/ai"
mkdir -p "$BASE/app/store"
mkdir -p "$BASE/app/engine"

# 1) OpenAI Client
cat << 'EOC' > "$BASE/ai/OpenAIClient.ts"
import OpenAI from "openai";

const client = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY,
});

export async function askAI(prompt: string) {
  try {
    const response = await client.chat.completions.create({
      model: "gpt-5.1",
      messages: [
        {
          role: "system",
          content: "Du bist ein adaptiver Lern-Tutor. Antworte präzise und kompakt."
        },
        { role: "user", content: prompt }
      ],
      temperature: 0.3,
    });

    return response.choices?.[0]?.message?.content ?? "";
  } catch (err) {
    console.error("AI error:", err);
    return "AI Error.";
  }
}
EOC

# 2) XP Store
cat << 'EOC' > "$BASE/app/store/XPStore.ts"
import { useState } from "react";

export function useXPStore() {
  const [xp, setXP] = useState(0);
  const [level, setLevel] = useState(1);

  function addXP(amount: number) {
    const newXP = xp + amount;
    setXP(newXP);

    if (newXP >= level * 100) {
      setLevel(level + 1);
    }
  }

  return { xp, level, addXP };
}
EOC

# 3) Weakness Analyzer
cat << 'EOC' > "$BASE/ai/WeaknessAnalyzer.ts"
import { askAI } from "./OpenAIClient";

export async function analyzeWeakness(history: any[]) {
  const prompt = \`
Analysiere folgende Lernhistorie:

\${JSON.stringify(history, null, 2)}

Gib zurück:
- 3 Schwächen
- Themenempfehlungen
- Wiederholungsstufen

Format: JSON
\`;

  return await askAI(prompt);
}
EOC

# 4) Tutor Engine
cat << 'EOC' > "$BASE/app/engine/TutorEngine.ts"
import { askAI } from "../../ai/OpenAIClient";
import { analyzeWeakness } from "../../ai/WeaknessAnalyzer";

export class TutorEngine {
  constructor() {
    this.history = [];
  }

  async evaluateAnswer(question: string, answer: string) {
    const prompt = \`
Bewerte diese Antwort:

Frage: \${question}
Antwort: \${answer}

Gib zurück:
{
  "score": 0-100,
  "feedback": "",
  "improvement": ""
}
\`;

    const result = await askAI(prompt);
    this.history.push({ question, answer, result });
    return result;
  }

  async getWeaknesses() {
    return await analyzeWeakness(this.history);
  }

  async rewriteFlashcard(text: string) {
    return await askAI("Formuliere klarer und präziser: " + text);
  }
}
EOC

echo "[✓] ShadowLearn v5 PRO — Teil 1 installiert!"
echo "-------------------------------------------"
echo "Führe jetzt aus: bash shadowlearn_v5_part1_ai_engine.sh"
