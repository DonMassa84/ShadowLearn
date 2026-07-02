"""
telegram_bot.py
Telegram-Bot für Textverbesserung via Perplexity API.
Polling-Modus. Kein Webhook.
"""

import logging
import os
from pathlib import Path

from dotenv import load_dotenv
from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    ContextTypes,
    MessageHandler,
    filters,
)

from perplexity_text_improver import improve_text, get_api_key, split_chunks

# .env laden
_env_path = Path(__file__).parent / ".env"
if _env_path.exists():
    load_dotenv(_env_path)
else:
    load_dotenv()

logging.basicConfig(
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    level=logging.INFO,
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(Path(__file__).parent / "logs" / "telegram.log"),
    ],
)
logger = logging.getLogger(__name__)

HELP_TEXT = """
*ShadowMaker Textbot*

Befehle:
/improve <Text> — Standard-Verbesserung
/tg <Text> — Für Telegram optimieren
/discord <Text> — Für Discord optimieren
/ihk <Text> — IHK-Prüfungssprache
/help — Diese Hilfe

Oder schick einfach einen Text — er wird automatisch verbessert.
""".strip()


async def send_long(update: Update, text: str) -> None:
    """Lange Texte in Chunks senden — mit Telegram MarkdownV2-Rendering."""
    for chunk in split_chunks(text, 4000):
        try:
            await update.message.reply_text(chunk, parse_mode="Markdown")
        except Exception:
            # Fallback: plain text wenn Sonderzeichen Markdown brechen
            plain = chunk.replace("*", "").replace("_", "").replace("`", "").replace("[", "").replace("]", "")
            await update.message.reply_text(plain)


async def cmd_start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(
        "Hallo! Ich verbessere Texte via Perplexity.\n\n" + HELP_TEXT,
        parse_mode="Markdown",
    )


async def cmd_help(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(HELP_TEXT, parse_mode="Markdown")


async def _handle_improve(update: Update, mode: str, args: list[str]) -> None:
    text = " ".join(args).strip()
    if not text:
        await update.message.reply_text(
            f"Bitte Text angeben. Beispiel: `/{mode} Dein Text hier.`",
            parse_mode="Markdown",
        )
        return
    # Wartestatus senden und danach mit dem Ergebnis ersetzen
    wait_msg = await update.message.reply_text("_Verbessere Text…_", parse_mode="Markdown")
    result = improve_text(text, mode)
    # Wartestatus löschen, dann Ergebnis senden
    try:
        await wait_msg.delete()
    except Exception:
        pass
    await send_long(update, result)


async def cmd_improve(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await _handle_improve(update, "standard", context.args or [])


async def cmd_tg(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await _handle_improve(update, "telegram", context.args or [])


async def cmd_discord(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await _handle_improve(update, "discord", context.args or [])


async def cmd_ihk(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await _handle_improve(update, "ihk", context.args or [])


async def handle_text(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Normaler Text → Standard-Verbesserung."""
    text = update.message.text.strip()
    if not text or text.startswith("/"):
        return
    wait_msg = await update.message.reply_text("_Verbessere Text…_", parse_mode="Markdown")
    result = improve_text(text, "standard")
    try:
        await wait_msg.delete()
    except Exception:
        pass
    await send_long(update, result)


def main() -> None:
    token = os.environ.get("TELEGRAM_BOT_TOKEN", "").strip()
    if not token or len(token) < 10:
        raise SystemExit("FEHLER: TELEGRAM_BOT_TOKEN nicht gesetzt oder ungültig.")

    if not get_api_key():
        logger.warning("WARNUNG: Kein gültiger Perplexity-Key — Textverbesserung wird Fehler liefern.")

    app = Application.builder().token(token).build()

    app.add_handler(CommandHandler("start", cmd_start))
    app.add_handler(CommandHandler("help", cmd_help))
    app.add_handler(CommandHandler("improve", cmd_improve))
    app.add_handler(CommandHandler("tg", cmd_tg))
    app.add_handler(CommandHandler("discord", cmd_discord))
    app.add_handler(CommandHandler("ihk", cmd_ihk))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_text))

    logger.info("Telegram-Bot gestartet (Polling)")
    app.run_polling(allowed_updates=Update.ALL_TYPES)


if __name__ == "__main__":
    main()
