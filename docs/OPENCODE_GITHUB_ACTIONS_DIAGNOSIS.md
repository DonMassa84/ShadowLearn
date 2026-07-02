# OpenCode GitHub Actions Diagnosis

Zeit: 2026-07-02T09:56:23+02:00
Repo: /home/schattenmacher/Schreibtisch

## 1. Git Status
```text
## main...origin/main
?? docs/
```

## 2. Workflow-Dateien
```text
.github/workflows/deploy.yml
```

## 3. deploy.yml
**Status:** vorhanden

```yaml
name: Deploy to GitHub Pages

on:
  workflow_dispatch:

on_disabled:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
          cache-dependency-path: app/package-lock.json

      - name: Install dependencies
        run: npm ci
        working-directory: app

      - name: Build
        run: npm run build
        working-directory: app

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: app/dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## 4. index.html
**Status:** vorhanden

```html
const CACHE_NAME = 'frs-v1';
const urlsToCache = [
    '/',
    '/index.html',
    '/manifest.json'
];

self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME).then(cache => cache.addAll(urlsToCache))
    );
});

self.addEventListener('fetch', event => {
    event.respondWith(
        caches.match(event.request).then(response => {
            return response || fetch(event.request);
        })
    );
});

```

## 5. .gitignore Bewertung
**Status:** vorhanden

Wichtige Schutzmuster:
```text
2:logs
33:node_modules/
55:.env
56:.env.test
57:.env.production
59:.cache
68:.cache/
90:.env.*
91:!.env.example
92:__pycache__/
104:textbot_backups/
105:textbot/backups/
112:shadowmaker_v7_km/
113:shadowmaker_v7_km/output/
114:textbot/
118:hier ist es.txt
119:Ergebnis.txt
121:*.mp4
122:*.xspf
123:chrome-*-Default.desktop
125:Openai Codex/
128:Freies Radio Stuttgart 20-11-25/
```

## 6. Sicherheitsbewertung

- Kein `git push` ausgeführt.
- Kein `git add .` ausgeführt.
- Keine `.env`-Dateien geöffnet oder kopiert.
- Diagnose enthält nur getrackte/öffentliche Projektstruktur und keine Secrets.

## 7. Vermutete Ursache fehlgeschlagener GitHub Actions

Die letzten GitHub-Runs waren rot. Lokal muss geprüft werden, ob `.github/workflows/deploy.yml` noch zu GitHub Pages passt oder ein alter/unnötiger Deploy-Workflow ist. Wenn GitHub Pages bereits über den nativen `pages-build-deployment`-Workflow läuft, kann ein zusätzlicher eigener `deploy.yml` redundant oder fehlerhaft sein.

## 8. Empfehlung

1. Lokalen Healthcheck ausführen:

```bash
bash scripts/shadowlearn_github_actions_healthcheck.sh
```

2. Danach Diff prüfen:

```bash
git diff -- .github/workflows/deploy.yml docs/OPENCODE_GITHUB_ACTIONS_DIAGNOSIS.md scripts/shadowlearn_github_actions_healthcheck.sh
```

3. Nur wenn der Healthcheck grün ist: gezielt committen, nicht `git add .`.
