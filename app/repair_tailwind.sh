#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app"

echo "[+] Fixing index.css"
mkdir -p "$APP/src"
cat << 'EOC' > "$APP/src/index.css"
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-slate-900 text-slate-200;
}
EOC

echo "[+] Fixing tailwind.config.js"
cat << 'EOD' > "$APP/tailwind.config.js"
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "./src/app/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOD

echo "[+] Fixing postcss.config.js"
cat << 'EOE' > "$APP/postcss.config.js"
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
EOE

echo "[+] Fixing main.tsx import"
cat << 'EOF2' > "$APP/src/main.tsx"
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF2

echo "[✓] Tailwind repaired successfully."
echo "[!] Run now: npm run dev"
