#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== REPO DOCTOR ===="
echo "Repo: $(basename "$PWD")"
echo "Path: $PWD"
echo

fail=0

check_file() {
  local f="$1"
  if [[ -e "$f" ]]; then
    echo "[OK] $f"
  else
    echo "[MISS] $f"
    fail=1
  fi
}

check_file README.md
check_file Makefile
check_file .gitignore
check_file .env.example
check_file docs/ARCHITECTURE.md
check_file docs/RUNBOOK.md
check_file docs/REPRODUCIBILITY.md
check_file docs/SECURITY.md
check_file docs/RELEASE_PROCESS.md
check_file docs/PROJECT_COMPLETION_CHECKLIST.md
check_file scripts/smoke-test.sh
check_file scripts/security-scan.sh
check_file scripts/release-check.sh

echo
echo "== Git =="
git status --short || true

echo
echo "== Stack =="
[[ -f package.json ]] && echo "[OK] Node package.json found"
[[ -f pyproject.toml ]] && echo "[OK] Python pyproject.toml found"
[[ -f requirements.txt ]] && echo "[OK] Python requirements.txt found"

if find . -maxdepth 3 -type f -name "*.sh" | grep -q .; then
  find . -maxdepth 3 -type f -name "*.sh" | head -5 | sed 's#^\./#[OK] Bash file: #'
fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "[DONE] Repo standard baseline complete."
else
  echo "[WARN] Repo baseline incomplete."
fi

exit 0
