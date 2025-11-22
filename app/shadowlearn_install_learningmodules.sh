#!/usr/bin/env bash
set -euo pipefail

SPRINT_DIR="$HOME/Dokumente/ShadowLearn/app/src/data/sprints"
mkdir -p "$SPRINT_DIR"

# -------------------------------------------------------------
#  AEVO — Februar 2026
# -------------------------------------------------------------
cat << 'EOC' > "$SPRINT_DIR/aevo_2026.json"
{
  "id": "aevo-2026-sprint",
  "title": "AEVO Sprint – Februar 2026",
  "examDate": "2026-02-15",
  "durationDays": 14,
  "modules": [
    { "day": 1, "topic": "BBiG Grundlagen", "goal": "Rechtsrahmen verstehen" },
    { "day": 2, "topic": "Ausbildungsordnung", "goal": "Struktur & Inhalte" },
    { "day": 3, "topic": "JArbSchG", "goal": "Jugendschutz sicher beherrschen" },
    { "day": 4, "topic": "Ausbildung planen", "goal": "Lernziele definieren" },
    { "day": 5, "topic": "Unterweisung – 4 Stufen", "goal": "Musterdurchführung" },
    { "day": 6, "topic": "Kommunikation", "goal": "Feedback & Gespäche" },
    { "day": 7, "topic": "Motivation", "goal": "Azubi führen" },
    { "day": 8, "topic": "Beurteilungsmethoden", "goal": "Instrumente sicher anwenden" },
    { "day": 9, "topic": "Konflikte", "goal": "Konfliktformen & Lösungen" },
    { "day": 10, "topic": "Praktische Unterweisung", "goal": "AEVO-Plan erstellen" },
    { "day": 11, "topic": "AEVO Fallbeispiele", "goal": "IHK-Niveau trainieren" },
    { "day": 12, "topic": "Rechtsfragen", "goal": "AEVO-Klausur-Style" },
    { "day": 13, "topic": "Prüfungssimulation Teil 1", "goal": "Generalprobe" },
    { "day": 14, "topic": "Prüfungssimulation Teil 2", "goal": "100% Sicherheit" }
  ]
}
EOC

# -------------------------------------------------------------
# Führung & Personal – April 2026
# -------------------------------------------------------------
cat << 'EOC' > "$SPRINT_DIR/fuehrung_april_2026.json"
{
  "id": "fuehrung-2026-sprint",
  "title": "Führung & Personal Sprint – April 2026",
  "examDate": "2026-04-08",
  "durationDays": 14,
  "modules": [
    { "day": 1, "topic": "Führungsmodelle", "goal": "Situative Führung anwenden" },
    { "day": 2, "topic": "Motivation", "goal": "Theorien + Praxis" },
    { "day": 3, "topic": "Kommunikation", "goal": "IHK-Gesprächsführung" },
    { "day": 4, "topic": "Konfliktmanagement", "goal": "Strategien vergleichen" },
    { "day": 5, "topic": "Arbeitsrecht Basics", "goal": "Kündigung, Abmahnung" },
    { "day": 6, "topic": "Personalplanung", "goal": "Bedarf, Einsatz, Kosten" },
    { "day": 7, "topic": "Personalentwicklung", "goal": "Instrumente & Systeme" },
    { "day": 8, "topic": "Beurteilung", "goal": "Methoden + Beispiele" },
    { "day": 9, "topic": "Gesprächsarten", "goal": "Kritik, Zielvereinbarung" },
    { "day": 10, "topic": "Situationsaufgaben", "goal": "SA1/SA2 Training" },
    { "day": 11, "topic": "Transferaufgaben", "goal": "50 Prüfungsfragen" },
    { "day": 12, "topic": "Fallstudien", "goal": "Komplexe Fälle lösen" },
    { "day": 13, "topic": "Generalprobe SA1", "goal": "Schriftlich wie IHK" },
    { "day": 14, "topic": "Generalprobe SA2", "goal": "Maximalpunkte" }
  ]
}
EOC

# -------------------------------------------------------------
# ITFA – November 2026
# -------------------------------------------------------------
cat << 'EOC' > "$SPRINT_DIR/itfa_nov_2026.json"
{
  "id": "itfa-2026-sprint",
  "title": "IT-Fachaufgaben Sprint – November 2026",
  "examDate": "2026-11-09",
  "durationDays": 30,
  "modules": [
    { "day": 1, "topic": "Analyse Grundlagen", "goal": "Projektkontext verstehen" },
    { "day": 2, "topic": "Stakeholder", "goal": "Analyse + Machtmatrix" },
    { "day": 3, "topic": "Risikoanalyse", "goal": "Risikomatrix ITFA" },
    { "day": 4, "topic": "Wirtschaftlichkeit", "goal": "Kosten, Nutzen, ROI" },
    { "day": 5, "topic": "IT-Security", "goal": "CIA, Zero Trust" },
    { "day": 6, "topic": "Netzwerk", "goal": "Topologien & Sicherheit" },
    { "day": 7, "topic": "Serversysteme", "goal": "Windows + Linux" },
    { "day": 8, "topic": "Cloud", "goal": "AWS / Azure Basics" },
    { "day": 9, "topic": "Konzeption", "goal": "ITFA2 Schriftteil" },
    { "day": 10, "topic": "Architektur", "goal": "Diagramme, UML" },
    { "day": 11, "topic": "Präsentation Teil 1", "goal": "Struktur" },
    { "day": 12, "topic": "Präsentation Teil 2", "goal": "Storytelling" },
    { "day": 13, "topic": "Fachgespräch", "goal": "Fragenkatalog" },
    { "day": 14, "topic": "Simulation ITFA1", "goal": "Klausurmodus" },
    { "day": 15, "topic": "Simulation ITFA2", "goal": "Konzeptprofi" },
    { "day": 16, "topic": "Simulation ITFA3", "goal": "Fachgespräch" }
  ]
}
EOC

# -------------------------------------------------------------
# Registry
# -------------------------------------------------------------
cat << 'EOC' > "$SPRINT_DIR/index.ts"
export { default as AEVO2026 } from "./aevo_2026.json";
export { default as FUEHRUNG2026 } from "./fuehrung_april_2026.json";
export { default as ITFA2026 } from "./itfa_nov_2026.json";
EOC

echo "[✓] Lernmodule für AEVO, Führung & ITFA installiert."
