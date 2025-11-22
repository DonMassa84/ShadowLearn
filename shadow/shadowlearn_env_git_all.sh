#!/usr/bin/env bash
set -euo pipefail

PROJECT="$HOME/Dokumente/ShadowLearn"
cd "$PROJECT"

if [ ! -f ".env" ]; then
    cat << 'E2' > .env
VITE_GITHUB_TOKEN=
VITE_OPENAI_API_KEY=
E2
fi

if ! command -v python >/dev/null 2>&1; then
    sudo ln -sf /usr/bin/python3 /usr/bin/python
fi

if [ ! -d ".git" ]; then
    git init
    git branch -M main
fi

git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/DonMassa84/ShadowLearn.git"

git add .
git commit -m "ShadowLearn AutoSync"
git push -u --force origin main
