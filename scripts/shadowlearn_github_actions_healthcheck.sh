#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== SHADOWLEARN GITHUB ACTIONS HEALTHCHECK ===="
date
echo

FAIL=0
WARN=0

ok(){ echo "[OK] $*"; }
warn(){ echo "[WARN] $*"; WARN=$((WARN+1)); }
fail(){ echo "[FEHLER] $*"; FAIL=$((FAIL+1)); }

REPO="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$REPO" ]; then
  fail "Kein Git-Repo."
  exit 1
fi

cd "$REPO"
ok "Repo: $REPO"
echo

echo "== 1) Git Status =="
git status --short --branch
if [ -n "$(git status --porcelain)" ]; then
  warn "Arbeitsbaum hat Änderungen. Vor Push/Commit bewusst prüfen."
else
  ok "Arbeitsbaum sauber."
fi
echo

echo "== 2) Workflow-Struktur =="
if [ -d ".github/workflows" ]; then
  ok ".github/workflows vorhanden."
  find .github/workflows -maxdepth 1 -type f \( -name '*.yml' -o -name '*.yaml' \) -print | sort
else
  fail ".github/workflows fehlt."
fi

if [ -f ".github/workflows/deploy.yml" ]; then
  ok "deploy.yml vorhanden."
else
  warn "deploy.yml fehlt."
fi
echo

echo "== 3) GitHub Pages Datei =="
if [ -f "index.html" ]; then
  ok "index.html vorhanden."
  SIZE="$(wc -c < index.html | tr -d ' ')"
  echo "index.html bytes: $SIZE"
  if [ "${SIZE:-0}" -lt 20 ]; then
    warn "index.html wirkt sehr klein."
  fi
else
  fail "index.html fehlt."
fi
echo

echo "== 4) .gitignore =="
if [ -f ".gitignore" ]; then
  ok ".gitignore vorhanden."
  for pattern in ".env" "node_modules" "__pycache__" "logs" "Freies Radio Stuttgart 20-11-25"; do
    if grep -Fq "$pattern" .gitignore; then
      ok ".gitignore enthält: $pattern"
    else
      warn ".gitignore enthält nicht sichtbar: $pattern"
    fi
  done
else
  fail ".gitignore fehlt."
fi
echo

echo "== 5) Getrackte .env-Dateien =="
TRACKED_ENV="$(git ls-files | grep -E '(^|/)\.env($|\.)' | grep -vE '(^|/)\.env\.example$' || true)"
if [ -n "$TRACKED_ENV" ]; then
  fail "Getrackte .env-Dateien gefunden:"
  echo "$TRACKED_ENV"
else
  ok "Keine getrackten .env-Dateien außer erlaubter .env.example."
fi
echo

echo "== 6) Grober Secret-Pattern-Scan in getrackten Dateien =="
TMP="$(mktemp)"
git ls-files -z \
| xargs -0 -r grep -IhnE 'sk-[A-Za-z0-9_-]{30,}|ghp_[A-Za-z0-9_]{30,}|github_pat_[A-Za-z0-9_]{30,}|xox[baprs]-[A-Za-z0-9-]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC |DSA |)?PRIVATE KEY-----' \
  2>/dev/null \
| sed -E 's/(sk-[A-Za-z0-9_-]{8})[A-Za-z0-9_-]+/\1…REDACTED/g; s/(ghp_[A-Za-z0-9_]{8})[A-Za-z0-9_]+/\1…REDACTED/g; s/(github_pat_[A-Za-z0-9_]{8})[A-Za-z0-9_]+/\1…REDACTED/g' \
> "$TMP" || true

if [ -s "$TMP" ]; then
  warn "Mögliche Secret-Pattern-Treffer. Prüfen:"
  head -n 80 "$TMP"
else
  ok "Keine groben High-Confidence Secret-Pattern-Treffer."
fi
rm -f "$TMP"
echo

echo "== 7) YAML Grobprüfung =="
if [ -f ".github/workflows/deploy.yml" ]; then
  if python3 - <<'PY'
from pathlib import Path
p = Path(".github/workflows/deploy.yml")
txt = p.read_text(encoding="utf-8")
required = ["name:", "on:"]
missing = [x for x in required if x not in txt]
if missing:
    raise SystemExit("missing " + ",".join(missing))
print("deploy.yml enthält name/on.")
PY
  then
    ok "deploy.yml Grobprüfung bestanden."
  else
    warn "deploy.yml Grobprüfung auffällig."
  fi
fi
echo

echo "== Ergebnis =="
echo "WARN=$WARN"
echo "FAIL=$FAIL"

if [ "$FAIL" -eq 0 ]; then
  echo "[OK] Healthcheck ohne harte Fehler abgeschlossen."
  exit 0
else
  echo "[FEHLER] Healthcheck mit $FAIL harten Fehlern."
  exit 1
fi
