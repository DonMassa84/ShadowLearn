#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app/src/app"

###############################################
# Update router.tsx to include navigation views
###############################################
cat << 'EOR' > "$BASE/router.tsx"
import React from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import LearnView from "./views/LearnView";
import TopicsView from "./views/TopicsView";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/learn" element={<LearnView />} />
        <Route path="/topics" element={<TopicsView />} />
        <Route path="*" element={<Navigate to="/learn" replace />} />
      </Routes>
    </BrowserRouter>
  );
}
EOR

###############################################
# Update App.tsx to wrap everything in AppLayout
###############################################
cat << 'EOA' > "$BASE/../App.tsx"
import React from "react";
import AppRouter from "./app/router";
import NavigationBar from "./app/components/NavigationBar";
import AppLayout from "./app/layout/AppLayout";

export default function App() {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-200">
      <NavigationBar />
      <AppLayout>
        <AppRouter />
      </AppLayout>
    </div>
  );
}
EOA

echo "[✓] Router + App Layout erfolgreich aktualisiert."
