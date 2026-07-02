# AI Agent Knowledge — Schreibtisch

## Zweck

Dieses Dokument überträgt das zentrale AI-Agent-Wissen in dieses Repository. Es dient als wiederverwendbares Betriebsmodell für lokale AI-Operations, OpenClaw, ProofFlow, Governance, Automatisierung und Portfolio-Sicherheit.

## Repo-Rolle

Repository: Schreibtisch  
Agent-Rolle: Repo-Orchestrator-Compatible Agent Module

## Kernidee

Ein normaler Chatbot antwortet nur.  
Ein AI Agent bekommt ein Ziel, plant Schritte, nutzt Werkzeuge, merkt sich Informationen und prüft Ergebnisse.

Kurzform:

    Agent = Modell + Aufgabe + Werkzeuge + Gedächtnis + Kontrolle + Ablaufsteuerung

## Die 6 Komponenten

### 1. Model

Das Model ist das Gehirn.

Es entscheidet:

- Was bedeutet die Aufgabe?
- Welche Schritte sind nötig?
- Welches Tool soll genutzt werden?
- Wie soll das Ergebnis formuliert werden?

Anfänger-Satz:

    Das Modell ist der Denker. Je schwieriger die Aufgabe, desto stärker muss das Modell sein.

Prompt-Baustein:

    Du bist ein präziser AI-Agent für [Aufgabe].
    Dein Ziel ist: [konkretes Ziel].
    Arbeite schrittweise, prüfe deine Annahmen und liefere am Ende ein klares Ergebnis.

### 2. Tools

Tools sind die Hände des Agents.

Mit Tools kann ein Agent handeln:

- Websuche
- Dateien lesen
- E-Mails schreiben
- Kalender prüfen
- Datenbank abfragen
- Code ausführen
- APIs nutzen

Anfänger-Satz:

    Tools machen aus einem Redner einen Arbeiter.

Prompt-Baustein:

    Nutze verfügbare Tools nur, wenn sie für Genauigkeit oder Ausführung notwendig sind.
    Nutze kein Tool ohne klaren Zweck.
    Erkläre kurz, welches Tool du warum verwendest.

### 3. Memory

Memory ist das Gedächtnis.

Drei Ebenen:

- Kurzzeitgedächtnis: aktuelle Aufgabe
- Arbeitsgedächtnis: Zwischenergebnisse
- Langzeitgedächtnis: Nutzerpräferenzen, frühere Entscheidungen, Projektwissen

Anfänger-Satz:

    Memory verhindert, dass der Agent bei jedem Schritt wieder bei null anfängt.

Prompt-Baustein:

    Berücksichtige folgende bekannte Informationen:
    - Nutzerkontext: [Kontext]
    - Projektstand: [Stand]
    - bisherige Entscheidungen: [Entscheidungen]

    Speichere keine sensiblen Daten unnötig.
    Nutze Memory nur zur Verbesserung der Aufgabe.

### 4. Audio

Audio bedeutet Spracheingabe und Sprachausgabe.

Das kann sein:

- Sprache zu Text
- Text zu Sprache
- Meeting-Mitschnitt zu Zusammenfassung
- Voice-Agent am Telefon
- Interviewanalyse

Anfänger-Satz:

    Audio macht den Agenten hörbar und sprechfähig.

Prompt-Baustein:

    Wenn Audio-Input vorhanden ist:
    1. Transkribiere den Inhalt.
    2. Extrahiere Aufgaben, Fakten und offene Punkte.
    3. Erstelle eine strukturierte Zusammenfassung.
    4. Markiere unsichere Stellen.

### 5. Guardrails

Guardrails sind Sicherheitsregeln.

Sie verhindern, dass der Agent:

- falsche Aktionen ausführt
- private Daten veröffentlicht
- riskante Entscheidungen automatisiert
- Halluzinationen als Fakten verkauft
- ohne Freigabe E-Mails sendet oder Geld bewegt

Anfänger-Satz:

    Guardrails sind der Sicherheitszaun des Agents.

Prompt-Baustein:

    Halte diese Sicherheitsregeln ein:
    - Keine sensiblen Daten ausgeben.
    - Keine externen Aktionen ohne Freigabe.
    - Unsichere Fakten markieren.
    - Bei rechtlichen, medizinischen oder finanziellen Themen vorsichtig formulieren.
    - Vor riskanten Schritten eine Kontrollfrage stellen.

### 6. Orchestration

Orchestration ist die Ablaufsteuerung.

Sie entscheidet:

- Was passiert zuerst?
- Wann wird ein Tool genutzt?
- Wann wird geprüft?
- Wann wird abgebrochen?
- Wann übernimmt ein anderer Agent?

Anfänger-Satz:

    Orchestration ist der Einsatzleiter.

Prompt-Baustein:

    Arbeite nach diesem Ablauf:
    1. Ziel klären
    2. Aufgabe in Schritte zerlegen
    3. relevante Informationen sammeln
    4. Lösung erstellen
    5. Ergebnis prüfen
    6. finale Ausgabe liefern

## Merksatz

    MODEL         = Gehirn
    TOOLS         = Hände
    MEMORY        = Notizbuch
    AUDIO         = Ohren + Stimme
    GUARDRAILS    = Sicherheitszaun
    ORCHESTRATION = Einsatzleiter

## Repo-spezifische Anwendung

Für dieses Repository gilt:

    Rolle: Repo-Orchestrator-Compatible Agent Module

Arbeitsweise:

1. Status prüfen.
2. Fehler oder Ziel bestimmen.
3. Aufgabe in kleine Schritte zerlegen.
4. notwendige Tools oder Skripte nutzen.
5. Ergebnis prüfen.
6. Dokumentation aktualisieren.
7. Git-ready Zustand herstellen.

## Sicherheitsregeln für dieses Repo

- Keine Tokens, Keys oder Secrets committen.
- Keine privaten lokalen Pfade in Portfolio-Ausgaben veröffentlichen.
- Keine personenbezogenen Rohdaten in öffentliche Repos übernehmen.
- Riskante Aktionen zuerst prüfen.
- Git-Push nur nach sauberem Status und Security-Check.
- Human Review bei unsicheren, rechtlichen, finanziellen oder personenbezogenen Themen.

## Sofort nutzbares Minimal-Template

    Du bist ein lokaler AI-Operations-Agent.

    Aufgabe:
    [AUFGABE]

    Kontext:
    [PROJEKT / REPO / SYSTEMSTAND]

    6-Komponenten-Setup:

    1. Model:
    Arbeite technisch präzise und anfängerverständlich.

    2. Tools:
    Nutze nur notwendige Tools.
    Keine Secrets ausgeben.
    Keine lokalen Pfade veröffentlichen, wenn Portfolio-Sicherheit relevant ist.

    3. Memory:
    Berücksichtige Projektstand, Releases, bekannte Fehler und letzte Entscheidungen.

    4. Audio:
    Falls Video/Audio vorhanden ist, extrahiere Aufgaben, Befehle und Risiken.

    5. Guardrails:
    Keine Tokens, Keys, privaten Pfade oder personenbezogenen Daten ausgeben.
    Riskante Befehle zuerst erklären.
    Git-Push nur nach sauberem Status.

    6. Orchestration:
    A) Status prüfen
    B) Fehler identifizieren
    C) Lösung bauen
    D) Test durchführen
    E) Dokumentation erstellen
    F) Git-ready Ergebnis liefern

    Ausgabe:
    - Diagnose
    - Befehle
    - erwartetes Ergebnis
    - Sicherheitsprüfung
    - nächster Commit-Vorschlag

## Zentralsatz

Du baust lokal kein Chatbot-System.  
Du baust ein kontrolliertes Operations-System aus spezialisierten Agenten.

