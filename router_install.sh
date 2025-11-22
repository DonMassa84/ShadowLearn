#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app"

echo "[+] Creating router.tsx folder structure ..."
mkdir -p "$BASE"

FILE="$BASE/router.tsx"

echo "[+] Writing router.tsx ..."
cat << 'EOC' > "$FILE"
import React from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import LearnView from "./views/LearnView";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/learn" element={<LearnView />} />
        <Route path="*" element={<Navigate to="/learn" replace />} />
      </Routes>
    </BrowserRouter>
  );
}
EOC

echo "[✓] router.tsx installed successfully."
echo "[!] Run with: bash router_install.sh"
