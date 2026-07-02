"""
discord_bot.py
Discord-Bot für Textverbesserung via Perplexity API.
Prefix: !  |  intents.message_content = True
Befehle: start, help, improve, tg, discord, ihk
"""

import logging
import os
from pathlib import Path

import discord
from discord.ext import commands
from dotenv import load_dotenv

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
        logging.FileHandler(Path(__file__).parent / "logs" / "discord.log"),
    ],
)
logger = logging.getLogger(__name__)

HELP_TEXT = """
**ShadowMaker Textbot**

Befehle (Prefix: `!`):
`!improve <Text>` — Standard-Verbesserung
`!tg <Text>` — Für Telegram optimieren
`!discord <Text>` — Für Discord optimieren
`!ihk <Text>` — IHK-Prüfungssprache
`!help` — Diese Hilfe

Oder erwähne mich mit Text — er wird automatisch verbessert.
""".strip()

WELCOME_TEXT = """
Hallo! Ich verbessere Texte via Perplexity.

{help}
""".strip().format(help=HELP_TEXT)

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix="!", intents=intents, help_command=None)


async def send_long(ctx: commands.Context, text: str) -> None:
    """Lange Texte in Chunks senden — als normaler Discord-Text, kein Codeblock."""
    for chunk in split_chunks(text, 1900):
        await ctx.send(chunk)


async def _handle(ctx: commands.Context, mode: str, text: str) -> None:
    text = text.strip()
    if not text:
        await ctx.send(f"Bitte Text angeben. Beispiel: `!{mode} Dein Text hier.`")
        return
    msg = await ctx.send("*Verbessere Text…*")
    result = improve_text(text, mode)
    try:
        await msg.delete()
    except Exception:
        pass
    await send_long(ctx, result)


@bot.event
async def on_ready() -> None:
    logger.info(f"Discord-Bot eingeloggt als {bot.user} ({bot.user.id})")


# ── Befehle (spiegelgleich zu Telegram) ───────────────────────────────────────

@bot.command(name="start")
async def cmd_start(ctx: commands.Context) -> None:
    """Begrüßung + Befehlsübersicht."""
    await ctx.send(WELCOME_TEXT)


@bot.command(name="help")
async def cmd_help(ctx: commands.Context) -> None:
    """Befehlsübersicht."""
    await ctx.send(HELP_TEXT)


@bot.command(name="improve")
async def cmd_improve(ctx: commands.Context, *, text: str = "") -> None:
    """Standard-Textverbesserung."""
    await _handle(ctx, "standard", text)


@bot.command(name="tg")
async def cmd_tg(ctx: commands.Context, *, text: str = "") -> None:
    """Für Telegram optimieren."""
    await _handle(ctx, "telegram", text)


@bot.command(name="discord")
async def cmd_discord(ctx: commands.Context, *, text: str = "") -> None:
    """Für Discord optimieren."""
    await _handle(ctx, "discord", text)


@bot.command(name="ihk")
async def cmd_ihk(ctx: commands.Context, *, text: str = "") -> None:
    """IHK-Prüfungssprache."""
    await _handle(ctx, "ihk", text)


# ── @-Erwähnung → automatische Verbesserung ───────────────────────────────────

@bot.event
async def on_message(message: discord.Message) -> None:
    if message.author.bot:
        return
    if bot.user in message.mentions:
        text = message.content.replace(f"<@{bot.user.id}>", "").strip()
        text = text.replace(f"<@!{bot.user.id}>", "").strip()
        if text:
            wait = await message.channel.send("*Verbessere Text…*")
            result = improve_text(text, "standard")
            try:
                await wait.delete()
            except Exception:
                pass
            await send_long_msg(message, result)
            return
    await bot.process_commands(message)


async def send_long_msg(message: discord.Message, text: str) -> None:
    """Für @-Erwähnungen: plain text, kein Codeblock."""
    for chunk in split_chunks(text, 1900):
        await message.channel.send(chunk)


def main() -> None:
    token = os.environ.get("DISCORD_BOT_TOKEN", "").strip()
    if not token or len(token) < 10:
        raise SystemExit("FEHLER: DISCORD_BOT_TOKEN nicht gesetzt oder ungültig.")

    if not get_api_key():
        logger.warning("WARNUNG: Kein gültiger Perplexity-Key — Textverbesserung wird Fehler liefern.")

    logger.info("Discord-Bot wird gestartet...")
    bot.run(token, log_handler=None)


if __name__ == "__main__":
    main()
