#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Schreibtisch/shadowmaker_v7_km"
SRC="$BASE/sources"
OUT="$BASE/output"
LOG="$BASE/logs"
SCRIPT="$BASE/scripts"

mkdir -p "$SRC" "$OUT" "$LOG" "$SCRIPT"

echo ""
echo " ShadowMaker-v7 Knowledge Management — Start"
echo " ─────────────────────────────────────────────"
echo " Base: $BASE"
echo " Sources: $SRC"
echo " Output: $OUT"
echo ""

# Globale Env laden
set -a
[ -f /etc/environment ] && source /etc/environment || true
[ -f "$HOME/.profile" ] && source "$HOME/.profile" || true
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" || true
set +a

PPLX_CANDIDATE="${PPLX_API_KEY:-}"
PERPLEXITY_CANDIDATE="${PERPLEXITY_API_KEY:-}"

if [ "$PPLX_CANDIDATE" = "dein_key" ] || [ "$PPLX_CANDIDATE" = "DEIN_KEY" ] || [ "$PPLX_CANDIDATE" = "dein_perplexity_api_key" ]; then
  PPLX_CANDIDATE=""
fi

API_KEY="${PPLX_CANDIDATE:-$PERPLEXITY_CANDIDATE}"

if [ -z "$API_KEY" ]; then
  echo "FEHLER: Kein gültiger Perplexity API-Key gefunden."
  echo "Erwartet: PERPLEXITY_API_KEY oder PPLX_API_KEY in globaler Env."
  exit 1
fi

echo " Perplexity-Key: geladen"
echo ""

# JSON-Goldset erzeugen
cat > "$OUT/shadowmaker_v7_goldset_sources.json" <<'JSONEOF'
[
  {
    "instruction": "Wende das IHK-10-Punkte-Gerüst auf eine Krisensituation im IT-Projekt an.",
    "input": "Szenario: Das Projekt 'Zentrales IT-Serviceportal' ist 4 Wochen im Verzug. Die Fehlerquote ist gestiegen. Der Betriebsrat blockiert Überstunden.",
    "response": "1. Situation: Projektverzug (4 Wochen), steigende Fehlerquote, Ressourcenengpass durch BR-Veto.\n2. Ziel (SMART): Wiederherstellung der Termintreue (SPI >= 1,0) und Fehlersenkung um 30% innerhalb von 8 Wochen.\n3. Stakeholder: Geschäftsleitung, IT-Team, Betriebsrat, Projektleitung.\n4. Ursachenanalyse (M/O/P): Mensch: Überlastung und Qualifikationslücken. Organisation: Fehlende Priorisierung. Prozess: Defizitäre Kommunikation und fehlendes Controlling.\n5. Alternativen: A Status quo, B Outsourcing, C Hybrid-Lösung aus Prozessoptimierung und Schulung.\n6. Bewertung: C ist wirtschaftlich skalierbar, organisatorisch stabil und menschlich tragfähig.\n7. Entscheidung: Kombination aus Prozessoptimierung und Qualifizierung.\n8. Umsetzung: Ist-Analyse, RACI-Matrix, Pilotbetrieb, Schulung, Review.\n9. Kontrolle: SPI, CPI, Fehlerquote, Ticketdurchlaufzeit.\n10. Nachhaltigkeit/Recht: Lessons Learned, Wiki, Beteiligung des Betriebsrats nach §87 BetrVG.",
    "source": "023_2025-06-07_Jehlitschke_Oliver_Projektmanagement.txt; 028_2025-07-25_Jehlitschke_Oliver_Projektmanagement.txt",
    "metadata": {
      "lecturer": "Jehlitschke, Oliver",
      "topic": "Projektsteuerung & Controlling"
    }
  },
  {
    "instruction": "Erläutere die Bedeutung von Kennzahlen im IT-Projektcontrolling.",
    "input": "SA2-Kontext: Projektcontrolling bei IT-Infrastruktur- oder API-Projekten.",
    "response": "Ich steuere das Projekt über das Magische Dreieck aus Zeit, Kosten und Qualität. Zentrale KPIs sind der SPI zur Termintreue, der CPI zur Kosteneffizienz und die Meilenstein-Trendanalyse zur Terminprognose. Ein SPI kleiner 1 zeigt Zeitverzug, ein CPI kleiner 1 zeigt Budgetüberschreitung. Ergänzend werden Fehlerquote, Ticketdurchlaufzeit und Erstlöserate betrachtet.",
    "source": "2025-07-25_Allgemeines_Projektmanagement.txt; 028_2025-07-25_Jehlitschke_Oliver_Projektmanagement.txt",
    "metadata": {
      "lecturer": "Jehlitschke, Oliver",
      "topic": "Kennzahlen & MTA"
    }
  },
  {
    "instruction": "Welche Mitbestimmungsrechte hat der Betriebsrat bei IT-Systemen?",
    "input": "Ein neues KI-gestütztes Wissensportal oder Ticketsystem soll eingeführt werden.",
    "response": "Gemäß §87 Abs. 1 Nr. 6 BetrVG hat der Betriebsrat ein zwingendes Mitbestimmungsrecht bei technischen Einrichtungen, die geeignet sind, Verhalten oder Leistung von Beschäftigten zu überwachen. Entscheidend ist die objektive Eignung zur Überwachung, nicht die Absicht des Arbeitgebers. Bei personellen Einzelmaßnahmen wie Einstellung, Eingruppierung, Umgruppierung oder Versetzung ist zusätzlich §99 BetrVG zu beachten.",
    "source": "014_2025-02-21_Specht_Heike_Arbeitsrecht.txt; 010_2025-02-07_Schmidt_Ursula_Mitarbeiterführung.txt",
    "metadata": {
      "lecturer": "Specht, Heike; Schmidt, Ursula",
      "topic": "Arbeitsrecht & Mitbestimmung"
    }
  },
  {
    "instruction": "Definiere den Unterschied zwischen Lastenheft und Pflichtenheft.",
    "input": "Anforderungsmanagement in einem IT-Projekt.",
    "response": "Das Lastenheft wird vom Auftraggeber erstellt und beschreibt das Was, also Anforderungen, Ziele und Rahmenbedingungen. Das Pflichtenheft wird vom Auftragnehmer erstellt und beschreibt das Wie, also die konkrete technische und organisatorische Umsetzung. Das Pflichtenheft bildet häufig die Grundlage für Umsetzung, Kontrolle und spätere Abnahme.",
    "source": "023_2025-06-07_Jehlitschke_Oliver_Projektmanagement.txt; 2025-06-07_Jehlitschke_HD.txt",
    "metadata": {
      "lecturer": "Jehlitschke, Oliver",
      "topic": "Anforderungsmanagement"
    }
  },
  {
    "instruction": "Beschreibe den Prozess einer fairen Mitarbeiterbeurteilung.",
    "input": "Führungskraft bereitet ein Beurteilungsgespräch vor.",
    "response": "Eine faire Mitarbeiterbeurteilung folgt der Kette Beobachten, Beschreiben, Bewerten und Gespräch führen. Die Beurteilung muss auf konkreten Beobachtungen beruhen und typische Beurteilungsfehler wie Halo-Effekt, Nikolaus-Effekt oder Benjamin-Effekt vermeiden. Die Selbstbeurteilung des Mitarbeiters sollte vor der Fremdbeurteilung durch die Führungskraft erfolgen, um Akzeptanz, Reflexion und Wertschätzung zu fördern.",
    "source": "010_2025-02-07_Schmidt_Ursula_Mitarbeiterführung.txt; 2025-01-11 Frau Schmidt.txt",
    "metadata": {
      "lecturer": "Schmidt, Ursula",
      "topic": "Personalbeurteilung"
    }
  },
  {
    "instruction": "Nenne die vier Stufen der Evaluation nach Kirkpatrick für Personalentwicklungsmaßnahmen.",
    "input": "Eine Schulung zur Nutzung eines KI-Wissensportals soll bewertet werden.",
    "response": "Die vier Stufen nach Kirkpatrick sind Reaktion, Lernen, Verhalten und Ergebnisse. Reaktion misst die Zufriedenheit der Teilnehmer. Lernen misst den Wissenszuwachs. Verhalten misst den Transfer an den Arbeitsplatz und ist besonders wichtig für den Praxiserfolg. Ergebnisse messen den organisatorischen oder wirtschaftlichen Nutzen, zum Beispiel Fehlerreduktion, Produktivität oder ROI.",
    "source": "2025_02_22_Mitarbeiterqualifizierung_Wellinger.txt; 015_2025-02-22_Wellinger_Alexandra_Mitarbeiterqualifizierung.txt",
    "metadata": {
      "lecturer": "Wellinger, Alexandra",
      "topic": "Evaluation & Transfer"
    }
  },
  {
    "instruction": "Wende das Harvard-Konzept im Konfliktmanagement an.",
    "input": "Konflikt zwischen IT-Team und Betriebsrat bei Einführung eines neuen KI-Systems.",
    "response": "Das Harvard-Konzept folgt vier Prinzipien. Erstens werden Menschen und Probleme getrennt behandelt. Zweitens werden Interessen statt Positionen betrachtet. Drittens werden Entscheidungsoptionen mit gegenseitigem Nutzen entwickelt. Viertens werden objektive Kriterien wie Gesetze, Betriebsvereinbarungen oder Datenschutzstandards herangezogen. Ziel ist eine sachliche, faire und tragfähige Lösung.",
    "source": "019_2025-03-15_Schmidt_Ursula_Mitarbeiterführung.txt; 2024_11_30_Mitarbeiter_Teamführung_Schmidt.txt",
    "metadata": {
      "lecturer": "Schmidt, Ursula",
      "topic": "Konfliktlösung"
    }
  },
  {
    "instruction": "Wie wird eine Risikoanalyse mittels FMEA durchgeführt?",
    "input": "Risikoanalyse für den Rollout eines KI-Wissensportals.",
    "response": "Bei der FMEA werden mögliche Fehler identifiziert und mit der Risikoprioritätszahl bewertet. Die RPZ berechnet sich aus Bedeutung mal Auftreten mal Entdeckung. Ziel ist es, hohe Risiken früh zu erkennen und durch Präventivmaßnahmen zu senken, zum Beispiel Pilotbetrieb, Testumgebung, Vier-Augen-Prinzip oder Fallback-Konzept.",
    "source": "2025-07-25_Allgemeines-Projektmanagement_Jehlitschke-Oliver.txt; GMT20250805-153754_Recording.m4a",
    "metadata": {
      "lecturer": "Jehlitschke, Oliver",
      "topic": "Risikomanagement & FMEA"
    }
  },
  {
    "instruction": "Entwickle ein Konzept zur Wissenssicherung und Neubesetzung bei Kündigung eines High-Performers.",
    "input": "Ein High-Performer kündigt während der Realisierungsphase eines API-Projekts. Er ist Hauptwissensträger. Eine interne Versetzung oder Neueinstellung ist geplant.",
    "response": "1. Situation: Im laufenden API-Projekt fällt ein zentraler Wissensträger aus. Dadurch entstehen Risiken für Termin, Qualität und Know-how-Sicherung.\n2. Ziel SMART: Innerhalb von zwei Wochen wird kritisches Wissen dokumentiert und an mindestens zwei Teammitglieder übertragen. Innerhalb von vier Wochen wird eine Vertretung oder Nachbesetzung organisiert.\n3. Stakeholder: Projektleitung, IT-Team, kündigender Mitarbeiter, HR, Geschäftsführung, Fachbereich und Betriebsrat.\n4. Ursachen: Mensch: Einzelwissen und Single Point of Failure. Organisation: Fehlende Vertretungsregelung. Prozess: Kein systematischer Knowledge Transfer.\n5. Alternativen: A externe Nachbesetzung, B interne Versetzung, C hybride Lösung aus Wissenssicherung und gezielter Nachbesetzung.\n6. Bewertung: C ist wirtschaftlich sinnvoll, organisatorisch stabil und menschlich tragfähig.\n7. Entscheidung: C wird gewählt, weil Wissen gesichert und Abhängigkeit reduziert wird.\n8. Umsetzung: Wissenslandkarte, Pairing, Übergabeprotokoll, Wiki-Dokumentation, RACI-Matrix, Einarbeitungsplan und HR-Abstimmung.\n9. Kontrolle: Dokumentationsquote, offene Tickets, Fehlerquote, Einarbeitungsdauer, Projektverzug.\n10. Nachhaltigkeit/Recht: Dokumentationspflicht, Vertretungsregelung, Lessons Learned. Bei Einstellung oder Versetzung ist §99 BetrVG zu beachten.",
    "source": "ShadowMaker-v7 Drill High-Performer; IHK-MFP-Betriebssystem",
    "metadata": {
      "lecturer": "Systemdrill",
      "topic": "Wissenssicherung, Neubesetzung & §99 BetrVG"
    }
  }
]
JSONEOF

echo " Goldset JSON erstellt."

# JSON validieren
python3 -m json.tool "$OUT/shadowmaker_v7_goldset_sources.json" > /tmp/shadowmaker_v7_goldset_validated.json
echo " JSON gültig."

# JSON zu JSONL
python3 - <<PYEOF
import json
from pathlib import Path

input_file = Path("$OUT/shadowmaker_v7_goldset_sources.json")
output_file = Path("$OUT/shadowmaker_v7_goldset_sources.jsonl")

with input_file.open("r", encoding="utf-8") as f:
    data = json.load(f)

with output_file.open("w", encoding="utf-8") as f:
    for item in data:
        f.write(json.dumps(item, ensure_ascii=False) + "\\n")

print(f" JSONL erstellt: {output_file}")
print(f" Datensätze: {len(data)}")
PYEOF

# Perplexity-Test mit echter IHK-Frage
QUESTION="Erstelle eine prüfungsnahe IHK-Antwort im 10-Punkte-Gerüst: Ein High-Performer kündigt während der Realisierungsphase eines API-Projekts. Entwickle ein Konzept zur Wissenssicherung und Neubesetzung unter Berücksichtigung von §99 BetrVG."

cat > /tmp/pplx_shadowmaker_payload.json <<PYEOF
{
  "model": "sonar",
  "messages": [
    {
      "role": "system",
      "content": "Du bist ein IHK-Prüfungsassistent für Mitarbeiterführung, Personalmanagement, Projektmanagement und Arbeitsrecht. Antworte prüfungsnah, direkt und strukturiert im 10-Punkte-Gerüst."
    },
    {
      "role": "user",
      "content": "$QUESTION"
    }
  ],
  "max_tokens": 1600,
  "stream": false
}
PYEOF

TS="$(date +%Y%m%d_%H%M%S)"
PPLX_JSON="$OUT/pplx_highperformer_$TS.json"
PPLX_TXT="$OUT/pplx_highperformer_$TS.txt"

echo ""
echo " Perplexity Live-Test läuft..."
echo ""

curl -sS \
  --request POST \
  --url "https://api.perplexity.ai/v1/sonar" \
  --header "Authorization: Bearer $API_KEY" \
  --header "Content-Type: application/json" \
  --data @/tmp/pplx_shadowmaker_payload.json \
  | tee "$PPLX_JSON" \
  | jq -r '.choices[0].message.content // .error.message // .' \
  | tee "$PPLX_TXT"

echo ""
echo " ─────────────────────────────────────────────"
echo " Fertig."
echo " JSON:  $OUT/shadowmaker_v7_goldset_sources.json"
echo " JSONL: $OUT/shadowmaker_v7_goldset_sources.jsonl"
echo " PPLX:  $PPLX_TXT"
echo " Log:   $LOG"
echo " ─────────────────────────────────────────────"
