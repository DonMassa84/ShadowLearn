#!/usr/bin/env bash
set -euo pipefail

CONF="$HOME/Dokumente/ShadowLearn/app/vite.config.ts"

cat << 'EOC' > "$CONF"
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  base: "/",
  build: {
    outDir: "../dist",
    emptyOutDir: true,
  },
});
EOC

echo "[✓] vite.config.ts vollständig repariert."
echo "[!] Starte jetzt: npm run dev"
