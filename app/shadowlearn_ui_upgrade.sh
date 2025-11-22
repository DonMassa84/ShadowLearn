#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app"

echo "[1/6] Installiere Animate.css…"
npm install animate.css --prefix "$APP"

echo "[2/6] Patch: index.css für globale Animationen…"
cat << 'CSS' >> "$APP/src/index.css"
@import "animate.css";

.fade-in {
  animation: fadeIn 0.6s ease-out;
}

.slide-up {
  animation: slideInUp 0.6s ease-out;
}

.button-pop {
  transition: transform 0.15s ease;
}
.button-pop:hover {
  transform: scale(1.06);
}
CSS

echo "[3/6] Patch: AppLayout Animation…"
sed -i 's/<div className="w-full max-w-2xl">/<div className="w-full max-w-2xl fade-in">/' \
  "$APP/src/app/layout/AppLayout.tsx"

echo "[4/6] Patch: NavigationBar Hover + Underline…"
sed -i 's/navLink baseStyles/navLink baseStyles relative after:absolute after:left-0 after:bottom-0 after:h-0.5 after:bg-cyan-300 after:w-0 hover:after:w-full after:transition-all/' \
  "$APP/src/app/components/NavigationBar.tsx"

echo "[5/6] Patch: LearnView Card Animation…"
sed -i 's/className="p-6 bg-slate-800/ className="p-6 bg-slate-800 fade-in slide-up/' \
  "$APP/src/app/views/LearnView.tsx"

echo "[6/6] Patch: Buttons animieren…"
sed -i 's/btn-green"/btn-green button-pop"/g' "$APP/src/app/views/LearnView.tsx"
sed -i 's/btn-red"/btn-red button-pop"/g' "$APP/src/app/views/LearnView.tsx"
sed -i 's/btn-dark"/btn-dark button-pop"/g' "$APP/src/app/views/LearnView.tsx"

echo "-----------------------------------------------"
echo "[✓] ShadowLearn UI erfolgreich erweitert!"
echo "Starte neu mit:  cd ~/Dokumente/ShadowLearn/app && npm run dev"
echo "-----------------------------------------------"
