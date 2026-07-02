#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== RELEASE CHECK ===="
bash scripts/doctor.sh
bash scripts/smoke-test.sh
bash scripts/security-scan.sh

if [[ -n "$(git status --short)" ]]; then
  echo "[INFO] Working tree has changes:"
  git status --short
else
  echo "[OK] Working tree clean"
fi

echo "[DONE] Release check complete."
