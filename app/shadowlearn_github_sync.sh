#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/Dokumente/ShadowLearn"
cd "$REPO_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin https://github.com/DonMassa84/ShadowLearn.git
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" = "HEAD" ]; then
  git checkout -b main || true
else
  git branch -M main || true
fi

git add .
git commit -m "ShadowLearn Auto Sync $(date '+%Y-%m-%d %H:%M:%S')" || true
git push -u origin main

echo "[✓] GitHub Sync erfolgreich abgeschlossen."
