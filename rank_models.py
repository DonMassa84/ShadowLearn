import json
import re
from pathlib import Path
from collections import defaultdict

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

def structure_score(text):
    t = text.lower()
    hits = 0
    for patterns in CHECKS.values():
        if any(re.search(p, t) for p in patterns):
            hits += 1
    return hits / 10

data = defaultdict(list)

for file in sorted(Path("runs").glob("results_*.jsonl")):
    with file.open("r", encoding="utf-8") as f:
        for line in f:
            item = json.loads(line)
            model = item["model"]
            mode = item["mode"]
            old = float(item["score"])

            if mode == "ft":
                struct = structure_score(item.get("answer", ""))
                final = round((struct * 0.7) + (old * 0.3), 3)
            else:
                struct = None
                final = old

            data[(mode, model)].append({
                "old": old,
                "structure": struct,
                "final": final
            })

rows = []

for (mode, model), items in data.items():
    old_avg = round(sum(x["old"] for x in items) / len(items), 3)
    final_avg = round(sum(x["final"] for x in items) / len(items), 3)

    if mode == "ft":
        struct_avg = round(sum(x["structure"] for x in items) / len(items), 3)
    else:
        struct_avg = "-"

    rows.append((mode, model, len(items), old_avg, struct_avg, final_avg))

rows.sort(key=lambda x: (x[0], -x[5]))

print("mode\tmodel\tcases\told_avg\tstructure_avg\tfinal_avg")
for row in rows:
    print("\t".join(map(str, row)))
