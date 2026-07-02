# Output-Pipeline

Stand: 2026-05-12

## Input
Quelle, Fall, Paragraf, Prüfungsaufgabe oder Notiz.

## Verarbeitung
1. Thema erkennen
2. IHK-Prüfungsrelevanz bestimmen
3. Rechtsanker prüfen (BetrVG / BGB / DSGVO / BBiG / AEVO)
4. Musterlösung nach 10er-Struktur erzeugen
5. Kurzfrage erstellen
6. Karteikarte erstellen
7. JSONL-Golden-Set-Datensatz erzeugen
8. In Smoke-Test aufnehmen
9. In RAG/Index-Vorbereitung markieren
10. Status aktualisieren (daily_log.md)

## Output-Artefakte
- Markdown-Modul (Musterlösung)
- JSONL-Datensatz (Golden Set)
- Smoke-Test-Frage
- Karteikarte (Frage / Antwort / Anker)
- Bot-kompatibler Prompt
- Eval-Frage

## Qualitätskontrolle
- Kein erfundener Paragraf
- Mindestens 3 KPIs bei Fallaufgaben
- Immer Entscheidung + Begründung
- Immer Umsetzung + Kontrolle
- Prüfungssicher und direkt formuliert
