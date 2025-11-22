#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app/views"

echo "[+] Creating LearnView.tsx folder structure ..."
mkdir -p "$BASE"

FILE="$BASE/LearnView.tsx"

echo "[+] Writing LearnView.tsx ..."
cat << 'EOC' > "$FILE"
import React, { useEffect, useState } from "react";
import { FlashcardEngine } from "../../engine/core/flashcards";

export default function LearnView() {
  const [engine, setEngine] = useState(null);
  const [card, setCard] = useState(null);
  const [mode, setMode] = useState("active");
  const [delay, setDelay] = useState(5000);
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const load = async () => {
      const data = await import("../../engine/data/default.json")
        .then(m => m.default)
        .catch(() => []);

      const eng = new FlashcardEngine(data);
      setEngine(eng);
      setCard(eng.current());
      setProgress(eng.getProgress());
    };

    load();
  }, []);

  const nextCard = () => {
    if (!engine) return;
    const c = engine.next();
    setCard(c);
    setProgress(engine.getProgress());
  };

  const prevCard = () => {
    if (!engine) return;
    const c = engine.previous();
    setCard(c);
    setProgress(engine.getProgress());
  };

  const rateCard = (score) => {
    if (!engine || !card) return;
    engine.rate(card.id || card.prompt, score);
    setProgress(engine.getProgress());
  };

  const toggleMode = () => {
    if (!engine) return;
    const newMode = mode === "active" ? "passive" : "active";
    engine.setMode(newMode);
    setMode(newMode);

    if (newMode === "passive") {
      engine.setDelay(delay);
      engine.auto((c) => setCard(c));
    }
  };

  const changeDelay = (ms) => {
    setDelay(ms);
    if (engine) engine.setDelay(ms);
  };

  if (!engine || !card)
    return <div className="text-slate-200 p-8">Lade Lernmodul…</div>;

  return (
    <div className="text-slate-200 p-6 flex flex-col gap-6">

      <div className="text-xl font-bold">ShadowLearn – Lernen</div>

      <div className="bg-slate-800 p-6 rounded-xl shadow-xl">
        <div className="text-lg mb-4">{card.prompt}</div>
        <div className="text-cyan-300">{card.answer}</div>
      </div>

      <div className="flex gap-4">
        <button
          onClick={prevCard}
          className="px-4 py-2 bg-slate-700 rounded-lg"
        >
          Zurück
        </button>

        <button
          onClick={nextCard}
          className="px-4 py-2 bg-slate-700 rounded-lg"
        >
          Weiter
        </button>
      </div>

      <div className="flex gap-4">
        <button
          onClick={() => rateCard(1)}
          className="px-3 py-2 bg-emerald-700 rounded-lg"
        >
          Gut
        </button>

        <button
          onClick={() => rateCard(0)}
          className="px-3 py-2 bg-red-700 rounded-lg"
        >
          Schlecht
        </button>
      </div>

      <div className="mt-4 text-slate-400 text-sm">
        Fortschritt: {progress}%
      </div>

      <div className="flex flex-col gap-3 mt-6">
        <div className="font-semibold">Lernmodus</div>
        <button
          onClick={toggleMode}
          className="px-4 py-2 rounded-lg bg-indigo-700"
        >
          {mode === "active" ? "Wechsel zu Passiv" : "Wechsel zu Aktiv"}
        </button>

        {mode === "passive" && (
          <div className="flex flex-col mt-2">
            <span className="text-sm text-slate-400 mb-1">Delay (ms)</span>
            <input
              type="number"
              value={delay}
              onChange={(e) => changeDelay(Number(e.target.value))}
              className="bg-slate-700 p-2 rounded-lg"
            />
          </div>
        )}
      </div>
    </div>
  );
}
EOC

echo "[✓] LearnView.tsx installed successfully."
echo "[!] Run with: bash learnview_install.sh"
