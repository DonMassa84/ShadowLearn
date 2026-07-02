#!/usr/bin/env bash
set -euo pipefail

mkdir -p data/rag/documents data/finetune runs

cat > data/rag/documents/fuehrung_handbuch.md <<'EOF'
# Führungshandbuch

Bei Leistungsproblemen soll die Führungskraft zunächst die Situation analysieren, ein strukturiertes Mitarbeitergespräch führen, Ursachen klären und konkrete Maßnahmen vereinbaren. Die Umsetzung wird nach vier Wochen überprüft.

Bei Konflikten ist ein sachliches Gespräch zu führen. Ziel ist die Klärung der Ursachen, die Vereinbarung verbindlicher Regeln und die Wiederherstellung der Zusammenarbeit.

Geeignete Maßnahmen sind Zielvereinbarungen, Qualifizierung, Feedbackgespräche, Mentoring und regelmäßige Kontrolltermine.
EOF

cat > data/rag/eval_rag.jsonl <<'EOF'
{"id":"rag_001","question":"Was soll die Führungskraft bei Leistungsproblemen zuerst tun?","expected":"Die Führungskraft soll die Situation analysieren, ein strukturiertes Mitarbeitergespräch führen, Ursachen klären und konkrete Maßnahmen vereinbaren.","source":"fuehrung_handbuch.md"}
{"id":"rag_002","question":"Wann wird die Umsetzung überprüft?","expected":"Die Umsetzung wird nach vier Wochen überprüft.","source":"fuehrung_handbuch.md"}
{"id":"rag_003","question":"Welche Maßnahmen werden im Dokument genannt?","expected":"Genannt werden Zielvereinbarungen, Qualifizierung, Feedbackgespräche, Mentoring und regelmäßige Kontrolltermine.","source":"fuehrung_handbuch.md"}
{"id":"rag_004","question":"Welche Kündigungsfrist gilt laut Dokument?","expected":"Nicht im Kontext enthalten.","source":"fuehrung_handbuch.md"}
EOF

cat > data/finetune/eval_ft.jsonl <<'EOF'
{"id":"ft_001","instruction":"Formuliere eine IHK-taugliche Maßnahme zur Reduzierung von Fehlzeiten.","expected":"Zur Reduzierung der Fehlzeiten wird ein strukturiertes Fehlzeitengespräch eingeführt. Ziel ist es, Ursachen zu erkennen, Unterstützungsmaßnahmen zu vereinbaren und die Fehlzeitenquote innerhalb von drei Monaten um 15 Prozent zu senken."}
{"id":"ft_002","instruction":"Bewerte drei Alternativen zur Motivation eines leistungsschwachen Mitarbeiters.","expected":"Alternative A ist ein Feedbackgespräch, Alternative B eine Qualifizierungsmaßnahme, Alternative C eine Zielvereinbarung mit Kontrolle. Die Zielvereinbarung ist vorzuziehen, da sie konkret, überprüfbar und wirtschaftlich umsetzbar ist."}
{"id":"ft_003","instruction":"Erstelle eine kurze IHK-Antwort mit Situation, SMART-Ziel, Maßnahmen, Umsetzung und Kontrolle zum Thema Konflikt im Team.","expected":"Situation: Im Team besteht ein Konflikt, der Zusammenarbeit und Leistung beeinträchtigt. Ziel: Innerhalb von vier Wochen soll die Zusammenarbeit messbar verbessert werden. Maßnahmen: Einzelgespräche, gemeinsames Konfliktgespräch und verbindliche Teamregeln. Umsetzung: Die Führungskraft plant Gespräche, dokumentiert Vereinbarungen und legt Verantwortlichkeiten fest. Kontrolle: Nach vier Wochen werden Fehlkommunikation, Zielerreichung und Teamfeedback überprüft."}
EOF

cat > eval_local_llms.py <<'PY'
import json
import subprocess
import argparse
from pathlib import Path
from difflib import SequenceMatcher


def call_ollama(model: str, prompt: str) -> str:
    result = subprocess.run(
        ["ollama", "run", model, prompt],
        capture_output=True,
        text=True,
        timeout=180,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip())
    return result.stdout.strip()


def similarity(a: str, b: str) -> float:
    return SequenceMatcher(None, a.lower().strip(), b.lower().strip()).ratio()


def keyword_score(answer: str, expected: str) -> float:
    expected_words = {
        w.strip(".,;:!?()[]{}").lower()
        for w in expected.split()
        if len(w.strip(".,;:!?()[]{}")) > 4
    }
    if not expected_words:
        return 0.0

    answer_lower = answer.lower()
    hits = sum(1 for w in expected_words if w in answer_lower)
    return hits / len(expected_words)


def final_score(answer: str, expected: str) -> float:
    sim = similarity(answer, expected)
    kw = keyword_score(answer, expected)
    return round((sim * 0.35 + kw * 0.65), 3)


def run_ft(model: str, eval_file: Path, output_file: Path):
    output_file.parent.mkdir(parents=True, exist_ok=True)
    scores = []

    with eval_file.open("r", encoding="utf-8") as f, output_file.open("w", encoding="utf-8") as out:
        for line in f:
            item = json.loads(line)

            prompt = f"""Du bist ein präziser Prüfungsassistent für Mitarbeiterführung und Personalmanagement.

Aufgabe:
{item["instruction"]}

Regeln:
- Antworte direkt.
- Schreibe prüfungstauglich.
- Keine Meta-Erklärung.
- Wenn passend, nutze diese Struktur:
1 Situation
2 Goal SMART
3 Stakeholders
4 Causes Human / Organization / Process
5 Alternatives A/B/C
6 Evaluation Economic / Human / Organizational
7 Decision + justification
8 Implementation who / when / steps
9 Control KPIs / review / correction
10 Sustainability & communication / legal risk
"""

            answer = call_ollama(model, prompt)
            score = final_score(answer, item["expected"])
            scores.append(score)

            record = {
                "id": item["id"],
                "mode": "ft",
                "model": model,
                "instruction": item["instruction"],
                "expected": item["expected"],
                "answer": answer,
                "score": score,
            }

            out.write(json.dumps(record, ensure_ascii=False) + "\n")
            print(f'{item["id"]}: {score}')

    avg = round(sum(scores) / len(scores), 3) if scores else 0.0
    print(f"\nMODEL={model}")
    print(f"MODE=ft")
    print(f"CASES={len(scores)}")
    print(f"AVG_SCORE={avg}")


def run_rag(model: str, eval_file: Path, docs_dir: Path, output_file: Path):
    output_file.parent.mkdir(parents=True, exist_ok=True)
    scores = []

    with eval_file.open("r", encoding="utf-8") as f, output_file.open("w", encoding="utf-8") as out:
        for line in f:
            item = json.loads(line)
            source_path = docs_dir / item["source"]

            if not source_path.exists():
                raise FileNotFoundError(f"Missing source file: {source_path}")

            context = source_path.read_text(encoding="utf-8", errors="ignore")

            prompt = f"""Du beantwortest die Frage ausschließlich anhand des Kontextes.

KONTEXT:
{context[:12000]}

FRAGE:
{item["question"]}

Regeln:
- Nutze nur den Kontext.
- Wenn die Antwort nicht im Kontext steht, antworte exakt: Nicht im Kontext enthalten.
- Antworte kurz, fachlich und prüfungstauglich.
"""

            answer = call_ollama(model, prompt)
            score = final_score(answer, item["expected"])
            scores.append(score)

            record = {
                "id": item["id"],
                "mode": "rag",
                "model": model,
                "question": item["question"],
                "source": item["source"],
                "expected": item["expected"],
                "answer": answer,
                "score": score,
            }

            out.write(json.dumps(record, ensure_ascii=False) + "\n")
            print(f'{item["id"]}: {score}')

    avg = round(sum(scores) / len(scores), 3) if scores else 0.0
    print(f"\nMODEL={model}")
    print(f"MODE=rag")
    print(f"CASES={len(scores)}")
    print(f"AVG_SCORE={avg}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["rag", "ft"], required=True)
    parser.add_argument("--model", required=True)
    parser.add_argument("--eval-file", required=True)
    parser.add_argument("--docs-dir", default="data/rag/documents")
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    if args.mode == "ft":
        run_ft(
            model=args.model,
            eval_file=Path(args.eval_file),
            output_file=Path(args.out),
        )

    if args.mode == "rag":
        run_rag(
            model=args.model,
            eval_file=Path(args.eval_file),
            docs_dir=Path(args.docs_dir),
            output_file=Path(args.out),
        )


if __name__ == "__main__":
    main()
PY

cat > run_all_models.sh <<'SH2'
#!/usr/bin/env bash
set -euo pipefail

MODELS=(
  "llama3.1:8b"
  "mistral:7b"
  "qwen2.5:7b"
)

for model in "${MODELS[@]}"; do
  safe_model="${model//[:\/]/_}"

  echo
  echo "=== FT EVAL: $model ==="
  python3 eval_local_llms.py \
    --mode ft \
    --model "$model" \
    --eval-file data/finetune/eval_ft.jsonl \
    --out "runs/results_${safe_model}_ft.jsonl"

  echo
  echo "=== RAG EVAL: $model ==="
  python3 eval_local_llms.py \
    --mode rag \
    --model "$model" \
    --eval-file data/rag/eval_rag.jsonl \
    --docs-dir data/rag/documents \
    --out "runs/results_${safe_model}_rag.jsonl"
done
SH2

cat > summarize_results.py <<'PY2'
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
PY2

chmod +x run_all_models.sh

echo
echo "DONE."
echo
echo "Run single FT:"
echo "python3 eval_local_llms.py --mode ft --model llama3.1:8b --eval-file data/finetune/eval_ft.jsonl --out runs/results_llama31_ft.jsonl"
echo
echo "Run single RAG:"
echo "python3 eval_local_llms.py --mode rag --model llama3.1:8b --eval-file data/rag/eval_rag.jsonl --docs-dir data/rag/documents --out runs/results_llama31_rag.jsonl"
echo
echo "Run all:"
echo "./run_all_models.sh"
echo
echo "Summarize:"
echo "python3 summarize_results.py"
