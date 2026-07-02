# Runbook

## Standardbetrieb

~~~bash
make doctor
make setup
make test
make run
~~~

## Fehlerdiagnose

### 1. Repo unvollständig

~~~bash
make doctor
~~~

### 2. Abhängigkeiten fehlen

~~~bash
make setup
~~~

Bei Node: npm ci bevorzugen, wenn package-lock.json existiert.  
Bei Python: virtuelle Umgebung .venv verwenden.

### 3. Tests fehlen

Wenn keine Tests existieren, muss mindestens der Smoke-Test erfolgreich laufen:

~~~bash
bash scripts/smoke-test.sh
~~~

### 4. Secret-Warnung

~~~bash
make security
~~~

Findings prüfen, Secrets rotieren, .env aus Git entfernen, nur .env.example behalten.

### 5. Release blockiert

~~~bash
make release-check
~~~

Alle Warnungen beheben, dann committen, taggen und pushen.

## Wiederherstellung

~~~bash
git status
git log --oneline -5
git restore <datei>
git clean -fd --dry-run
~~~

Destruktive Kommandos erst nach Dry-Run ausführen.
