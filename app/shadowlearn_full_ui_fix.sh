#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app/src"

echo "[1/6] Repariere index.css …"
cat << 'CSS' > "$APP/index.css"
@import "animate.css";
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-slate-900 text-slate-200;
}

.fade-in {
  animation: fadeIn 0.5s ease-in-out;
}

.card-pop {
  animation: zoomIn 0.3s ease;
}
CSS

echo "[2/6] Repariere AppLayout …"
mkdir -p "$APP/app/layout"
cat << 'LAY' > "$APP/app/layout/AppLayout.tsx"
import React from "react";

export default function AppLayout({ children }) {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-200 flex justify-center p-8 animate__animated animate__fadeIn">
      <div className="w-full max-w-3xl">{children}</div>
    </div>
  );
}
LAY

echo "[3/6] Repariere NavigationBar …"
mkdir -p "$APP/app/components"
cat << 'NAV' > "$APP/app/components/NavigationBar.tsx"
import React from "react";
import { NavLink } from "react-router-dom";

export default function NavigationBar() {
  const link = "px-4 py-2 text-slate-300 hover:text-cyan-300 transition";
  const active = "text-cyan-300 underline";

  return (
    <nav className="w-full flex gap-6 p-4 bg-slate-800 shadow-lg animate__animated animate__fadeInDown">
      <NavLink to="/learn" className={({isActive}) => isActive ? active : link}>Lernen</NavLink>
      <NavLink to="/topics" className={({isActive}) => isActive ? active : link}>Themen</NavLink>
      <NavLink to="/decks" className={({isActive}) => isActive ? active : link}>Decks</NavLink>
      <NavLink to="/import" className={({isActive}) => isActive ? active : link}>Import</NavLink>
    </nav>
  );
}
NAV

echo "[4/6] Repariere LearnView …"
mkdir -p "$APP/app/views"
cat << 'LEARN' > "$APP/app/views/LearnView.tsx"
import React, { useState } from "react";
import FlashcardView from "../components/FlashcardView";
import NavigationBar from "../components/NavigationBar";
import data from "../../engine/data/default.json";

export default function LearnView() {
  const [index, setIndex] = useState(0);
  const card = data[index];

  return (
    <>
      <NavigationBar />
      <div className="p-6 animate__animated animate__fadeIn">
        <h1 className="text-2xl mb-4 text-cyan-300">Aktiver Lernmodus</h1>
        {card ? (
          <FlashcardView card={card} className="card-pop" />
        ) : (
          <p>Keine Karte geladen.</p>
        )}
        <div className="mt-4 flex gap-4">
          <button className="px-4 py-2 bg-slate-700 hover:bg-slate-600" onClick={() => setIndex(i => Math.max(0, i - 1))}>Zurück</button>
          <button className="px-4 py-2 bg-slate-700 hover:bg-slate-600" onClick={() => setIndex(i => (i + 1) % data.length)}>Weiter</button>
        </div>
      </div>
    </>
  );
}
LEARN

echo "[5/6] FlashcardView Animation …"
cat << 'CARD' > "$APP/app/components/FlashcardView.tsx"
import React from "react";

export default function FlashcardView({ card }) {
  if (!card) return null;
  return (
    <div className="bg-slate-800 p-6 rounded-xl shadow-xl animate__animated animate__fadeIn card-pop">
      <h2 className="text-xl font-bold mb-2 text-cyan-300">{card.question}</h2>
      <p className="text-slate-300">{card.answer}</p>
    </div>
  );
}
CARD

echo "[6/6] App neu starten …"
cd "$HOME/Dokumente/ShadowLearn/app"
npm run dev
