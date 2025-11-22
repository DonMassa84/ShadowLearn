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
