#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== SMOKE TEST ===="
git rev-parse --is-inside-work-tree >/dev/null
echo "[OK] Git repo detected"

if [[ -f package.json ]]; then
  echo "[INFO] Node project detected"
  node --version || true
  npm --version || true
fi

if [[ -f pyproject.toml || -f requirements.txt || -f main.py ]]; then
  echo "[INFO] Python project detected"
  python3 --version
fi

if find . -maxdepth 3 -type f -name "*.sh" | grep -q .; then
  echo "[INFO] Bash scripts detected"
  while IFS= read -r f; do
    bash -n "$f"
    echo "[OK] syntax: $f"
  done < <(find . -maxdepth 3 -type f -name "*.sh" | sort)
fi

echo "[DONE] Smoke test finished."
