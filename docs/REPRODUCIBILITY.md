# Reproduzierbarkeit

## Ziel

Ein Dritter soll das Repository klonen, prüfen, starten und bewerten können, ohne implizites lokales Wissen zu benötigen.

## Mindeststandard

~~~bash
git clone <repo-url>
cd <repo>
make doctor
make setup
make test
make run
~~~

## Regeln

1. Keine absoluten lokalen Pfade im Code.
2. Keine Secrets im Git-Verlauf.
3. Jede benötigte Variable steht in .env.example.
4. Start-, Test- und Diagnosebefehle sind über Makefile erreichbar.
5. Projektentscheidungen werden als ADR dokumentiert.
6. Releases laufen über make release-check.
