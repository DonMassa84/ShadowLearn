#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/Dokumente/ShadowLearn"
npm install --legacy-peer-deps
npm audit fix --force || true
npm install typescript vite react react-dom
npm install -D @types/react @types/react-dom
if ! command -v python >/dev/null 2>&1; then sudo ln -sf /usr/bin/python3 /usr/bin/python; fi
if [ ! -f "src/constants.ts" ]; then touch src/constants.ts; fi
if [ ! -f "src/pages/Session.tsx" ]; then mkdir -p src/pages && touch src/pages/Session.tsx; fi
npm run build || true
