# Cross-Exam-Master-System V2 — IHK Operative Professional

## 1. Themen-Matrix

| Bereich | Kernmodelle | Pflicht-Rechtsanker | KPIs |
|---|---|---|---|
| Planung SA1 | PSP, Stakeholder-Matrix, RPZ-FMEA | §92 BetrVG, DSGVO | Planungs-SLA, Budgettreue |
| Führung SA2 | Tuckman, Situatives Führen, SARAH | §106 GewO, §87 Abs.1 Nr.1 BetrVG | Fluktuationsrate, Fehlerquote |
| Konflikt SA2 | Glasl 1-9, Harvard, LEAF | §87 Abs.1 Nr.1 BetrVG | Reopen-Rate, Durchlaufzeit |
| PE / AEVO | 4-Stufen-Methode, Kirkpatrick | §§27-30 BBiG, §98 BetrVG | Schulungsquote, Transfererfolg |
| Controlling | Earned Value, CPI, SPI, MTA | §87 Abs.1 Nr.6 BetrVG | CPI, SPI, RPZ |
| Recht | Kündigungsstufen, Abmahnung | §102 BetrVG, §1 KSchG, §623 BGB | Compliance-Rate, Klagequote |

---

## 2. Smoke-Test — 30 Kernfragen

1. Nettobedarf-Formel: Brutto-Bedarf minus fortgeschriebener Bestand.
2. Fortgeschriebener Bestand: Ist-Bestand plus Zugänge minus Abgänge.
3. SPI < 1: Projekt ist im Zeitverzug.
4. CPI < 1: Projekt überschreitet das Budget.
5. RPZ: Bedeutung × Auftreten × Entdeckung.
6. SARAH: Shock, Anger, Resistance, Acceptance, Healing.
7. §87 Abs.1 Nr.6 BetrVG: Mitbestimmung bei technischen Einrichtungen mit objektiver Überwachungseignung.
8. §87 Abs.1 Nr.1 BetrVG: Mitbestimmung bei Ordnung des Betriebs und Verhalten der Arbeitnehmer.
9. §102 BetrVG: Betriebsrat ist vor jeder Kündigung anzuhören; sonst ist die Kündigung unwirksam.
10. Kirkpatrick Stufe 3: Transfer des Gelernten an den Arbeitsplatz.
11. 4-Stufen-Methode Stufe 3: Nachmachen und erklären lassen.
12. M-O-P: Ursachenanalyse nach Mensch, Organisation und Prozess.
13. Glasl Stufe 1-3: Win-Win-Bereich, interne Moderation möglich.
14. Abmahnung: Dokumentations-, Warn- und Androhungsfunktion.
15. Anforderungsprofil: Fach-, Methoden-, Sozial-, Persönlichkeits- und Führungskompetenz.
16. AGG: Diskriminierungsfreie Auswahl nach objektiven Kriterien.
17. §94 BetrVG: Beurteilungsgrundsätze benötigen Zustimmung des Betriebsrats.
18. Harvard: Mensch/Problem trennen, Interessen statt Positionen, Optionen, objektive Kriterien.
19. Tuckman: Forming, Storming, Norming, Performing, Adjourning.
20. AKV-Prinzip: Aufgabe, Kompetenz und Verantwortung müssen übereinstimmen.
21. Meilenstein: Kontrollpunkt mit eindeutigem Ergebnis.
22. Nutzwertanalyse: Bewertung mehrerer Alternativen anhand gewichteter Kriterien.
23. TCO: Total Cost of Ownership, Gesamtkosten über Nutzungsdauer.
24. Break-even: Fixkosten / Deckungsbeitrag pro Stück.
25. PDCA: Plan, Do, Check, Act.
26. Lastenheft: Was, Auftraggeber.
27. Pflichtenheft: Wie, Auftragnehmer.
28. §99 BetrVG: Zustimmung bei Einstellung, Eingruppierung, Umgruppierung und Versetzung.
29. §623 BGB: Kündigung und Aufhebungsvertrag bedürfen der Schriftform.
30. Norming-Phase: Spielregeln, Rollenklärung und Wir-Gefühl entstehen.

---

## 3. JSONL-Golden-Set V2

```jsonl
{"prompt":"Berechne den Nettopersonalbedarf: Brutto 110, Ist 100, Abgänge 5, Zugänge 2.","completion":"Fortschreibung: 100 - 5 + 2 = 97. Nettobedarf: 110 - 97 = 13. Es besteht ein Beschaffungsbedarf von 13 Mitarbeitenden."}
{"prompt":"Berechne die RPZ: Bedeutung 8, Auftreten 2, Entdeckung 4.","completion":"RPZ = 8 × 2 × 4 = 64. Der Schwellenwert ist unternehmens- oder projektspezifisch festzulegen. Bei Überschreitung sind Präventionsmaßnahmen einzuleiten."}
{"prompt":"Welche Norm regelt die Mitbestimmung bei Beurteilungsgrundsätzen?","completion":"Gemäß §94 Abs. 1 BetrVG bedürfen allgemeine Beurteilungsgrundsätze der Zustimmung des Betriebsrats."}
{"prompt":"Erkläre CPI = 0,85.","completion":"CPI = 0,85 bedeutet, dass für jeden investierten Euro nur 85 Cent Projektwert geschaffen werden. Das Projekt überschreitet das Budget."}
{"prompt":"Nenne die Schritte der vollständigen Handlung.","completion":"Informieren, Planen, Entscheiden, Ausführen, Kontrollieren, Bewerten."}
{"prompt":"Was regelt §14 BBiG?","completion":"§14 BBiG regelt die Pflichten des Ausbildenden. Der Ausbilder muss die Berufsausbildung in einer durch ihren Zweck gebotenen Form planmäßig, zeitlich und sachlich gegliedert so durchführen, dass das Ausbildungsziel in der vorgesehenen Ausbildungszeit erreicht werden kann. Er hat dem Auszubildenden die erforderlichen Ausbildungsmittel kostenlos zur Verfügung zu stellen."}
{"prompt":"Erkläre das Lewin 3-Phasen-Modell.","completion":"Das Lewin-Modell beschreibt Veränderungsprozesse in drei Phasen: 1. Unfreeze (Auftauen): Bestehende Strukturen und Gewohnheiten werden hinterfragt und aufgebrochen. Widerstände werden identifiziert. 2. Change (Verändern): Die eigentliche Veränderung wird durchgeführt. Neue Verhaltensweisen, Prozesse oder Strukturen werden eingeführt. 3. Refreeze (Einfrieren): Die neuen Zustände werden stabilisiert und als Standard verankert, z.B. durch neue Regeln, Prozessdokumente oder Führungsverhalten."}
{"prompt":"Was regelt §20 BBiG zur Probezeit?","completion":"§20 BBiG regelt die Probezeit in der Berufsausbildung. Die Probezeit beträgt mindestens einen Monat und höchstens vier Monate. Während der Probezeit kann das Berufsausbildungsverhältnis von beiden Seiten jederzeit ohne Einhaltung einer Kündigungsfrist gekündigt werden. Eine Verlängerung der Probezeit ist nur zulässig, wenn die Ausbildungszeit aufgrund von Krankheit oder anderen Fehlzeiten die Hälfte der Probezeit überschritten hat."}
{"prompt":"Berechne den SPI: Fertigstellungswert 80.000 €, Planwert 100.000 €.","completion":"SPI = EV / PV = 80.000 / 100.000 = 0,80. SPI < 1 bedeutet: Das Projekt ist im Zeitverzug. Für jeden geplanten Euro Fortschritt wurden nur 80 Cent tatsächlich erreicht."}
{"prompt":"Erkläre die Glasl-Stufen 7 bis 9.","completion":"Stufe 7 (Begrenzte Vernichtungsschläge): Verluste werden in Kauf genommen, wenn der Gegner mehr verliert. Stufe 8 (Zersplitterung): Vernichtung des Gegners als System wird angestrebt. Stufe 9 (Gemeinsam in den Abgrund): Totale Konfrontation, eigene Vernichtung wird akzeptiert. Ab Stufe 7 ist externe Mediation oder gerichtliche Intervention zwingend erforderlich."}
{"prompt":"Was besagt §1 BBiG?","completion":"§1 BBiG definiert die Berufsausbildung: Sie hat die für die Ausübung einer qualifizierten beruflichen Tätigkeit in einer sich wandelnden Arbeitswelt notwendigen beruflichen Fertigkeiten, Kenntnisse und Fähigkeiten (berufliche Handlungsfähigkeit) zu vermitteln. Sie hat ferner den Erwerb der erforderlichen Berufserfahrungen zu ermöglichen."}
{"prompt":"Was ist der Unterschied zwischen Lastenheft und Pflichtenheft?","completion":"Das Lastenheft beschreibt WAS gefordert wird und wird vom Auftraggeber erstellt. Es enthält Ziele, Anforderungen und Randbedingungen. Das Pflichtenheft beschreibt WIE die Anforderungen umgesetzt werden und wird vom Auftragnehmer erstellt. Es ist die verbindliche Antwort auf das Lastenheft und Grundlage des Vertrags."}
{"prompt":"Erkläre die Kirkpatrick-Stufe 4 (Ergebnis).","completion":"Kirkpatrick-Stufe 4 (Results/Ergebnis) misst den tatsächlichen Geschäftsnutzen der Schulung: Produktivitätssteigerung, Fehlerreduktion, Umsatzwachstum, Kostenersparnis. Diese Stufe ist am schwierigsten zu messen, da Kausalität zwischen Schulung und Unternehmensergebnis nachgewiesen werden muss. KPIs: ROI der Schulung, Fehlerquote vor/nach, Kundenzufriedenheitswert."}
{"prompt":"Was ist die 4-Stufen-Methode der Unterweisung?","completion":"Die 4-Stufen-Methode ist eine strukturierte Lernmethode: 1. Vorbereiten: Arbeitsplatz einrichten, Vorwissen aktivieren, Lernziel erklären. 2. Vormachen und erklären: Ausbilder führt die Tätigkeit vor und erklärt jeden Schritt. 3. Nachmachen und erklären lassen: Auszubildender führt aus und erläutert dabei. Fehler werden sofort korrigiert. 4. Üben und selbstständig arbeiten: Auszubildender arbeitet selbstständig, Ausbilder kontrolliert nur noch sporadisch."}
{"prompt":"Was sind die Voraussetzungen für eine wirksame Abmahnung?","completion":"Eine wirksame Abmahnung muss vier Voraussetzungen erfüllen: 1. Rügefunktion: Das beanstandete Verhalten muss konkret beschrieben sein (Datum, Uhrzeit, Vorfall). 2. Warnfunktion: Es muss klar sein, dass das Verhalten nicht toleriert wird. 3. Androhungsfunktion: Bei Wiederholung wird eine arbeitsrechtliche Konsequenz (z.B. Kündigung) angedroht. 4. Dokumentationsfunktion: Die Abmahnung muss schriftlich in die Personalakte aufgenommen werden."}
```

---

## 4. Situationsaufgabe — Projektplanung SCADA-Logik
1. Situation

Im Support soll eine 24/7-Bereitschaft eingeführt werden. Im Team entsteht Widerstand, weil Mitarbeitende Überlastung und Einschränkungen ihrer Freizeit befürchten.

2. SMART-Ziel

Bis zum 01.07. wird ein rechtssicheres Schichtmodell eingeführt, das eine SLA-Quote von mindestens 98 Prozent erreicht und die Überstundenquote unter 5 Prozent hält.

3. Stakeholder

Support-Team, Betriebsrat, Kunden, Projektleitung, Geschäftsführung, HR.

4. Ursachen M/O/P

Mensch: Angst vor Überlastung und Freizeitverlust.
Organisation: Fehlende Kapazitätsplanung und unklare Vertretung.
Prozess: Unklare Übergaben und fehlende Eskalationsregeln.

5. Alternativen

A: Überstundenmodell.
B: Schichtmodell mit externer Ergänzung.
C: Komplettes Outsourcing.

6. Bewertung W/O/M

A ist kurzfristig schnell, aber teuer und belastend.
B ist wirtschaftlich planbar, organisatorisch steuerbar und menschlich tragfähig.
C reduziert interne Belastung, birgt aber Know-how-Verlust.

7. Entscheidung

Ich entscheide mich für Alternative B, weil sie SLA-Sicherheit, Belastungssteuerung und rechtliche Umsetzbarkeit verbindet.

8. Umsetzung

Betriebsvereinbarung verhandeln, Dienstplan erstellen, externe Unterstützung definieren, Patenmodell einführen, Übergabeprozess dokumentieren.

9. Kontrolle

SLA-Quote, Fehlerquote, Überstundenquote, Krankenquote, Mitarbeiterzufriedenheit.

10. Nachhaltigkeit und Recht

Das Modell wird im Führungshandbuch dokumentiert. Bei Arbeitszeit und Überstunden ist §87 Abs.1 Nr.2/3 BetrVG zu beachten. Bei verbindlichen Verhaltensregeln ist §87 Abs.1 Nr.1 BetrVG zu prüfen.

5. Master-Module
Rechtssichere Personalauswahl
Anforderungsprofil erstellen.
AGG-konforme Kriterien definieren.
Interne Ausschreibung nach §93 BetrVG prüfen.
Auswahlverfahren mit mehreren Methoden und Beobachtern durchführen.
Zustimmung des Betriebsrats nach §99 BetrVG einholen.
Deeskalation im Projekt
SARAH-Phase erkennen.
Harvard-Konzept anwenden.
Interessen statt Positionen klären.
Objektive Kriterien nutzen.
Bei verbindlichen Verhaltensregeln §87 Abs.1 Nr.1 BetrVG prüfen.
Earned Value Dominanz
SPI prüfen.
CPI prüfen.
Abweichung bewerten.
Ursachen nach M/O/P analysieren.
Maßnahmen nach PDCA ableiten.
6. Fehlerfallen und Upgrades
Punktkiller

RPZ nur als Auswirkung × Eintrittswahrscheinlichkeit berechnen.

Upgrade

RPZ immer als Bedeutung × Auftreten × Entdeckung ausweisen.

Punktkiller

SARA statt SARAH schreiben.

Upgrade

SARAH vollständig nennen: Shock, Anger, Resistance, Acceptance, Healing.

Punktkiller

Paragrafen ohne Inhalt nennen.

Upgrade

Paragraf mit Rechtsfolge formulieren: Gemäß §102 BetrVG ist der Betriebsrat vor jeder Kündigung anzuhören; ohne Anhörung ist die Kündigung unwirksam.

Merksatz

Struktur erzwingt Punkte. Rechtsgrundlagen sichern Rechtssicherheit. KPIs belegen Erfolg.
