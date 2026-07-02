# Smoke-Test Template

Stand: 2026-05-12

## Regel
Jede Frage muss in maximal 5 Sätzen prüfungssicher beantwortbar sein.

## Format
**Frage:**
**Musterantwort:**
**Rechtsanker:**
**Scoring:**
- 0 Punkte: fehlt / falsch / kein Anker
- 1 Punkt: teilweise korrekt
- 2 Punkte: korrekt, fallbezogen, prüfungssicher

---

## Pflichtbereiche

### BetrVG / Arbeitsrecht
1. Wann hat der Betriebsrat ein Mitbestimmungsrecht bei KI-Einführung?
   Musterantwort: Bei Einführung technischer Einrichtungen zur Überwachung von Verhalten oder Leistung (§87 Abs.1 Nr.6 BetrVG) ist Mitbestimmung zwingend. Betriebsvereinbarung erforderlich.
   Anker: §87 Abs.1 Nr.6 BetrVG

2. Was sind die Folgen einer fehlenden BR-Anhörung vor Kündigung?
   Musterantwort: Die Kündigung ist nach §102 BetrVG unwirksam, wenn der BR nicht oder nicht ordnungsgemäß angehört wurde.
   Anker: §102 BetrVG

### Führung & Konflikt
3. Auf welcher Stufe des Glasl-Modells empfiehlt sich externe Mediation?
   Musterantwort: Ab Stufe 4-5 (Koalitionsbildung, Gesichtsverlust) ist externe Unterstützung sinnvoll. Ab Stufe 7 ist Eingriff zwingend.
   Anker: Glasl-Eskalationsmodell

4. Was sind die vier Prinzipien des Harvard-Konzepts?
   Musterantwort: 1. Menschen und Probleme trennen. 2. Interessen statt Positionen. 3. Optionen entwickeln. 4. Neutrale Bewertungskriterien nutzen.
   Anker: Harvard-Konzept

### Projektmanagement & Controlling
5. CPI = 0.85 — was bedeutet das und was tun?
   Musterantwort: CPI < 1 bedeutet Kostenüberschreitung. Ursachenanalyse durchführen, Ressourcen priorisieren, Scope ggf. anpassen, EAC neu berechnen.
   Anker: CPI, EAC, Earned Value

### DSGVO & IT
6. Welche Schritte sind bei KI-Einführung datenschutzrechtlich zwingend?
   Musterantwort: Datenschutz-Folgenabschätzung (Art.35 DSGVO), Rechtsgrundlage nach Art.6, Transparenzpflicht nach Art.13/14, BR-Beteiligung nach §87 BetrVG.
   Anker: DSGVO Art.35, §87 BetrVG

### AEVO / Ausbildung
7. Nennen Sie die vier Stufen der Vier-Stufen-Methode.
   Musterantwort: 1. Vorbereiten. 2. Vormachen und erklären. 3. Nachmachen lassen. 4. Üben und selbstständig anwenden.
   Anker: AEVO, Vier-Stufen-Methode

### RAG / KI / Wissensmanagement
8. Was ist der Unterschied zwischen RAG und Finetuning?
   Musterantwort: RAG ergänzt ein LLM zur Laufzeit mit externem Wissen (keine Gewichtsänderung). Finetuning passt die Modellgewichte an (dauerhaft, teuer, riskant). RAG ist flexibler und aktueller.
   Anker: RAG, Finetuning

---

## §87 BetrVG Nr.6 — KI-Einführung (Artefakt 2026-05-12)

**Szenario:** Ein Unternehmen führt ein KI-gestütztes Ticketsystem mit automatischer Leistungsauswertung ein.

**Frage 1:**
Wann greift §87 Abs.1 Nr.6 BetrVG bei einem KI-System?
**Musterantwort:** §87 Abs.1 Nr.6 BetrVG greift, sobald eine technische Einrichtung geeignet ist, Verhalten oder Leistung von Arbeitnehmern zu überwachen — unabhängig vom erklärten Zweck. Das KI-Ticketsystem wertet Reaktionszeiten und Lösungsquoten aus und ist daher mitbestimmungspflichtig.
**Rechtsanker:** §87 Abs.1 Nr.6 BetrVG
**Scoring:** 2P = Geeignetheit + Zweckunabhängigkeit genannt | 1P = §87 Nr.6 genannt ohne Begründung | 0P = kein Anker

**Frage 2:**
Welche Maßnahmen muss das Unternehmen vor Inbetriebnahme ergreifen?
**Musterantwort:** 1. Datenschutz-Folgenabschätzung nach Art.35 DSGVO durchführen. 2. Betriebsrat gemäß §87 Abs.1 Nr.6 BetrVG informieren und Verhandlung aufnehmen. 3. Betriebsvereinbarung abschließen (§77 BetrVG). 4. Mitarbeiter nach Art.13 DSGVO informieren. 5. System erst nach Unterzeichnung freigeben.
**Rechtsanker:** §87 Abs.1 Nr.6 BetrVG, Art.35 DSGVO, §77 BetrVG, Art.13 DSGVO
**Scoring:** 2P = mind. 3 Schritte + 2 Rechtsanker | 1P = mind. 1 Schritt + 1 Anker | 0P = kein Anker

**Frage 3:**
Was sind die Rechtsfolgen einer Inbetriebnahme ohne BR-Zustimmung?
**Musterantwort:** Der Betriebsrat kann die sofortige Abschaltung verlangen. Verweigert das Unternehmen, entscheidet die Einigungsstelle (§76 BetrVG). Ohne Einigung ist die Maßnahme unwirksam. Der BR kann auch eine einstweilige Verfügung beim Arbeitsgericht beantragen.
**Rechtsanker:** §87 BetrVG, §76 BetrVG
**Scoring:** 2P = Unwirksamkeit + Einigungsstelle genannt | 1P = BR-Recht auf Stopp erwähnt | 0P = kein Anker

**Entscheidung im Szenario:** Alternative A (vollständiger Stopp bis Betriebsvereinbarung) ist rechtlich zwingend.
**Fehlerfallen:**
- Mitarbeiter-Einwilligung ist keine ausreichende Rechtsgrundlage (Machtgefälle → Freiwilligkeit fraglich)
- §87 gilt auch wenn Überwachung nur Nebeneffekt ist
- Ohne Betriebsvereinbarung kann der AG nicht einseitig weiterarbeiten
