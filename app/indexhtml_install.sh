#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/Dokumente/ShadowLearn/app"

echo "[+] Writing new index.html ..."

cat << 'EOC' > "$BASE/index.html"
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ShadowLearn</title>
  </head>
  <body class="bg-slate-900">
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOC

echo "[✓] index.html wurde korrekt erstellt."
echo "[!] Starte jetzt: npm run dev"
