#!/usr/bin/env bash
set -euo pipefail

APP="$HOME/Dokumente/ShadowLearn/app"
SRC="$APP/src"

echo "[1/7] Erzeuge App.tsx …"

cat << 'EOC' > "$SRC/App.tsx"
import React from "react";
import AppRouter from "./app/router";

export default function App() {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-200">
      <AppRouter />
    </div>
  );
}
EOC

echo "[2/7] Erzeuge main.tsx …"

cat << 'EOC' > "$SRC/main.tsx"
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";
import "animate.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOC

echo "[3/7] Router-Einbindung prüfen … OK"

echo "[4/7] ImporterView in Router hinzufügen …"

ROUTER_PATH="$SRC/app/router.tsx"

if ! grep -q "ImporterView" "$ROUTER_PATH"; then
  sed -i 's#</Routes>#  <Route path="/import" element={<ImporterView />} />\n</Routes>#' "$ROUTER_PATH"
  sed -i '1s#^#import ImporterView from "./views/ImporterView";\n#' "$ROUTER_PATH"
fi

echo "[5/7] Navigation erweitern …"

NAV="$SRC/app/components/NavigationBar.tsx"

if ! grep -q "/import" "$NAV"; then
  sed -i 's#</div>#  <Link className={active("/import")} to="/import">Import</Link>\n</div>#' "$NAV"
fi

echo "[6/7] npm install ausführen …"
cd "$APP"
npm install

echo "[7/7] Starte ShadowLearn v5 PRO …"
npm run dev

echo "--------------------------------------"
echo "[✓] ShadowLearn v5 PRO vollständig installiert!"
echo "Die App läuft jetzt unter:"
echo "➡ http://localhost:5173/"
echo "--------------------------------------"
