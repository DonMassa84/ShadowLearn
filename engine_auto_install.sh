#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn"

echo "[+] Creating engine folder structure ..."
mkdir -p "$BASE/app/src/engine/core"
mkdir -p "$BASE/app/src/engine/modules"
mkdir -p "$BASE/app/src/engine/data"

echo "[+] Writing flashcards.ts ..."
cat << 'EOC' > "$BASE/app/src/engine/core/flashcards.ts"
export class FlashcardEngine {
  constructor(flashcards = []) {
    this.flashcards = flashcards;
    this.index = 0;
    this.history = [];
    this.ratings = {};
    this.mode = "active";
    this.delay = 5000;
  }

  load(data) {
    this.flashcards = data;
    this.index = 0;
    this.history = [];
    this.ratings = {};
  }

  setMode(mode) {
    this.mode = mode;
  }

  setDelay(ms) {
    this.delay = ms;
  }

  current() {
    return this.flashcards[this.index] || null;
  }

  next() {
    if (this.flashcards.length === 0) return null;
    this.history.push(this.index);
    this.index = (this.index + 1) % this.flashcards.length;
    return this.current();
  }

  previous() {
    if (this.history.length === 0) return this.current();
    this.index = this.history.pop();
    return this.current();
  }

  rate(cardId, score) {
    this.ratings[cardId] = score;
  }

  getProgress() {
    const rated = Object.keys(this.ratings).length;
    const total = this.flashcards.length;
    return total === 0 ? 0 : Math.round((rated / total) * 100);
  }

  shuffle() {
    for (let i = this.flashcards.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [this.flashcards[i], this.flashcards[j]] = [
        this.flashcards[j],
        this.flashcards[i],
      ];
    }
    this.index = 0;
  }

  auto(callback) {
    if (this.mode !== "passive") return;
    callback(this.current());
    setTimeout(() => this.auto(callback), this.delay);
    this.next();
  }
}
EOC

echo "[+] Engine installed successfully."
echo "[✓] Run with: bash engine_auto_install.sh"
