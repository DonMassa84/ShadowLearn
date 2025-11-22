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
