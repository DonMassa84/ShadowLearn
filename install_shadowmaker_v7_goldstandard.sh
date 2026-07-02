#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Schreibtisch/shadowmaker_v7_km"
OUT="$BASE/output"
MODELS="$BASE/models"

mkdir -p "$OUT" "$MODELS"

GOLD_JSON="$OUT/shadowmaker_v7_goldstandard.json"
GOLD_JSONL="$OUT/shadowmaker_v7_goldstandard.jsonl"
TRAINING_READY="$OUT/shadowmaker_v7_training_ready.jsonl"
MODELFILE="$MODELS/Modelfile.shadowmaker-v7-ihk"

cat > "$GOLD_JSON" <<'JSONEOF'
[
  {
    "instruction": "Wende das IHK-10-Punkte-Gerüst auf ein Szenario mit Projektverzug und Mitarbeiterkonflikten an.",
    "input": "Szenario: Das Projekt 'Apollo' bei TechSolution ist 4 Wochen im Verzug. Die Fehlerquote ist gestiegen. Der Betriebsrat blockiert Überstunden.",
    "response": "1. Situation: Projektverzug (4 Wochen), steigende Fehlerquote, Ressourcenengpass durch BR-Veto.\n2. Ziel (SMART): Wiederherstellung der Termintreue (SPI >= 1,0) und Fehlersenkung um 30% innerhalb von 8 Wochen.\n3. Stakeholder: Geschäftsleitung (Einfluss hoch), Projektteam (Motivation niedrig), Betriebsrat (Mitbestimmung §87 BetrVG).\n4. Ursachenanalyse (M/O/P): Mensch (Überlastung, Qualifikationslücken), Organisation (fehlende Priorisierung), Prozess (defizitäre Kommunikation, fehlendes Controlling).\n5. Handlungsalternativen: A) Coaching & Teambuilding, B) RACI-Matrix & Prozessoptimierung, C) Externes Outsourcing.\n6. Bewertung (W/O/M): B ist kosteneffizient (W), schafft Struktur (O), A steigert Motivation (M).\n7. Entscheidung: Kombination aus A und B für nachhaltige Stabilisierung.\n8. Umsetzung: Woche 1: Ist-Analyse; Woche 2-4: Rollenklärung (RACI) & Coaching; Woche 5: Review.\n9. Kontrolle (KPIs): Messung von SPI, CPI, Fehlerquote und Teamzufriedenheit.\n10. Nachhaltigkeit/Recht: Dokumentation der 'Lessons Learned', Einhaltung §87 Abs. 1 Nr. 2/3 BetrVG (Arbeitszeit).",
    "source": "GMT20250808-142442_Recording.txt",
    "lecturer": "Jehlitschke, Oliver"
  },
  {
    "instruction": "Erläutere die Bedeutung und Berechnung der Risikoprioritätszahl (RPZ) in einer FMEA.",
    "response": "Die FMEA (Fehler-Möglichkeits- und Einflussanalyse) dient der präventiven Fehlervermeidung. Die Risikoprioritätszahl (RPZ) wird berechnet als Produkt aus: Bedeutung des Fehlers (B) x Auftreten (A) x Entdeckungswahrscheinlichkeit (E). Der Maximalwert liegt bei 1000. Ein Wert von 10 bei Bedeutung signalisiert 'High Alert' (absoluter Alarm). Ziel von Präventivmaßnahmen (z.B. Poka-Yoke) ist die Senkung der RPZ durch Verringerung von Auftreten und Entdeckung, während die Bedeutung oft fix bleibt.",
    "source": "GMT20250805-153754_Recording.m4a",
    "lecturer": "Jehlitschke, Oliver"
  },
  {
    "instruction": "Beschreibe die Prinzipien des Harvard-Konzepts im Konfliktmanagement.",
    "response": "Das Harvard-Konzept zielt auf eine Win-Win-Lösung ab und basiert auf vier Prinzipien: 1. Menschen und Probleme getrennt behandeln. 2. Interessen in den Fokus rücken, nicht starre Positionen. 3. Vielfältige Entscheidungsoptionen (Wahlmöglichkeiten) für gegenseitigen Vorteil entwickeln. 4. Objektive Kriterien (z.B. Gesetze, Standards) als Bewertungsmaßstab heranziehen.",
    "source": "016_2025-03-01_Schmidt_Ursula_Mitarbeiterführung.txt",
    "lecturer": "Schmidt, Ursula"
  },
  {
    "instruction": "Nenne die 4 Stufen der Evaluation nach Kirkpatrick für Personalentwicklungsmaßnahmen.",
    "response": "1. Reaktion (Reaction): Zufriedenheit der Teilnehmer (Feedbackbögen). 2. Lernen (Learning): Wissenszuwachs (Tests, Quiz). 3. Verhalten (Behavior): Transfer des Wissens an den Arbeitsplatz (Beobachtung) – dies ist die kritischste Stufe für den IHK-Erfolg. 4. Ergebnisse (Results): Ökonomischer Nutzen für das Unternehmen (ROI, Fehlerreduktion).",
    "source": "2025-01-25 Frau Wellinger.txt",
    "lecturer": "Wellinger, Alexandra"
  },
  {
    "instruction": "Welche Mitbestimmungsrechte hat der Betriebsrat bei der Einführung von IT-Systemen?",
    "response": "Gemäß § 87 Abs. 1 Nr. 6 BetrVG hat der Betriebsrat ein zwingendes Mitbestimmungsrecht bei der Einführung und Anwendung von technischen Einrichtungen, die dazu geeignet sind, das Verhalten oder die Leistung der Arbeitnehmer zu überwachen. Dies gilt insbesondere für Ticketsysteme, Monitoring-Software und digitale Personalakten. Zudem ist bei personellen Einzelmaßnahmen wie Versetzungen in das Projektteam § 99 BetrVG zu beachten.",
    "source": "2025_07_25_Projektmanagement_Jehlitschke.txt",
    "lecturer": "Jehlitschke, Oliver; Specht, Heike"
  },
  {
    "instruction": "Definiere den Unterschied zwischen Lastenheft und Pflichtenheft.",
    "response": "Das Lastenheft wird vom Auftraggeber erstellt und beschreibt das 'Was' (Gesamtheit der Anforderungen und das Zielbild). Es dient als Ausschreibungs- und Vertragsgrundlage. Das Pflichtenheft wird vom Auftragnehmer als Antwort auf das Lastenheft erstellt und beschreibt das 'Wie' (detaillierte technische Umsetzung). Es ist die verbindliche Basis für die Projektabnahme.",
    "source": "023_2025-06-07_Jehlitschke_Oliver_Projektmanagement.txt",
    "lecturer": "Jehlitschke, Oliver"
  },
  {
    "instruction": "Erläutere die Phasen des Sarah-Modells im Veränderungsmanagement.",
    "response": "Das Sarah-Modell beschreibt die emotionalen Phasen bei Veränderungen: 1. Schock (Shock). 2. Wut (Anger). 3. Widerstand (Resistance). 4. Akzeptanz (Acceptance). Erst nach Erreichen der Akzeptanzphase kann konstruktiv an der Neugestaltung gearbeitet werden. Führungskräfte müssen Emotionen in den frühen Phasen aushalten und Raum für Reflexion bieten.",
    "source": "2025-01-11 Frau Schmidt.txt",
    "lecturer": "Schmidt, Ursula"
  },
  {
    "instruction": "Was versteht man unter transformationaler Führung?",
    "response": "Transformationale Führung bedeutet, Mitarbeiter durch Visionen zu inspirieren und als persönliches Vorbild (Role Model) zu fungieren. Die Führungskraft wirkt als 'Transformator', der die Werte und Motive der Geführten hin zu höheren Zielen verändert. Dies setzt eine hohe Reife der Mitarbeiter (Motivation und Qualifikation) voraus.",
    "source": "2024_12_07_Mitarbeiter_Teamführung_Schmidt.txt",
    "lecturer": "Schmidt, Ursula"
  },
  {
    "instruction": "Beschreibe die 4-Stufen-Methode der Unterweisung nach AEVO.",
    "response": "Die 4-Stufen-Methode eignet sich besonders für psychomotorische Lernziele (praktische Tätigkeiten): Stufe 1: Vorbereitung (Interesse wecken, Vorwissen prüfen). Stufe 2: Vormachen und Erklären durch den Ausbilder. Stufe 3: Nachmachen und Erklären durch den Auszubildenden (Lernkontrolle). Stufe 4: Selbstständiges Üben und Festigen.",
    "source": "AEVO-UNTERWEISUNG – SPRECHSKRIPT (15:00 Minuten).pdf",
    "lecturer": "Massa, Daniel"
  },
  {
    "instruction": "Erläutere die Kennzahlen SPI und CPI im Projektcontrolling.",
    "response": "Im Projektcontrolling sind SPI (Schedule Performance Index) und CPI (Cost Performance Index) zentrale Werte der Earned Value Analyse. Ein Wert < 1 signalisiert kritische Abweichungen: SPI < 1 bedeutet Zeitverzug (langsamer als geplant); CPI < 1 bedeutet Budgetüberschreitung (teurer als geplant). Bei Abweichungen ist eine Ursachenanalyse nach M/O/P zwingend.",
    "source": "2025-07-25_Allgemeines-Projektmanagement_Jehlitschke-Oliver.txt",
    "lecturer": "Jehlitschke, Oliver"
  }
]
JSONEOF

python3 -m json.tool "$GOLD_JSON" > /tmp/shadowmaker_v7_goldstandard_validated.json

python3 - <<PYEOF
import json
from pathlib import Path

src = Path("$GOLD_JSON")
dst = Path("$GOLD_JSONL")
training = Path("$TRAINING_READY")

data = json.loads(src.read_text(encoding="utf-8"))

with dst.open("w", encoding="utf-8") as f:
    for item in data:
        f.write(json.dumps(item, ensure_ascii=False) + "\\n")

with training.open("w", encoding="utf-8") as f:
    for item in data:
        f.write(json.dumps(item, ensure_ascii=False) + "\\n")

print(f"OK JSON: {src}")
print(f"OK JSONL: {dst}")
print(f"OK TRAINING_READY: {training}")
print(f"Datensätze: {len(data)}")
PYEOF

BASE_MODEL="${BASE_MODEL:-shadowmaker-v5:latest}"

cat > "$MODELFILE" <<MODELEOF
FROM $BASE_MODEL

PARAMETER temperature 0.25
PARAMETER top_p 0.85
PARAMETER num_ctx 8192
PARAMETER repeat_penalty 1.12

SYSTEM """
Du bist ShadowMaker-v7 im IHK-MFP-Prüfungsmodus.

Ziel:
Maximiere prüfungsfähige Antworten für Mitarbeiterführung, Personalmanagement, Projektmanagement, Arbeitsrecht und AEVO.

Pflichtstruktur bei Situationsaufgaben:
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

Prüfungsanker:
- §87 Abs. 1 Nr. 6 BetrVG bei IT-Systemen und Überwachungseignung
- §87 Abs. 1 Nr. 2/3 BetrVG bei Arbeitszeit und Überstunden
- §99 BetrVG bei Einstellung, Eingruppierung, Umgruppierung und Versetzung
- Lastenheft = Was / Auftraggeber
- Pflichtenheft = Wie / Auftragnehmer
- SPI < 1 = Zeitverzug
- CPI < 1 = Budgetüberschreitung
- FMEA: RPZ = Bedeutung x Auftreten x Entdeckung
- Kirkpatrick: Reaktion, Lernen, Verhalten, Ergebnisse
- Harvard-Konzept: Menschen/Problem trennen, Interessen statt Positionen, Optionen entwickeln, objektive Kriterien nutzen
- 4-Stufen-Methode AEVO: Vorbereiten, Vormachen/Erklären, Nachmachen/Erklären, Üben/Festigen
- Sarah-Modell: Shock, Anger, Resistance, Acceptance

Antwortstil:
Direkt, prüfungsnah, strukturiert.
Keine Floskeln.
Keine erfundenen Paragrafen.
Keine unsicheren Urteile als Fakten ausgeben.
Wenn Recht relevant ist, Rechtsrisiko knapp benennen.
"""
MODELEOF

echo ""
echo "─────────────────────────────────────────"
echo "Goldstandard installiert."
echo "JSON:           $GOLD_JSON"
echo "JSONL:          $GOLD_JSONL"
echo "Training ready: $TRAINING_READY"
echo "Modelfile:      $MODELFILE"
echo "Base model:     $BASE_MODEL"
echo "─────────────────────────────────────────"
echo ""
echo "Optional Modell erstellen:"
echo "ollama create shadowmaker-v7-ihk:latest -f $MODELFILE"
echo ""
echo "Smoke-Test:"
echo "ollama run shadowmaker-v7-ihk:latest 'Was regelt §87 Abs. 1 Nr. 6 BetrVG bei KI-Systemen?'"
