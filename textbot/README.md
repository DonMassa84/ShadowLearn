# ShadowMaker Textbot

Textverbesserung via Perplexity API für Telegram und Discord.

## Setup

```bash
cd ~/Schreibtisch/textbot
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
nano .env
```

`.env` befüllen:
- `PERPLEXITY_API_KEY` — Perplexity API-Key (bevorzugt)
- `TELEGRAM_BOT_TOKEN` — Telegram Bot-Token
- `DISCORD_BOT_TOKEN` — Discord Bot-Token
- `PERPLEXITY_MODEL` — Modell (default: `sonar-pro`)

## Test

```bash
python3 test_perplexity.py
```

## Starten

```bash
# Telegram
./run_telegram.sh

# Discord
./run_discord.sh
```

## Befehle

### Telegram
| Befehl | Funktion |
|---|---|
| `/improve <Text>` | Standard-Verbesserung |
| `/tg <Text>` | Für Telegram optimieren |
| `/discord <Text>` | Für Discord optimieren |
| `/ihk <Text>` | IHK-Prüfungssprache |
| `/help` | Hilfe |
| Text senden | Automatisch verbessern |

### Discord
| Befehl | Funktion |
|---|---|
| `!improve <Text>` | Standard-Verbesserung |
| `!tg <Text>` | Für Telegram optimieren |
| `!discord <Text>` | Für Discord optimieren |
| `!ihk <Text>` | IHK-Prüfungssprache |
| `!helptext` | Hilfe |
| Bot erwähnen | Automatisch verbessern |

## Key-Check

```bash
bash ~/Schreibtisch/textbot_key_check.sh
bash ~/Schreibtisch/textbot_key_check.sh --test  # mit API-Test
```

## Sicherheit

- Keine API-Keys in Code oder Logs
- Secrets nur via `.env` oder Umgebungsvariablen
- `.env` ist in `.gitignore` aufzunehmen
