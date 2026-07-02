# RAG + Run10

## Phase 1: RAG-Qualität

Ziel: Eval-Score 0.737 -> >0.80 ohne Training.

### 1. Embedding wechseln

```bash
ollama pull multilingual-e5-large
ollama list | grep e5
```

Altes Modell suchen:

```bash
grep -R "nomic-embed-text" ~/Schreibtisch
```

In `build_rag_index.py` ersetzen:

```python
EMBEDDING_MODEL = "multilingual-e5-large"
```

Für E5-Modelle wichtig:

```python
def format_passage(text: str) -> str:
    return f"passage: {text}"

def format_query(text: str) -> str:
    return f"query: {text}"
```

Dokumente als `passage:` einbetten. Retrieval-Queries als `query:` einbetten.

### 2. Alten Index sichern

```bash
mkdir -p ~/Schreibtisch/rag_backups
cp -r ~/Schreibtisch/rag_index ~/Schreibtisch/rag_backups/rag_index_before_e5_$(date +%F_%H%M)
```

### 3. Index neu bauen

```bash
rm -rf ~/Schreibtisch/rag_index
python3 ~/Schreibtisch/build_rag_index.py
```

Kontrolle:

```bash
du -sh ~/Schreibtisch/rag_index
find ~/Schreibtisch/rag_index -type f | wc -l
```

### 4. Datenquellen prüfen

Soll:

```text
[ ] 23 Perplexity-Goldsets
[ ] 2656 Thunderbird-Emails
[ ] bestehende Altquellen
[ ] Embedding-Modell: multilingual-e5-large
[ ] Index komplett neu gebaut
```

Suche:

```bash
find ~/Schreibtisch -iname "*perplexity*" -o -iname "*goldset*"
find ~/Schreibtisch -iname "*thunderbird*" -o -iname "*mail*"
```

### 5. Eval laufen lassen

```bash
mkdir -p ~/Schreibtisch/eval_runs/e5
python3 ~/Schreibtisch/eval_local_llms.py --model mistral:7b | tee ~/Schreibtisch/eval_runs/e5/eval.log
```

Score extrahieren:

```bash
grep -Ei "score|accuracy|rag|eval" ~/Schreibtisch/eval_runs/e5/eval.log
```

## Entscheidung nach Phase 1

### Wenn RAG > 0.80

Run 10 vorbereiten.

### Wenn RAG 0.76-0.80

Nicht sofort Embedding wechseln. Prüfen:

```text
[ ] Chunk-Größe
[ ] Top-k Retrieval
[ ] Query/Passage-Prefix
[ ] Deduplizierung
[ ] Goldset-Abdeckung
[ ] Thunderbird-Rauschen
```

### Wenn RAG < 0.76

Debug prüfen:

```text
[ ] Index wurde nicht neu gebaut
[ ] Eval nutzt alten Index
[ ] Modell wird nicht genutzt
[ ] falsche Embedding-Dimension
[ ] Quellen fehlen
[ ] Query ohne e5-prefix
```

Danach optional `deepset/gbert-large` testen.

## Phase 2: Qwen2.5-7B Finetuning

Erst starten, wenn RAG stabil gemessen ist.

Ziel:

```text
FT-Score <0.22 -> >0.50
Modell: Qwen2.5-7B-Instruct
LoRA: r=16, alpha=32
Quantisierung: 4bit
LR: 1e-5
Epochs: 2
```

In `train_lora_qwen.py`:

```python
model_name = "Qwen/Qwen2.5-7B-Instruct"

load_in_4bit = True

lora_r = 16
lora_alpha = 32
lora_dropout = 0.05

learning_rate = 1e-5
num_train_epochs = 2
```

PEFT-Konfiguration:

```python
LoraConfig(
    r=16,
    lora_alpha=32,
    target_modules=[
        "q_proj", "k_proj", "v_proj", "o_proj",
        "gate_proj", "up_proj", "down_proj"
    ],
    lora_dropout=0.05,
    bias="none",
    task_type="CAUSAL_LM"
)
```

## Phase 3: Workflows

```text
wf040_bescheid_recherche.sh
wf030_ihk_content_automation.sh
strategist_career_agent.sh
```

Perplexity in Workflows integrieren.

Thunderbird wöchentlich:

```bash
systemctl --user enable thunderbird-rag-update.timer
```

## Harte Reihenfolge

```text
1. multilingual-e5-large installieren
2. build_rag_index.py anpassen
3. Perplexity-Goldsets einpflegen
4. Thunderbird-Emails einpflegen
5. RAG-Index komplett neu bauen
6. Eval mit mistral:7b laufen lassen
7. Score dokumentieren
8. Nur bei RAG >0.80 Run 10 vorbereiten
9. Qwen2.5-7B laden
10. Trainingsdaten auf ChatML neu generieren
11. Run 10 starten
```

## Kritische Regel

RAG zuerst stabilisieren. Kein Run 10, solange Retrieval unsauber ist.
