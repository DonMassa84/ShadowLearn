#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app"

cd "$APP"

rm -rf src/ai
rm -rf src/app
mkdir -p src/ai
mkdir -p src/app/components
mkdir -p src/app/views
mkdir -p src/app/layout
mkdir -p src/app/store
mkdir -p src/app/engine
mkdir -p src/app/router
mkdir -p src/engine/data

cat << 'EOC' > src/engine/data/default.json
[
  {
    "question": "Was ist der Unterschied zwischen Führungsstil und Führungstechnik?",
    "answer": "Führungsstil = langfristiges Verhalten; Führungstechnik = kurzfristige situative Methode."
  }
]
EOC

cat << 'EOC' > src/index.css
@import "animate.css";
body {
  margin: 0;
  background: #0f172a;
  color: #e2e8f0;
}
.fade-in {
  animation: fadeIn 0.6s ease-in-out;
}
EOC

cat << 'EOC' > src/app/layout/AppLayout.tsx
import React from "react";

export default function AppLayout({ children }) {
  return (
    <div className="fade-in" style={{ minHeight: "100vh", padding: "20px" }}>
      {children}
    </div>
  );
}
EOC

cat << 'EOC' > src/app/router/index.tsx
import { BrowserRouter, Routes, Route } from "react-router-dom";
import LearnView from "../views/LearnView";
import TopicsView from "../views/TopicsView";
import DecksView from "../views/DecksView";
import ImporterView from "../views/ImporterView";

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LearnView />} />
        <Route path="/learn" element={<LearnView />} />
        <Route path="/topics" element={<TopicsView />} />
        <Route path="/decks" element={<DecksView />} />
        <Route path="/import" element={<ImporterView />} />
      </Routes>
    </BrowserRouter>
  );
}
EOC

cat << 'EOC' > src/app/components/NavigationBar.tsx
import { Link, useLocation } from "react-router-dom";

export default function NavigationBar() {
  const loc = useLocation();
  return (
    <div style={{ display: "flex", gap: "20px", padding: "10px" }}>
      <Link to="/learn">Lernen</Link>
      <Link to="/topics">Themen</Link>
      <Link to="/decks">Decks</Link>
      <Link to="/import">Import</Link>
    </div>
  );
}
EOC

cat << 'EOC' > src/app/views/LearnView.tsx
import NavigationBar from "../components/NavigationBar";
import data from "../../engine/data/default.json";

export default function LearnView() {
  const card = data[0];
  return (
    <div className="fade-in">
      <NavigationBar />
      <h1>Aktiver Lernmodus</h1>
      <div>{card.question}</div>
      <div>{card.answer}</div>
    </div>
  );
}
EOC

cat << 'EOC' > src/app/views/TopicsView.tsx
import NavigationBar from "../components/NavigationBar";
export default function TopicsView() {
  return (
    <div className="fade-in">
      <NavigationBar />
      <h1>Themen</h1>
    </div>
  );
}
EOC

cat << 'EOC' > src/app/views/DecksView.tsx
import NavigationBar from "../components/NavigationBar";
export default function DecksView() {
  return (
    <div className="fade-in">
      <NavigationBar />
      <h1>Decks</h1>
    </div>
  );
}
EOC

cat << 'EOC' > src/app/views/ImporterView.tsx
import NavigationBar from "../components/NavigationBar";

export default function ImporterView() {
  return (
    <div className="fade-in">
      <NavigationBar />
      <h1>Importer</h1>
      <p>Hier kommt der Flashcard-Importer (KI) hin.</p>
    </div>
  );
}
EOC

cat << 'EOC' > src/App.tsx
import AppRouter from "./app/router";
import AppLayout from "./app/layout/AppLayout";

export default function App() {
  return (
    <AppLayout>
      <AppRouter />
    </AppLayout>
  );
}
EOC

cat << 'EOC' > src/main.tsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOC

npm install animate.css

npm run dev
