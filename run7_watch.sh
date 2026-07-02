#!/usr/bin/env bash

watch -n 5 '
STEP=$(grep -oP "\d+(?=/144)" /tmp/run7_train.log 2>/dev/null | tail -1)
TOTAL=144

if [ -z "$STEP" ]; then
  STEP=0
fi

PCT=$(( STEP * 100 / TOTAL ))
FILLED=$(( PCT / 5 ))

BAR=$(printf "%${FILLED}s" | tr " " "█")$(printf "%$((20-FILLED))s" | tr " " "░")

LOSS=$(grep -oP "'"'"'loss'"'"': '"'"'\K[0-9.]+" /tmp/run7_train.log 2>/dev/null | tail -1)
TIME=$(grep -oP "\d+:\d+<\d+:\d+" /tmp/run7_train.log 2>/dev/null | tail -1)

ELAPSED=$(echo "$TIME" | cut -d"<" -f1)
REMAIN=$(echo "$TIME" | cut -d"<" -f2)

VRAM=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits 2>/dev/null)
GPU_U=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
GPU_T=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

echo ""
echo " ShadowMaker Run-7 — Live Training Monitor"
echo " ─────────────────────────────────────────"
echo " Fortschritt: [$BAR] $PCT%  ($STEP / $TOTAL Steps)"
echo " Laufzeit:    ${ELAPSED:-...}  |  Verbleibend: ~${REMAIN:-...}"
echo " Loss:        ${LOSS:-...}"
echo ""
echo " GPU  VRAM: ${VRAM:-...} MB  |  Last: ${GPU_U:-...}%  |  Temp: ${GPU_T:-...}°C"
echo " ─────────────────────────────────────────"
echo " $(date +"%H:%M:%S")  — aktualisiert alle 5s  |  Strg+C zum Beenden"
'
