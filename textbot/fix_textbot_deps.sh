#!/usr/bin/env bash
set -euo pipefail

cd ~/Schreibtisch/textbot

echo "==> Erstelle/prüfe venv"
python3 -m venv .venv

echo "==> Aktiviere venv"
source .venv/bin/activate

echo "==> Upgrade pip"
python -m pip install --upgrade pip setuptools wheel

echo "==> Installiere Bot-Abhängigkeiten"
python -m pip install \
  python-telegram-bot \
  discord.py \
  python-dotenv \
  requests

echo "==> Prüfe Imports"
python - <<'PY'
from telegram import Update
import discord
print("OK: telegram und discord imports funktionieren")
PY

echo "==> Fertig"
echo "Starte danach mit:"
echo "source .venv/bin/activate"
echo "bash run_telegram.sh"
echo "bash run_discord.sh"
