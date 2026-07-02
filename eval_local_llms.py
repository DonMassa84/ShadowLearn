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
