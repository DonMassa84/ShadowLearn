# Security

## Schutzziele

- Keine Secrets im Repository
- Keine personenbezogenen Rohdaten in öffentlichen Artefakten
- Keine lokalen Pfade in Portfolio-Ausgaben
- Reproduzierbare, prüfbare Änderungen

## Secret-Regeln

Nie committen:

- .env
- API Keys
- Tokens
- Private Keys
- Passwörter
- Datenbank-Dumps
- Roharchive mit personenbezogenen Daten

Erlaubt:

- .env.example
- sanitizte Beispieldaten
- Dokumentierte Platzhalter

## Human Review

Vor Push/Release:

~~~bash
make security
make release-check
git diff --stat
git diff
~~~

## Reaktion bei Leak

1. Commit stoppen.
2. Secret sofort rotieren.
3. Datei aus Git entfernen.
4. Verlauf nur bei echtem Leak bereinigen.
5. Release erst nach neuem Security-Scan.
