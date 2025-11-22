#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app"

# create folders
mkdir -p "$BASE/components"
mkdir -p "$BASE/views"
mkdir -p "$BASE/layout"
mkdir -p "$BASE/store"
mkdir -p "$BASE/modules"

########################################
# NavigationBar.tsx
########################################
cat << 'EOC' > "$BASE/components/NavigationBar.tsx"
import React from "react";
import { Link, useLocation } from "react-router-dom";

export default function NavigationBar() {
  const loc = useLocation();

  const active = (path) =>
    loc.pathname.startsWith(path)
      ? "text-cyan-300"
      : "text-slate-400 hover:text-slate-200";

  return (
    <div className="w-full flex justify-center py-4 bg-slate-800 shadow-lg">
      <div className="flex gap-6 text-lg">
        <Link to="/learn" className={active("/learn")}>Lernen</Link>
        <Link to="/topics" className={active("/topics")}>Themen</Link>
        <Link to="/decks" className={active("/decks")}>Decks</Link>
      </div>
    </div>
  );
}
EOC

########################################
# TopicsView.tsx – Themenübersicht
########################################
cat << 'EOC' > "$BASE/views/TopicsView.tsx"
import React from "react";
import { Link } from "react-router-dom";

const topics = [
  { id: "leadership", title: "Führung" },
  { id: "kommunikation", title: "Kommunikation" },
  { id: "recht", title: "Arbeitsrecht" },
  { id: "motivation", title: "Motivation" },
  { id: "pm", title: "Projektmanagement" }
];

export default function TopicsView() {
  return (
    <div className="p-6 text-slate-200">
      <h1 className="text-xl font-bold mb-6">Themenübersicht</h1>

      <div className="grid gap-4">
        {topics.map((t) => (
          <Link
            key={t.id}
            to={"/topics/" + t.id}
            className="bg-slate-800 p-4 rounded-xl shadow hover:bg-slate-700"
          >
            {t.title}
          </Link>
        ))}
      </div>
    </div>
  );
}
EOC

########################################
# PassivePlayer.tsx
########################################
cat << 'EOC' > "$BASE/components/PassivePlayer.tsx"
import React, { useEffect, useState } from "react";

export default function PassivePlayer({ engine }) {
  const [card, setCard] = useState(null);

  useEffect(() => {
    if (!engine) return;

    engine.setMode("passive");
    engine.auto((c) => setCard(c));
  }, [engine]);

  if (!card) return <div className="text-slate-400">Lade...</div>;

  return (
    <div className="bg-slate-800 p-6 rounded-xl shadow-xl">
      <div className="text-xl mb-3">{card.prompt}</div>
      <div className="text-cyan-300">{card.answer}</div>
    </div>
  );
}
EOC

########################################
# FlashcardDeck.ts – Deck-System
########################################
cat << 'EOC' > "$BASE/modules/FlashcardDeck.ts"
export interface Flashcard {
  id: string;
  prompt: string;
  answer: string;
}

export interface FlashcardDeck {
  id: string;
  title: string;
  cards: Flashcard[];
}
EOC

########################################
# ModuleLoader.ts – JSON Loader
########################################
cat << 'EOC' > "$BASE/modules/ModuleLoader.ts"
export async function loadDeck(deckId) {
  try {
    const mod = await import(\`../engine/data/\${deckId}.json\`);
    return mod.default;
  } catch {
    return null;
  }
}
EOC

########################################
# ProgressStore.ts – Lernfortschritt
########################################
cat << 'EOC' > "$BASE/store/ProgressStore.ts"
const KEY = "shadowlearn_progress";

export function saveProgress(data) {
  localStorage.setItem(KEY, JSON.stringify(data));
}

export function loadProgress() {
  try {
    return JSON.parse(localStorage.getItem(KEY)) || {};
  } catch {
    return {};
  }
}
EOC

echo "[✓] ShadowLearn UI Megapack installiert."
