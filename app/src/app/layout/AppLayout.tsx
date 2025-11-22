import React from "react";

export default function AppLayout({ children }) {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-200 flex justify-center p-8 animate__animated animate__fadeIn">
      <div className="w-full max-w-3xl">{children}</div>
    </div>
  );
}
