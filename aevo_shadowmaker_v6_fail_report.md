# Shadowmaker v6 – Smoke-Test Fail Report

## Status

shadowmaker-v6:latest ist aktuell NICHT einsatzbereit.

Das Modell hat im AEVO-/IHK-Smoke-Test mehrere harte Fachfehler erzeugt und darf nicht als Prüfungs-, Telegrambot- oder Default-Modell genutzt werden.

---

## 1. Smoke-Test Ergebnisse

### Frage 1

**Frage:**  
Was ist die AEVO und wer benötigt sie?

**v6-Antwort:**  
Die AEVO sei ein "Austrian Electronic Voting System".

**Bewertung:**  
Falsch. Harte Halluzination.

**Korrekte Antwort:**  
Die AEVO ist die Ausbilder-Eignungsverordnung. Sie regelt den Nachweis der berufs- und arbeitspädagogischen Eignung von Ausbildern. Benötigt wird sie von Personen, die in anerkannten Ausbildungsberufen nach BBiG oder HwO ausbilden wollen.

---

### Frage 2

**Frage:**  
Nennen Sie drei Führungsstile nach Lewin.

**v6-Antwort:**  
Autoritäre Führung, persuasive Führung, kommunikative Führung.

**Bewertung:**  
Falsch.

**Korrekte Antwort:**  
Die drei Führungsstile nach Kurt Lewin sind:

1. Autoritärer Führungsstil
2. Demokratischer bzw. kooperativer Führungsstil
3. Laissez-faire-Führungsstil

---

### Frage 3

**Frage:**  
Was regelt §14 BBiG?

**v6-Antwort:**  
Multiple-Choice-artiger Unsinn ohne fachlichen Bezug.

**Bewertung:**  
Falsch.

**Korrekte Antwort:**  
§14 BBiG regelt die Pflichten des Ausbildenden. Dazu gehören insbesondere:

- Vermittlung der beruflichen Handlungsfähigkeit
- Ausbildung nach Ausbildungsordnung
- kostenlose Bereitstellung der Ausbildungsmittel
- Freistellung für Berufsschule und Prüfungen
- charakterliche Förderung
- Schutz vor sittlichen und körperlichen Gefahren

---

### Frage 4

**Frage:**  
Wie lange dauert die Probezeit in der Ausbildung?

**v6-Antwort:**  
Die Ausbildung dauere 18 Monate; es gebe mehrere Probezeiten.

**Bewertung:**  
Falsch.

**Korrekte Antwort:**  
Die Probezeit in der Berufsausbildung muss mindestens einen Monat und darf höchstens vier Monate dauern. Rechtsgrundlage ist §20 BBiG.

---

### Frage 5

**Frage:**  
Was ist der Unterschied zwischen Unterweisung und Unterricht?

**v6-Antwort:**  
Das Modell stellt Rückfragen und beantwortet die Frage nicht.

**Bewertung:**  
Falsch / nicht prüfungstauglich.

**Korrekte Antwort:**  
Unterweisung ist eine praxisnahe, arbeitsplatzbezogene Anleitung zum Erlernen konkreter beruflicher Tätigkeiten. Unterricht ist stärker theoretisch, systematisch und wissensorientiert. In der Ausbildung ergänzt der Unterricht die praktische Unterweisung.

---

## 2. Gesamtbewertung

shadowmaker-v6:latest = FAIL

Nicht verwenden für:

- AEVO-Prüfungsvorbereitung
- IHK-Antworttraining
- Telegrambot-Default
- Fachfragen zu BBiG, AEVO, Ausbildung, Personalführung
- automatische Antwortgenerierung

---

## 3. Wahrscheinliche Ursachen

### Human

Trainingsdaten enthalten falsche, unsaubere oder nicht ausreichend kuratierte Q&A-Paare.

### Organization

Es gibt offenbar kein hartes Golden-Set als Pflichtprüfung vor Registrierung eines neuen Modells.

### Process

Der Smoke-Test wurde erst nach dem Build sichtbar, aber nicht als Gate vor Produktivnutzung eingesetzt.

### Data

Das Modell hat möglicherweise allgemeines Sprachmuster gelernt, aber kein stabiles prüfungsrelevantes AEVO-/BBiG-Wissen.

---

## 4. Sofortmaßnahmen

### v6 nicht produktiv nutzen

```bash
ollama run shadowmaker-v5:latest

Oder für allgemeine Fachantworten:

ollama run llama3.1:8b

Oder für schnelle Antworten:

ollama run qwen2.5:3b
5. Optional: v6 löschen
ollama rm shadowmaker-v6:latest

Oder behalten, aber nicht als Default setzen.

6. Pflicht-Smoke-Test für zukünftige Modelle

Jedes neue AEVO-/IHK-Modell muss diese Fragen bestehen:

Was ist die AEVO und wer benötigt sie?
Nennen Sie drei Führungsstile nach Lewin.
Was regelt §14 BBiG?
Wie lange dauert die Probezeit in der Ausbildung?
Was ist der Unterschied zwischen Unterweisung und Unterricht?
Nennen Sie die vier Stufen der Unterweisung.
Welche Pflichten hat der Auszubildende nach §13 BBiG?
Was ist der Ausbildungsrahmenplan?
Was ist ein betrieblicher Ausbildungsplan?
Wann ist eine Kündigung während der Probezeit möglich?
7. Bestehensregel

Ein Modell besteht nur, wenn:

mindestens 8 von 10 Antworten fachlich korrekt sind
keine Halluzination bei AEVO, BBiG oder Gesetzesgrundlagen vorkommt
keine erfundenen Gesetze genannt werden
keine Multiple-Choice-Reste oder Datensatzartefakte erscheinen
jede Antwort prüfungsnah und direkt nutzbar ist
Antwortzeit pro Frage unter 30 Sekunden bleibt
8. Golden-Set Beispielantworten
AEVO

Die AEVO ist die Ausbilder-Eignungsverordnung. Sie regelt den Nachweis der berufs- und arbeitspädagogischen Eignung von Ausbildern. Wer in anerkannten Ausbildungsberufen nach BBiG oder HwO ausbilden will, muss diese Eignung in der Regel nachweisen.

Führungsstile nach Lewin

Die drei Führungsstile nach Lewin sind der autoritäre Führungsstil, der demokratische bzw. kooperative Führungsstil und der Laissez-faire-Führungsstil.

§14 BBiG

§14 BBiG regelt die Pflichten des Ausbildenden. Dazu gehören insbesondere die planmäßige Vermittlung der beruflichen Handlungsfähigkeit, die Bereitstellung kostenloser Ausbildungsmittel, die Freistellung für Berufsschule und Prüfungen sowie der Schutz des Auszubildenden vor sittlichen und körperlichen Gefahren.

Probezeit Ausbildung

Die Probezeit in der Berufsausbildung muss mindestens einen Monat und darf höchstens vier Monate dauern. Das ergibt sich aus §20 BBiG.

Unterweisung vs. Unterricht

Unterweisung ist praxisnah und arbeitsplatzbezogen. Sie dient dem Erlernen konkreter beruflicher Handlungen. Unterricht ist stärker theoretisch und systematisch aufgebaut. Beide Formen ergänzen sich in der Ausbildung.

Vier-Stufen-Methode

Die vier Stufen der Unterweisung sind:

Vorbereiten
Vormachen und Erklären
Nachmachen lassen
Üben und Festigen
§13 BBiG

§13 BBiG regelt die Pflichten des Auszubildenden. Der Auszubildende muss sich bemühen, die berufliche Handlungsfähigkeit zu erwerben, Weisungen befolgen, an Ausbildungsmaßnahmen teilnehmen, Berichtshefte führen, Werkzeuge und Einrichtungen sorgfältig behandeln und Betriebsgeheimnisse wahren.

Ausbildungsrahmenplan

Der Ausbildungsrahmenplan ist Bestandteil der Ausbildungsordnung. Er beschreibt sachlich und zeitlich gegliedert, welche Fertigkeiten, Kenntnisse und Fähigkeiten während der Ausbildung vermittelt werden sollen.

Betrieblicher Ausbildungsplan

Der betriebliche Ausbildungsplan überträgt den Ausbildungsrahmenplan auf den konkreten Ausbildungsbetrieb. Er legt fest, wann, wo und durch wen bestimmte Ausbildungsinhalte vermittelt werden.

Kündigung während der Probezeit

Während der Probezeit kann das Berufsausbildungsverhältnis jederzeit ohne Einhalten einer Kündigungsfrist und ohne Angabe von Gründen gekündigt werden. Rechtsgrundlage ist §22 BBiG.

9. Empfehlung für shadowmaker-v7

Nicht auf v6 weitertrainieren.

Besserer Ablauf:

Sauberes Basismodell wählen
Golden-Set mit mindestens 100 perfekten AEVO-/IHK-Antworten erstellen
Daten auf Fachfehler prüfen
Fine-Tuning starten
Smoke-Test automatisch ausführen
Nur bei bestandenem Test als latest registrieren
Fehlerhafte Modelle sperren oder löschen
10. Empfohlene Modellstrategie
Default

shadowmaker-v5:latest

Schnell

qwen2.5:3b

Allgemein stark

llama3.1:8b

Reasoning

deepseek-r1:8b

Coding

qwen2.5-coder:14b

Embeddings

nomic-embed-text:latest

11. Entscheidung

v5 behalten.
v6 sperren oder löschen.
v7 nur mit Golden-Set und Pflicht-Smoke-Test bauen.

