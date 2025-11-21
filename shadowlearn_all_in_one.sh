#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/Dokumente/ShadowLearn"

cd "$PROJECT_DIR"

if [ -f "src/pages/Session.tsx" ]; then
  sed -E -i 's/^([[:space:]]*)\{duration \? .*$/\1{duration ? duration + " min session" : "Distraction Free"}/' src/pages/Session.tsx || true
fi

if [ -f "src/constants.ts" ]; then
  sed -E -i 's/^([[:space:]]*)\"*topic\":/\1topic:/g' src/constants.ts || true
  sed -E -i 's/^([[:space:]]*)\"*type\":/\1type:/g' src/constants.ts || true
  sed -E -i 's/^([[:space:]]*)\"*difficulty\":/\1difficulty:/g' src/constants.ts || true
  sed -E -i 's/^([[:space:]]*)\"*front\":/\1front:/g' src/constants.ts || true
  sed -E -i 's/^([[:space:]]*)\"*back\":/\1back:/g' src/constants.ts || true
  sed -E -i 's/^([[:space:]]*)\"*tags\":/\1tags:/g' src/constants.ts || true
fi

if [ ! -d node_modules ]; then
  npm install
fi

mode="${1-}"

if [ "$mode" = "dev" ]; then
  npm run dev
else
  npm run build
fi
