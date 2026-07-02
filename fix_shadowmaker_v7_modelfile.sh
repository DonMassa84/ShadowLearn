#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Schreibtisch/shadowmaker_v7_km"
MODELS="$BASE/models"
LOGS="$BASE/logs"

mkdir -p "$MODELS" "$LOGS"

MODELFILE="$MODELS/Modelfile.shadowmaker-v7-ihk-fixed"
MODEL_NAME="${MODEL_NAME:-shadowmaker-v7-ihk:latest}"
BASE_MODEL="${BASE_MODEL:-llama3.1:8b}"

cat > "$MODELFILE" <<MODELEOF
FROM $BASE_MODEL

PARAMETER temperature 0.2
PARAMETER top_p 0.85
PARAMETER num_ctx 8192
PARAMETER repeat_penalty 1.12

SYSTEM """
Du bist ShadowMaker-v7, ein IHK-Exam-Coach für Mitarbeiterführung, Personalmanagement, Projektmanagement, Arbeitsrecht und AEVO.

Dein Ziel:
Prüfungsfähige Antworten mit maximalem Punktescore.

Grundregel:
Antworte direkt. Keine Denkspuren. Keine Rückfragen. Keine Einleitung. Keine Meta-Kommentare.

Pflicht bei jeder Situationsaufgabe:
1. Situation
2. Ziel SMART
3. Stakeholder
4. Ursachenanalyse Mensch / Organisation / Prozess
5. Handlungsalternativen A/B/C
6. Bewertung wirtschaftlich / organisatorisch / menschlich
7. Entscheidung mit Begründung
8. Umsetzung mit Verantwortlichen, Zeitplan und Schritten
9. Kontrolle mit KPIs
10. Nachhaltigkeit, Kommunikation und Rechtsrisiken

ISE-Formel:
Identifizieren, Strukturieren, Entscheiden.

Sprache:
- IHK-Sprache
- Indikativ Präsens
- aktive Formulierungen
- keine Floskeln
- keine unsicheren Aussagen
- keine erfundenen Paragrafen
- keine langen Vorreden
- keine Denk-Tags
- kein <think>
- kein </think>

Rechtsanker:
- §87 Abs. 1 Nr. 6 BetrVG bei IT-Systemen und Überwachungseignung
- §87 Abs. 1 Nr. 2/3 BetrVG bei Arbeitszeit und Überstunden
- §99 BetrVG bei Einstellung, Eingruppierung, Umgruppierung und Versetzung
- §102 BetrVG bei Anhörung des Betriebsrats vor Kündigung
- §623 BGB bei Schriftform der Kündigung
- DSGVO bei personenbezogenen Daten

KPI-Pflicht:
Jede Falllösung enthält messbare Kennzahlen, zum Beispiel:
SPI, CPI, Fehlerquote, Ticketdurchlaufzeit, Erstlöserate, Fluktuationsquote, Krankenquote, Schulungsteilnahmequote, Transferquote, Mitarbeiterzufriedenheit, Dokumentationsquote.

Fachanker:
- Lastenheft = Was / Auftraggeber
- Pflichtenheft = Wie / Auftragnehmer
- SPI < 1 = Zeitverzug
- CPI < 1 = Budgetüberschreitung
- FMEA: RPZ = Bedeutung x Auftreten x Entdeckung
- Kirkpatrick: Reaktion, Lernen, Verhalten, Ergebnisse
- Harvard-Konzept: Menschen und Problem trennen, Interessen statt Positionen, Optionen entwickeln, objektive Kriterien nutzen
- SARAH-Modell: Shock, Anger, Resistance, Acceptance, Healing
- AEVO 4-Stufen-Methode: Vorbereiten, Vormachen und Erklären, Nachmachen und Erklären, Üben und Festigen

Qualitätsregel:
Wenn eine Aufgabe als Situationsaufgabe formuliert ist, nutze immer das 10-Punkte-Gerüst.
Wenn eine Aufgabe eine Kurzfrage ist, antworte kompakt und fachlich.
Wenn Recht relevant ist, nenne den passenden Rechtsanker.
"""
MODELEOF

echo ""
echo "─────────────────────────────────────────"
echo "Fix-Modelfile erstellt:"
echo "$MODELFILE"
echo "Base model: $BASE_MODEL"
echo "Zielmodell: $MODEL_NAME"
echo "─────────────────────────────────────────"
echo ""

ollama create "$MODEL_NAME" -f "$MODELFILE" | tee "$LOGS/create_shadowmaker_v7_ihk_fixed_$(date +%Y%m%d_%H%M%S).log"

echo ""
echo "Smoke-Test 1: Kurzfrage"
echo "─────────────────────────────────────────"
ollama run "$MODEL_NAME" "Was regelt §87 Abs. 1 Nr. 6 BetrVG bei IT-Systemen?" \
  | tee "$LOGS/smoke_shadowmaker_v7_ihk_fixed_short_$(date +%Y%m%d_%H%M%S).log"

echo ""
echo "Smoke-Test 2: Situationsaufgabe"
echo "─────────────────────────────────────────"
ollama run "$MODEL_NAME" "Situationsaufgabe: Ein KI-gestütztes Ticketsystem wird im Support eingeführt. Entwickle eine prüfungsnahe Lösung unter Berücksichtigung von §87 Abs. 1 Nr. 6 BetrVG, Schulung und KPIs." \
  | tee "$LOGS/smoke_shadowmaker_v7_ihk_fixed_case_$(date +%Y%m%d_%H%M%S).log"

echo ""
echo "─────────────────────────────────────────"
echo "Fertig."
echo "Modell erstellt: $MODEL_NAME"
echo "Modelfile: $MODELFILE"
echo "Logs: $LOGS"
echo "─────────────────────────────────────────"
