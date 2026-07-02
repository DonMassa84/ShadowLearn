"""
test_perplexity.py
Schneller Smoke-Test für die Perplexity-API-Anbindung.
Keine Secrets ausgeben.
"""

from pathlib import Path
from dotenv import load_dotenv

_env_path = Path(__file__).parent / ".env"
if _env_path.exists():
    load_dotenv(_env_path)
else:
    load_dotenv()

from perplexity_text_improver import improve_text, get_api_key, get_model

def main():
    key = get_api_key()
    model = get_model()
    print(f"Key vorhanden:  {'ja' if key else 'nein'}")
    print(f"Modell:         {model}")

    if not key:
        print("\nPerplexity-Test übersprungen: kein gültiger Key gesetzt.")
        return

    test_text = "das ist ein test text mit fehler und schlechte grammatik"
    print(f"\nEingabe: {test_text}")
    print("Warte auf API-Antwort...")

    result = improve_text(test_text, "standard")
    print(f"\nErgebnis:\n{result}")

    if result.startswith("Fehler"):
        print("\nTest: FEHLGESCHLAGEN")
    else:
        print("\nTest: OK")

if __name__ == "__main__":
    main()
