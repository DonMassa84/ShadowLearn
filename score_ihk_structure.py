import json
import re
import sys
from pathlib import Path

CHECKS = {
    "situation": [r"situation", r"ausgangslage", r"problem"],
    "smart_goal": [r"smart", r"ziel", r"innerhalb", r"\d+\s*(wochen|monaten|tage|%)"],
    "stakeholders": [r"stakeholder", r"beteiligte", r"mitarbeiter", r"führungskraft", r"team"],
    "causes": [r"ursache", r"human", r"organisation", r"prozess"],
    "alternatives": [r"alternative", r"\bA\b", r"\bB\b", r"\bC\b"],
    "evaluation": [r"bewertung", r"wirtschaft", r"mensch", r"organisator"],
    "decision": [r"entscheidung", r"begründ", r"vorzuziehen", r"gewählt"],
    "implementation": [r"umsetzung", r"wer", r"wann", r"maßnahme", r"schritte"],
    "control": [r"kontrolle", r"kpi", r"kennzahl", r"review", r"überprüf"],
    "sustainability": [r"nachhalt", r"kommunikation", r"recht", r"dokumentation"]
}

def hit(text, patterns):
    t = text.lower()
    return any(re.search(p, t) for p in patterns)

def score_answer(answer):
    hits = {}
    for name, patterns in CHECKS.items():
        hits[name] = 1 if hit(answer, patterns) else 0
    return sum(hits.values()), hits

if len(sys.argv) != 2:
    print("Usage: python3 score_ihk_structure.py runs/results_x.jsonl")
    sys.exit(1)

path = Path(sys.argv[1])
rows = []

with path.open("r", encoding="utf-8") as f:
    for line in f:
        item = json.loads(line)
        answer = item.get("answer", "")
        total, hits = score_answer(answer)
        rows.append(total)

        print(f'\n{item["id"]} | structure_score={total}/10 | old_score={item.get("score")}')
        missing = [k for k, v in hits.items() if v == 0]
        print("missing:", ", ".join(missing) if missing else "none")

avg = round(sum(rows) / len(rows), 2) if rows else 0
print(f"\nAVG_STRUCTURE_SCORE={avg}/10")
