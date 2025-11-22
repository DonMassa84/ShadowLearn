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
