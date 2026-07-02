import json
from pathlib import Path
from collections import defaultdict

rows = []

for_file = sorted(Path("runs").glob("results_*.jsonl"))

for file in for_file:
    scores = []
    model = None
    mode = None

    with file.open("r", encoding="utf-8") as f:
        for line in f:
            item = json.loads(line)
            scores.append(float(item["score"]))
            model = item["model"]
            mode = item["mode"]

    avg = round(sum(scores) / len(scores), 3) if scores else 0.0
    rows.append((mode, model, len(scores), avg, str(file)))

print("mode\tmodel\tcases\tavg_score\tfile")
for row in rows:
    print("\t".join(map(str, row)))
