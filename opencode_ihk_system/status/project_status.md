# opencode IHK System Status

Stand: 2026-05-12 15:xx
System: opencode + Tina-Huang-Adaption

---

## Erstellte Dateien

| Datei | Aufgabe |
|---|---|
| docs/tina_huang_adaption.md | Konzeptdatei (Aufgabe 3) |
| docs/output_pipeline.md | Output-Pipeline (Aufgabe 4) |
| docs/skill_stack.md | Skill-Stack (Aufgabe 6) |
| modules/ihk_10er_struktur.md | 10er-Struktur + Pflichtanker (Aufgabe 5) |
| workflows/weekly_output_plan.md | Wochenplan (Aufgabe 7) |
| prompts/daily_output_prompt.txt | Täglicher Prompt (Aufgabe 8) |
| status/daily_log.md | Learning Log (Aufgabe 9) |
| golden_sets/template.jsonl | Golden-Set Template 10 Einträge (Aufgabe 10) |
| smoke_tests/smoke_test_template.md | Smoke-Test Template (Aufgabe 11) |
| portfolio/README.md | Portfolio-Übersicht (Aufgabe 12) |
| status/project_status.md | Diese Datei (Aufgabe 13) |

---

## Bestandsaufnahme Schreibtisch (Aufgabe 1)

### IHK-Dateien
- ihk.md, ihk2.md, ihk_gold.jsonl
- data/rag/documents/goldset_ihk_gold.md + 12 weitere Goldset-Docs
- Zusammenfassungen/Mitarbeiterführung+Personalmanagement/ (PDFs, Audio)
- shadowmaker_v7_wissensmanagement_allinone.md

### RAG/Eval-Dateien
- data/rag/eval_rag_goldsets.jsonl (206 Einträge)
- eval_runs/e5/eval_goldsets_mistral7b.jsonl (107 Fragen, AVG 0.326)
- runs/results_mistral_7b_rag.jsonl (AVG 0.737 — bester RAG-Score bisher)
- eval_hybrid.py, eval_local_llms.py, rank_models.py

### Bot-Dateien
- textbot/telegram_bot.py, discord_bot.py, perplexity_text_improver.py
- textbot/run_telegram.sh, run_discord.sh

### Golden-Set-Dateien
- cross_exam_goldset_daniel_massa_v2.jsonl
- cross_exam_goldset_v2.jsonl
- shadowmaker_v7_km/output/goldset_*.json (13 Dateien)
- ihk_gold.jsonl

### Workflow-Dateien
- rag_runbook.md
- pplx_shadowmaker_rag_query.sh
- Zusammenfassungen/Prüfungen/mfg_clean_extract.sh

---

## Tina-Huang-Konzepte integriert

- [x] Project-Based Learning
- [x] Output-first Lernen
- [x] Internes Learning Log (daily_log.md)
- [x] Portfolio-Artefakte (portfolio/README.md)
- [x] Skill Stack (skill_stack.md)
- [x] 80/20-Lernen (in skill_stack.md dokumentiert)
- [x] AI als Lernbeschleuniger (RAG + opencode + Bots)
- [x] Dokumentationsdisziplin (Output-Pipeline)
- [x] Career Moat (Skill Stack + Burggraben)
- [x] Eval-getriebene Verbesserung (RAG-Eval-System)

## Nicht integriert (bewusst)
- Social-Media-Automation
- Finetuning / Run10 (erst nach RAG >0.80)
- Zertifikats-Roadmap
- YouTube-Content-Fokus

---

## RAG-Status (2026-05-12)

| Metrik | Wert |
|---|---|
| Index-Einträge | 3927 (goldset + pool + 1417 Thunderbird-Emails) |
| Embedding-Modell | multilingual-e5-large |
| Letzter Eval (top-k=3) | AVG 0.492 (206 Fragen) |
| Aktueller Eval (top-k=5) | AVG ~0.512 (laufend) |
| Ziel | >0.80 |
| Blockade Run10 | ja, bis RAG >0.80 |

## Modell-Status

| Modell | Status |
|---|---|
| shadowmaker-v6 | stabil, Loss 1.616, Fallback |
| shadowmaker-v9 | Smoke-Test FAIL (2/5), nicht produktiv |
| mistral:7b | RAG-Eval-Referenz |

---

## Nächste Schritte

1. Täglichen Prompt mit einem IHK-Thema ausführen (prompts/daily_output_prompt.txt)
2. Golden-Set pro Woche um mindestens 25 Datensätze erweitern
3. Smoke-Test wöchentlich ausführen (smoke_tests/)
4. RAG-Score auf >0.80 bringen (Index-Tuning, Chunk-Größe, Deduplizierung)
5. Run10 erst nach RAG >0.80 vorbereiten
6. openclaw-autopilot.service: Pfad-Fix deployed, läuft jetzt
7. vm.swappiness=10 manuell setzen: sudo sysctl vm.swappiness=10
