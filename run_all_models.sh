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
