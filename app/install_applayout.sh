#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app/layout"

mkdir -p "$BASE"

cat << 'EOC' > "$BASE/AppLayout.tsx"
import React from "react";

export default function AppLayout({ children }) {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-200 flex justify-center p-6">
      <div className="w-full max-w-2xl">{children}</div>
    </div>
  );
}
EOC

echo "[✓] AppLayout.tsx installiert."
