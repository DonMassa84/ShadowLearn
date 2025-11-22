#!/usr/bin/env bash
set -euo pipefail

CONF="$HOME/Dokumente/ShadowLearn/app/vite.config.ts"

echo "[+] Writing corrected vite.config.ts ..."

cat << 'EOC' > "$CONF"
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  root: "app",
  base: "/ShadowLearn/",
  build: {
    outDir: "dist",
    emptyOutDir: true,
  },
});
EOC

echo "[✓] vite.config.ts erfolgreich korrigiert."
echo "[!] Starte jetzt die App mit: npm run dev"
