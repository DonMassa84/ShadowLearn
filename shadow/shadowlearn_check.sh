#!/usr/bin/env bash
set -euo pipefail
PROJECT="$HOME/Dokumente/ShadowLearn"
cd "$PROJECT"
node -v
npm -v
git status || true
ls -R "$PROJECT/src" || true
lsof -i :5173 || true
