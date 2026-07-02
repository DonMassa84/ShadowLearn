"""
perplexity_text_improver.py
Textverbesserung via Perplexity API.
Keine Secrets ausgeben. PERPLEXITY_API_KEY bevorzugen.
"""

import os
import textwrap
from pathlib import Path

import requests
from dotenv import load_dotenv

# .env laden (Projektverzeichnis)
_env_path = Path(__file__).parent / ".env"
if _env_path.exists():
    load_dotenv(_env_path)
else:
    load_dotenv()

ENDPOINT = "https://api.perplexity.ai/chat/completions"
TIMEOUT = 45

_PLACEHOLDERS = {
    "", "pxp_xxx", "dein_key", "dein-key", "changeme",
    "test", "dummy", "your_key", "xxx", "none", "null",
}

_SYSTEM_PROMPTS = {
    "standard": (
        "Du bist ein erfahrener deutschsprachiger Lektor. "
        "Verbessere den folgenden Text so, dass er klar, verständlich und angenehm zu lesen ist. "
        "Korrigiere Rechtschreibung und Grammatik. Mache Sätze flüssiger, ohne den Sinn zu verändern. "
        "Behalte den Ton und die Aussage exakt bei. Erfinde nichts hinzu. "
        "Antworte ausschließlich mit dem verbesserten Text — keine Erklärungen, keine Einleitung."
    ),
    "telegram": (
        "Du bist ein Texter, der Nachrichten für Telegram optimiert. "
        "Schreibe den Text so um, dass er wie eine natürliche, freundliche Nachricht klingt: "
        "kurz, klar, ohne Amtsdeutsch, ohne unnötige Fachbegriffe. "
        "Maximal 3–5 Sätze. Keine Aufzählungen außer wenn wirklich nötig. "
        "Kein Emoji-Spam. Antworte nur mit dem fertigen Telegram-Text."
    ),
    "discord": (
        "Du bist ein Texter, der Nachrichten für Discord optimiert. "
        "Schreibe den Text so um, dass er locker, direkt und gut lesbar ist — "
        "wie eine Nachricht von einem echten Teammitglied, nicht wie ein automatischer Report. "
        "Nutze Discord-Markdown (** für fett, ` für Code) nur wenn es wirklich hilft. "
        "Keine Wall-of-Text. Antworte nur mit dem fertigen Discord-Text."
    ),
    "ihk": (
        "Du bist ein erfahrener IHK-Prüfer und Ausbilder. "
        "Formuliere den folgenden Text in sauberer, prüfungssicherer IHK-Sprache: "
        "sachlich, strukturiert, mit klarer Situation, konkretem Ziel, benannten Maßnahmen "
        "und Erfolgskontrolle. Nenne Rechtsgrundlagen nur wenn sie im Original vorhanden oder "
        "offensichtlich zutreffend sind. Keine erfundenen Paragrafen. "
        "Antworte ausschließlich mit dem verbesserten IHK-Text."
    ),
}


def is_placeholder(value: str) -> bool:
    """Prüft ob ein Wert ein Platzhalter ist."""
    if not value:
        return True
    v = value.strip().lower()
    if v in _PLACEHOLDERS:
        return True
    if len(v) < 10:
        return True
    return False


def get_api_key() -> str:
    """
    Wählt den ersten gültigen API-Key.
    Bevorzugt PERPLEXITY_API_KEY. Gibt leeren String wenn keiner gültig.
    Gibt niemals den Key aus.
    """
    pxp = os.environ.get("PERPLEXITY_API_KEY", "").strip()
    pplx = os.environ.get("PPLX_API_KEY", "").strip()

    if not is_placeholder(pxp):
        return pxp
    if not is_placeholder(pplx):
        return pplx
    return ""


def get_model() -> str:
    return os.environ.get("PERPLEXITY_MODEL", "sonar-pro").strip() or "sonar-pro"


def split_chunks(text: str, limit: int = 3800) -> list[str]:
    """Teilt langen Text in Chunks für Telegram/Discord."""
    if len(text) <= limit:
        return [text]
    chunks = []
    while text:
        if len(text) <= limit:
            chunks.append(text)
            break
        split_at = text.rfind("\n", 0, limit)
        if split_at == -1:
            split_at = limit
        chunks.append(text[:split_at].strip())
        text = text[split_at:].strip()
    return chunks


def improve_text(text: str, mode: str = "standard") -> str:
    """
    Verbessert Text via Perplexity API.
    Gibt verbesserten Text oder Fehlermeldung zurück.
    Keine Secrets ausgeben.
    """
    text = text.strip()
    if not text:
        return "Fehler: Kein Text übergeben."

    api_key = get_api_key()
    if not api_key:
        return (
            "Fehler: Kein gültiger Perplexity-API-Key gefunden.\n"
            "Bitte PERPLEXITY_API_KEY in .env oder als Umgebungsvariable setzen."
        )

    system_prompt = _SYSTEM_PROMPTS.get(mode, _SYSTEM_PROMPTS["standard"])
    model = get_model()

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }
    payload = {
        "model": model,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": text},
        ],
        "max_tokens": 1024,
        "temperature": 0.2,
    }

    try:
        resp = requests.post(ENDPOINT, headers=headers, json=payload, timeout=TIMEOUT)
        if resp.status_code == 401:
            return "Fehler: API-Key ungültig oder abgelaufen (401)."
        if resp.status_code == 429:
            return "Fehler: Rate Limit erreicht (429). Bitte kurz warten."
        if resp.status_code == 400:
            return f"Fehler: Ungültige Anfrage (400). Modell: {model}"
        resp.raise_for_status()
        data = resp.json()
        return data["choices"][0]["message"]["content"].strip()
    except requests.Timeout:
        return f"Fehler: Timeout nach {TIMEOUT}s. Bitte nochmal versuchen."
    except requests.RequestException as e:
        return f"Fehler: Verbindungsproblem — {type(e).__name__}"
    except (KeyError, IndexError):
        return "Fehler: Unerwartetes API-Antwortformat."


if __name__ == "__main__":
    import sys
    text = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "das ist ein test text mit fehler"
    mode = "standard"
    print(f"Modus: {mode}")
    print(f"Modell: {get_model()}")
    print(f"Key vorhanden: {'ja' if get_api_key() else 'nein'}")
    print("\nErgebnis:")
    print(improve_text(text, mode))
