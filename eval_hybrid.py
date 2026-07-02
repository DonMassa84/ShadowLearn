import json
import subprocess
from pathlib import Path
from difflib import SequenceMatcher

RAG_MODEL = "mistral:7b"
STRUCTURE_MODEL = "llama3.1:8b"

def call_ollama(model, prompt):
    result = subprocess.run(
        ["ollama", "run", model, prompt],
        capture_output=True,
        text=True,
        timeout=180,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip())
    return result.stdout.strip()

def similarity(a, b):
    return SequenceMatcher(None, a.lower().strip(), b.lower().strip()).ratio()

def keyword_score(answer, expected):
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

def final_score(answer, expected):
    sim = similarity(answer, expected)
    kw = keyword_score(answer, expected)
    return round((sim * 0.35 + kw * 0.65), 3)

docs_dir = Path("data/rag/documents")
eval_file = Path("data/rag/eval_rag.jsonl")
out_file = Path("runs/results_hybrid_mistral_to_llama_rag.jsonl")
out_file.parent.mkdir(exist_ok=True)

scores = []

with eval_file.open("r", encoding="utf-8") as f, out_file.open("w", encoding="utf-8") as out:
    for line in f:
        item = json.loads(line)
        context = (docs_dir / item["source"]).read_text(encoding="utf-8", errors="ignore")

        rag_prompt = f"""Beantworte die Frage ausschließlich anhand des Kontextes.

KONTEXT:
{context[:12000]}

FRAGE:
{item["question"]}

Regeln:
- Nutze nur den Kontext.
- Wenn die Antwort nicht im Kontext steht, antworte exakt: Nicht im Kontext enthalten.
- Antworte sachlich und kurz.
"""

        factual_answer = call_ollama(RAG_MODEL, rag_prompt)

        structure_prompt = f"""Forme die folgende sachliche Antwort in eine prüfungstaugliche IHK-Antwort um.

SACHANTWORT:
{factual_answer}

Regeln:
- Verändere keine Fakten.
- Erfinde keine Informationen.
- Wenn die Sachantwort "Nicht im Kontext enthalten." lautet, gib exakt das zurück.
- Sonst nutze die 10-Punkte-Struktur:

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

        final_answer = call_ollama(STRUCTURE_MODEL, structure_prompt)

        score = final_score(final_answer, item["expected"])
        scores.append(score)

        record = {
            "id": item["id"],
            "mode": "rag",
            "model": f"{RAG_MODEL} -> {STRUCTURE_MODEL}",
            "question": item["question"],
            "source": item["source"],
            "expected": item["expected"],
            "factual_answer": factual_answer,
            "answer": final_answer,
            "score": score,
        }

        out.write(json.dumps(record, ensure_ascii=False) + "\n")
        print(f'{item["id"]}: {score}')

avg = round(sum(scores) / len(scores), 3) if scores else 0.0
print(f"\nHYBRID={RAG_MODEL} -> {STRUCTURE_MODEL}")
print(f"CASES={len(scores)}")
print(f"AVG_SCORE={avg}")
