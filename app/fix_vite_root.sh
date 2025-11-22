#!/usr/bin/env bash
set -euo pipefail

FILE="$HOME/Dokumente/ShadowLearn/app/vite.config.ts"

cat << 'EOC' > "$FILE"
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  root: ".",
  publicDir: "public",
  build: {
    outDir: "dist",
    emptyOutDir: true,
  },
  server: {
    port: 5173,
  },
});
EOC

echo "[✓] vite.config.ts korrigiert."
echo "[!] Starte jetzt: npm run dev"
