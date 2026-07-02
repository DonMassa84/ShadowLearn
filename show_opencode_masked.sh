#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${1:-$(pwd)}"

echo "============================================================"
echo " OPENCODE MASKED CONFIG / API OVERVIEW"
echo " Project: $PROJECT_DIR"
echo "============================================================"
echo

mask_file() {
  local file="$1"

  if [[ ! -f "$file" ]]; then
    return 0
  fi

  echo
  echo "############################################################"
  echo "# FILE: $file"
  echo "############################################################"
  echo

  sed -E '
    s/(api[_-]?key[[:space:]]*[:=][[:space:]]*["'\'']?)[^"'\''[:space:]]+/\1***MASKED***/Ig;
    s/(token[[:space:]]*[:=][[:space:]]*["'\'']?)[^"'\''[:space:]]+/\1***MASKED***/Ig;
    s/(secret[[:space:]]*[:=][[:space:]]*["'\'']?)[^"'\''[:space:]]+/\1***MASKED***/Ig;
    s/(password[[:space:]]*[:=][[:space:]]*["'\'']?)[^"'\''[:space:]]+/\1***MASKED***/Ig;
    s/(bearer[[:space:]]+)[A-Za-z0-9._~+\/=-]+/\1***MASKED***/Ig;
    s/(sk-[A-Za-z0-9_-]{8})[A-Za-z0-9_-]+/\1***MASKED***/g;
    s/(OPENAI_API_KEY[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
    s/(ANTHROPIC_API_KEY[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
    s/(GOOGLE_API_KEY[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
    s/(GEMINI_API_KEY[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
    s/(GITHUB_TOKEN[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
    s/(HF_TOKEN[[:space:]]*=[[:space:]]*)[^[:space:]]+/\1***MASKED***/Ig;
  ' "$file"
}

echo "Scanning relevant files only..."
echo

FILES=(
  "$PROJECT_DIR/.env"
  "$PROJECT_DIR/.env.local"
  "$PROJECT_DIR/.envrc"
  "$PROJECT_DIR/.opencode.json"
  "$PROJECT_DIR/opencode.json"
  "$PROJECT_DIR/AGENTS.md"
  "$PROJECT_DIR/WORKFLOWS.md"
  "$PROJECT_DIR/.opencode/memory.md"
  "$HOME/.config/opencode/opencode.json"
  "$HOME/.config/opencode/config.json"
  "$HOME/.opencode.json"
  "$HOME/.bashrc"
  "$HOME/.zshrc"
  "$HOME/.profile"
)

for file in "${FILES[@]}"; do
  mask_file "$file"
done

echo
echo "============================================================"
echo " ENVIRONMENT VARIABLES — MASKED"
echo "============================================================"
echo

env | sort | grep -Ei 'api|key|token|secret|password|openai|anthropic|google|gemini|github|hf|ollama|opencode' \
  | sed -E '
      s/(=).+/\1***MASKED***/g;
    ' || true

echo
echo "============================================================"
echo " DONE — no secrets printed raw"
echo "============================================================"
