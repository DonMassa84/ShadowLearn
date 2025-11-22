#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src"

echo "[+] Ensuring src folder exists ..."
mkdir -p "$BASE"

echo "[+] Writing main.tsx ..."
cat << 'EOC' > "$BASE/main.tsx"
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOC

echo "[+] Writing App.tsx ..."
cat << 'EOD' > "$BASE/App.tsx"
import React from "react";
import AppRouter from "./app/router";

export default function App() {
  return (
    <div className="min-h-screen bg-slate-900">
      <AppRouter />
    </div>
  );
}
EOD

echo "[✓] App.tsx und main.tsx erfolgreich erstellt."
echo "[!] Starte jetzt: npm run dev"
