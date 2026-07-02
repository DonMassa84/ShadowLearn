Aus dem `paste.txt` können wir vor allem zwei Dinge machen: einen kompakten Status‑Report zu Run14 und ein kleines Helfer‑Script, das genau diesen Status jederzeit neu ausgibt. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/71413924/2aa658a5-8c44-42e4-8cd9-a377579b8870/paste.txt)

## 1. Was der Log uns sagt

- GPU ist ausgelastet, Temperatur und Verbrauch sind hoch, aber im Rahmen, d. h. Training läuft „voll Stoff“. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/71413924/2aa658a5-8c44-42e4-8cd9-a377579b8870/paste.txt)
- `train_lora_qwen_v14.py` (Run14) läuft als PID 91965 und belegt den Großteil des GPU‑Speichers. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/71413924/2aa658a5-8c44-42e4-8cd9-a377579b8870/paste.txt)
- Deine ganzen Watcher (OCR, Mail, openclaw, Discord‑Router usw.) laufen stabil nebenher. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/71413924/2aa658a5-8c44-42e4-8cd9-a377579b8870/paste.txt)

Das ist im Grunde ein „Schnappschuss“ deines Systems kurz nach Start von Run14.

## 2. Nützliches Script aus dem Log bauen

Aus den relevanten Teilen können wir ein generisches `run_status_check.sh` machen, das du jederzeit starten kannst, ohne wieder alles tippen zu müssen. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/71413924/2aa658a5-8c44-42e4-8cd9-a377579b8870/paste.txt)

Vorschlag:

```bash
cat << 'EOF' > ~/openclaw_training/scripts/run_status_check.sh
#!/usr/bin/env bash
set -Eeuo pipefail

echo "=== RUN STATUS CHECK ==="
date
echo

echo "=== 1) GPU Übersicht ==="
nvidia-smi || echo "nvidia-smi nicht verfügbar"
echo

echo "=== 2) GPU-Compute-Prozesse ==="
nvidia-smi --query-compute-apps=pid,used_memory,name \
  --format=csv,noheader 2>/dev/null || echo "keine compute apps"
echo

echo "=== 3) Details zu Trainingsprozess (PID 91965 heute, sonst anpassen) ==="
PID=91965
if ps -p "$PID" > /dev/null 2>&1; then
  ps -p "$PID" -o pid,ppid,stat,etime,%cpu,%mem,cmd
else
  echo "Prozess $PID läuft nicht (mehr)."
fi
echo

echo "=== 4) Top GPU Memory Usage ==="
nvidia-smi --query-compute-apps=pid,used_memory,name \
  --format=csv,noheader 2>/dev/null \
  | sort -t',' -k2 -rh | head -10 || true
echo

echo "=== 5) Python/Training Prozesse ==="
ps aux | grep -E 'train_lora_qwen_v14.py|openclaw|ocr_watcher.py' \
  | grep -v grep || echo "keine passenden Prozesse gefunden"
echo

echo "=== DONE ==="
EOF

chmod +x ~/openclaw_training/scripts/run_status_check.sh
```

Dann jederzeit:

```bash
bash ~/openclaw_training/scripts/run_status_check.sh
```

Wenn du willst, können wir denselben Ansatz auch für „Run fertig? + GPU frei? + jetzt Migration starten?“ in ein zweites, noch kompakteres Script gießen, das parallel zu deiner Morgen‑Checkliste läuft.
