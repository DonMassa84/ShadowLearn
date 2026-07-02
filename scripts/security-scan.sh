#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== SECURITY / SECRET SCAN ===="
fail=0

patterns=(
  "OPENAI_API_KEY"
  "ghp_"
  "github_pat_"
  "xoxb-"
  "AKIA[0-9A-Z]{16}"
  "-----BEGIN PRIVATE KEY-----"
  "password="
  "passwd="
  "secret="
  "token="
)

for p in "${patterns[@]}"; do
  if grep -RInE "$p" . \
    --exclude-dir=.git \
    --exclude-dir=node_modules \
    --exclude-dir=.venv \
    --exclude-dir=venv \
    --exclude='*.md' \
    --exclude='.env.example' >/tmp/repo_secret_hits.$$ 2>/dev/null; then
    echo "[WARN] Potential secret pattern: $p"
    cat /tmp/repo_secret_hits.$$
    fail=1
  fi
done

rm -f /tmp/repo_secret_hits.$$ || true

if grep -RInE "/home/[^ ]+|C:\\\\Users\\\\" . \
  --exclude-dir=.git \
  --exclude-dir=node_modules \
  --exclude-dir=.venv \
  --exclude-dir=venv \
  --exclude='*.md' >/tmp/repo_path_hits.$$ 2>/dev/null; then
  echo "[WARN] Local path fragments found:"
  cat /tmp/repo_path_hits.$$
  fail=1
fi

rm -f /tmp/repo_path_hits.$$ || true

if [[ "$fail" -eq 0 ]]; then
  echo "[DONE] No obvious secret/local-path leaks found."
else
  echo "[FAIL] Review findings before commit/push."
fi

exit "$fail"
