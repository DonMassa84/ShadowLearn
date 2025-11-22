#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app"

mkdir -p "$BASE/views"
mkdir -p "$BASE/components"
mkdir -p "$BASE/layout"

# ---------------------------------------------------------
# NavigationBar
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/components/NavigationBar.tsx"
import { Link, useLocation } from "react-router-dom";

export default function NavigationBar() {
  const loc = useLocation();

  const active = (path: string) =>
    loc.pathname === path ? "text-cyan-300 underline" : "text-slate-300";

  return (
    <div className="w-full flex justify-between py-4 text-lg font-semibold">
      <Link className={active("/")} to="/">Themen</Link>
      <Link className={active("/learn")} to="/learn">Lernen</Link>
      <Link className={active("/tutor")} to="/tutor">Tutor</Link>
      <Link className={active("/weakness")} to="/weakness">Analyse</Link>
    </div>
  );
}
EOC

# ---------------------------------------------------------
# TutorPanel
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/components/TutorPanel.tsx"
import React, { useState } from "react";
import { TutorEngine } from "../engine/TutorEngine";

const tutor = new TutorEngine();

export default function TutorPanel() {
  const [question, setQ] = useState("");
  const [answer, setA] = useState("");
  const [result, setResult] = useState<any>(null);

  async function send() {
    const res = await tutor.evaluateAnswer(question, answer);
    setResult(res);
  }

  return (
    <div className="bg-slate-800 p-4 rounded-xl shadow-xl animate__animated animate__fadeIn">
      <h2 className="text-xl font-bold mb-4">AI-Tutor</h2>

      <textarea
        className="w-full p-3 rounded bg-slate-900 mb-2"
        placeholder="Frage eingeben"
        value={question}
        onChange={(e) => setQ(e.target.value)}
      />

      <textarea
        className="w-full p-3 rounded bg-slate-900 mb-2"
        placeholder="Deine Antwort…"
        value={answer}
        onChange={(e) => setA(e.target.value)}
      />

      <button
        onClick={send}
        className="px-4 py-2 bg-cyan-500 hover:bg-cyan-400 rounded"
      >
        Absenden
      </button>

      {result && (
        <div className="mt-4 p-3 bg-slate-900 rounded">
          <p><b>Score:</b> {result}</p>
        </div>
      )}
    </div>
  );
}
EOC

# ---------------------------------------------------------
# XP View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/views/XPView.tsx"
import React from "react";
import { useXPStore } from "../store/XPStore";

export default function XPView() {
  const { xp, level } = useXPStore();

  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl mb-4 font-bold">Fortschritt</h1>
      <p>Level: {level}</p>
      <p>XP: {xp}</p>
    </div>
  );
}
EOC

# ---------------------------------------------------------
# Tutor View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/views/TutorView.tsx"
import React from "react";
import TutorPanel from "../components/TutorPanel";

export default function TutorView() {
  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl font-bold mb-4">AI-Tutor</h1>
      <TutorPanel />
    </div>
  );
}
EOC

# ---------------------------------------------------------
# Weakness View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/views/WeaknessView.tsx"
import React, { useState } from "react";
import { TutorEngine } from "../engine/TutorEngine";

const tutor = new TutorEngine();

export default function WeaknessView() {
  const [data, setData] = useState<any>("");

  async function analyze() {
    const res = await tutor.getWeaknesses();
    setData(res);
  }

  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl font-bold mb-3">Schwächenanalyse</h1>
      <button
        onClick={analyze}
        className="px-4 py-2 bg-cyan-500 hover:bg-cyan-400 rounded"
      >
        Analyse starten
      </button>

      <pre className="mt-4 bg-slate-900 p-4 rounded overflow-auto">
        {JSON.stringify(data, null, 2)}
      </pre>
    </div>
  );
}
EOC

# ---------------------------------------------------------
# Topics View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/views/TopicsView.tsx"
import React from "react";
import { Link } from "react-router-dom";

export default function TopicsView() {
  return (
    <div className="animate__animated animate__fadeIn">
      <h1 className="text-3xl font-bold mb-4">Themenübersicht</h1>
      <p>Wähle ein Thema aus, um zu starten:</p>

      <div className="mt-4 flex flex-col gap-3">
        <Link className="p-3 rounded bg-slate-800 hover:bg-slate-700" to="/learn">
          Lernmodus
        </Link>

        <Link className="p-3 rounded bg-slate-800 hover:bg-slate-700" to="/tutor">
          AI-Tutor
        </Link>

        <Link className="p-3 rounded bg-slate-800 hover:bg-slate-700" to="/weakness">
          Analyse
        </Link>
      </div>
    </div>
  );
}
EOC

# ---------------------------------------------------------
# Learn View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/views/LearnView.tsx"
import React, { useState } from "react";
import FlashcardView from "../components/FlashcardView";
import data from "../../../engine/data/default.json";

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

# ---------------------------------------------------------
# Flashcard View
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/components/FlashcardView.tsx"
import React from "react";

export default function FlashcardView({ card, onNext }) {
  return (
    <div className="bg-slate-800 p-6 rounded-xl shadow-xl animate__animated animate__fadeInUp">
      <p className="text-xl mb-4">{card.front}</p>
      <p className="text-slate-400 mb-4">{card.back}</p>

      <button
        onClick={onNext}
        className="px-4 py-2 bg-cyan-500 hover:bg-cyan-400 rounded"
      >
        Weiter
      </button>
    </div>
  );
}
EOC

# ---------------------------------------------------------
# Router v5 PRO
# ---------------------------------------------------------
cat << 'EOC' > "$BASE/router.tsx"
import { BrowserRouter, Routes, Route } from "react-router-dom";
import NavigationBar from "./components/NavigationBar";
import TopicsView from "./views/TopicsView";
import LearnView from "./views/LearnView";
import TutorView from "./views/TutorView";
import WeaknessView from "./views/WeaknessView";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <div className="max-w-2xl mx-auto px-4 py-4">
        <NavigationBar />
        <Routes>
          <Route path="/" element={<TopicsView />} />
          <Route path="/learn" element={<LearnView />} />
          <Route path="/tutor" element={<TutorView />} />
          <Route path="/weakness" element={<WeaknessView />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}
EOC

echo "[✓] ShadowLearn v5 PRO – Teil 2 installiert!"
echo "-----------------------------------------------"
echo "Weiter mit: Teil 3"
