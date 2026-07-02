#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== AGENT DOCTOR ===="
echo "Repo: $(basename "$PWD")"
echo "Path: $PWD"
echo

fail=0

check() {
  local f="$1"
  if [[ -f "$f" ]]; then
    echo "[OK] $f"
  else
    echo "[MISS] $f"
    fail=1
  fi
}

check docs/agent/README.md
check docs/agent/AI_AGENT_KNOWLEDGE.md
check docs/agent/AI_AGENT_MASTER_PROMPTS.md
check docs/agent/REPO_AGENT_MAPPING.md

echo
echo "== Agent terms =="
for term in Model Tools Memory Audio Guardrails Orchestration; do
  if grep -Riq "$term" docs/agent 2>/dev/null; then
    echo "[OK] $term"
  else
    echo "[MISS] $term"
    fail=1
  fi
done

echo
echo "== Security terms =="
for term in Secrets Human Review lokale Pfade; do
  if grep -Riq "$term" docs/agent 2>/dev/null; then
    echo "[OK] $term"
  else
    echo "[WARN] term not found: $term"
  fi
done

echo
if [[ "$fail" -eq 0 ]]; then
  echo "[DONE] Agent knowledge installed."
else
  echo "[WARN] Agent knowledge incomplete."
fi

exit "$fail"
