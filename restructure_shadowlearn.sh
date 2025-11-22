#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn"

cd "$BASE"

echo "[+] Creating new folder structure ..."
mkdir -p app/src/{app,engine,modules,data,assets}
mkdir -p shadow
mkdir -p meta/logs

echo "[+] Moving frontend root files into app/ ..."
mv -f index.html app/ 2>/dev/null || true
mv -f tailwind.config.js app/ 2>/dev/null || true
mv -f postcss.config.js app/ 2>/dev/null || true
mv -f vite.config.ts app/ 2>/dev/null || true
mv -f package.json app/ 2>/dev/null || true
mv -f package-lock.json app/ 2>/dev/null || true

echo "[+] Moving src/ into app/src/ ..."
mv -f src app/ 2>/dev/null || true

echo "[+] Moving ShadowMaker scripts ..."
mv -f shadowlearn_all_in_one.sh shadow/ 2>/dev/null || true
mv -f shadowlearn_autofix.sh shadow/ 2>/dev/null || true
mv -f shadowlearn_start.sh shadow/ 2>/dev/null || true
mv -f shadowlearn_env_git_all.sh shadow/ 2>/dev/null || true
mv -f shadowlearn_check.sh shadow/ 2>/dev/null || true

echo "[+] Moving .env and other meta files ..."
mv -f .env meta/ 2>/dev/null || true
mv -f .env.local meta/ 2>/dev/null || true

echo "[+] Cleaning old empty folders ..."
find "$BASE" -type d -empty -delete || true

echo "[+] DONE. New structure ready."
echo "[!] Now run: bash restructure_shadowlearn.sh"
