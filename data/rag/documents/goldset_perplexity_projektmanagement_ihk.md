# Goldset Perplexity Projektmanagement Ihk

## Was ist der Unterschied zwischen CPI und SPI im Earned-Value-Management? Erkläre mit Formel und Beispiel.

### Unterschied zwischen CPI und SPI im Earned-Value-Management (EVM)

**CPI (Cost Performance Index)**: Misst die **Kosteneffizienz** (wie viel Wert pro eingesetztem Euro entsteht).  
**Formel**: CPI = EV / AC  
- EV = Earned Value (geplanter Wert der erbrachten Leistung)  
- AC = Actual Cost (tatsächliche Kosten)  
**Interpretation**:  
- CPI > 1: Unter Budget (effizient)  
- CPI = 1: Im Budget  
- CPI < 1: Über Budget (ineffizient)

**SPI (Schedule Performance Index)**: Misst die **Termineffizienz** (Fortschritt im Verhältnis zum Zeitplan).  
**Formel**: SPI = EV / PV  
- PV = Planned Value (geplanter Wert zum Stichtag)  
**Interpretation**:  
- SPI > 1: Voraus (vor Zeitplan)  
- SPI = 1: Im Zeitplan  
- SPI < 1: Verzug (hinter Zeitplan)

| Kennzahl | Formel    | Zweck              | >1          | =1       | <1             |
|----------|-----------|--------------------|-------------|----------|----------------|
| **CPI**  | EV / AC  | Kosteneffizienz   | Unter Budget| Im Budget| Über Budget   |
| **SPI**  | EV / PV  | Termineffizienz   | Voraus     | Im Plan  | Verzug        |

**Beispiel** (Projektbudget BAC = 100.000 €, nach 6 Monaten):  
- PV = 60.000 € (geplant bis Stichtag)  
- EV = 40.000 € (erbrachte Leistung)  
- AC = 50.000 € (tatsächliche Kosten)  

**Berechnung**:  
- CPI = 40.000 / 50.000 = **0,8** → Über Budget (ineffizient)  
- SPI = 40.000 / 60.000 = **0,67** → Hinter Zeitplan (Verzug)  

**Relevanz für IHK-Prüfung**: CPI und SPI sind Kernkennzahlen der EVM nach PMI/PMBOK; dienen als Früherkennungsindikatoren für Projektcontrolling (z. B. IT-Projekte).

## Was sind die 5 Phasen des Projektmanagements nach PMBOK? Erkläre jede Phase kurz.

### Die 5 Phasen des Projektmanagements nach PMBOK (Project Management Body of Knowledge, 7. Edition)

Der PMBOK-Leitfaden des PMI gliedert den Projektlebenszyklus in **5 Prozessgruppen** (nicht streng sequentielle Phasen, da Prozesse iterativ ablaufen können):

1. **Initiierung**  
   Charakterisierung des Projekts, Erstellung des Projektcharters, Identifikation von Stakeholdern und Genehmigung des Projekts.

2. **Planung**  
   Detaillierte Entwicklung des Projektmanagementplans (Scope, Zeitplan, Kosten, Qualität, Ressourcen, Risiken, Beschaffungen, Kommunikation).

3. **Ausführung**  
   Umsetzung des Plans durch Zuweisung von Ressourcen, Durchführung von Arbeiten, Management des Projektteams und Stakeholderkommunikation.

4. **Überwachung und Steuerung**  
   Kontinuierliche Überprüfung des Fortschritts, Messung der Leistung, Identifikation von Abweichungen und Umsetzung korrigierender Maßnahmen.

5. **Abschluss**  
   Finale Übergabe der Lieferergebnisse, Freigabe von Ressourcen, Dokumentation von Lessons Learned und formeller Projektabschluss.

## Was ist ein Projektstrukturplan (PSP) und wie wird er erstellt?

### Definition Projektstrukturplan (PSP)

Der **Projektstrukturplan (PSP)**, engl. **Work Breakdown Structure (WBS)**, ist eine **grafische, hierarchische Darstellung** aller Aufgaben eines Projekts. Er zerlegt das Gesamtprojekt in **plan- und kontrollierbare Elemente** wie **Teilprojekte**, **Teilaufgaben** und **Arbeitspakete** (kleinste ausführbare Einheiten). 

**Kernmerkmale** (IHK-relevant):
- **Ergebnisorientiert**: Fokus auf **WAS** zu tun ist (nicht WANN oder in welcher Reihenfolge).
- **Hierarchische Baumstruktur**: Vom Gesamtprojekt (Ebene 1) zu Arbeitspaketen (letzte Ebene).
- **Zwecke**:
  - Grundlage für Termin-, Ressourcen-, Kosten- und Risikoplanung.
  - Steigerung der Transparenz und Kommunikation (Stakeholder, Team).
  - Vollständige Erfassung aller Projektleistungen.

**Darstellung**: Baumdiagramm, Organigramm oder Liste.

### Erstellung des PSP (Top-Down-Ansatz, 6 Schritte)

1. **Projekt benennen**: Gesamtprojekt als oberste Ebene definieren (Projektziel klar fassen).
2. **Orientierungsmethode wählen**: Zweite Ebene nach Phasen (z. B. Planung, Umsetzung), Funktionen (z. B. Entwicklung, Test), Produkten oder Verantwortlichkeiten gliedern.
3. **In Teilprojekte zerlegen**: Gesamtprojekt in 3–7 Hauptteile (Teilprojekte/Teilaufgaben) aufteilen.
4. **Weiter zerlegen**: Jede Ebene rekursiv in kleinere Einheiten bis zu **Arbeitspaketen** (ca. 8–80 Std. Aufwand, messbare Ergebnisse, 1 Verantwortlicher).
5. **Vollständigkeit prüfen**: Alle Arbeitspakete decken 100 % des Projekts ab (keine Lücken/Überlappungen).
6. **Dokumentieren**: Verantwortliche, Kosten, Meilensteine ergänzen; als Basis für Netzplan/Gantt-Diagramm nutzen.

**Prüfungstipp**: PSP ist **Pflicht** in IHK-Projektmanagement (z. B. Fachinformatiker); typische Fehler: Zeitliche Abfolge einbauen oder unvollständige Zerlegung.

## Erkläre das magische Dreieck im Projektmanagement: Zeit, Kosten, Qualität.

# Das Magische Dreieck im Projektmanagement

## Definition
Das Magische Dreieck ist ein Modell des Projektmanagements, das die drei zentralen Erfolgsfaktoren eines Projekts darstellt:
- **Zeit** (Termineinhaltung)
- **Kosten** (Budget/Ressourcen)
- **Qualität/Leistung** (Umfang, Funktionalität, Standards)

## Kernprinzip: Zielkonkurrenz
Die drei Faktoren stehen in **gegenseitiger Abhängigkeit** zueinander. Das Wort „magisch" verdeutlicht, dass es **selten möglich ist, alle drei Faktoren gleichzeitig zu optimieren**.

### Wechselwirkungen:
| Änderung | Auswirkung |
|----------|-----------|
| Qualität erhöhen | → mehr Zeit ODER höhere Kosten erforderlich |
| Zeit verkürzen | → höhere Kosten ODER Qualitätsverlust |
| Kosten senken | → längere Dauer ODER reduzierte Qualität |

## Praktische Anwendung

**Planung:** Die drei Dimensionen werden in der Projektplanungsphase festgelegt (Projektleiter, Sponsor).

**Steuerung & Controlling:** Kontinuierliche Überwachung von Abweichungen ermöglicht frühzeitige Korrektionen.

**Zielkonflikt-Management:** Änderungen an einem Faktor erfordern Ausgleichsmaßnahmen bei den anderen, um die Qualität zu sichern.

## Prüfungsrelevanz
Das Magische Dreieck ist essentiell für IT-Projektmanagement-Fragen in IHK-Prüfungen (Projektplanung, Ressourcenmanagement, Risikomanagement).

## Was ist der Unterschied zwischen einem Gantt-Chart und einem Netzplan?

### Unterschiede zwischen Gantt-Diagramm und Netzplan

#### **Darstellung**
| Merkmal          | Gantt-Diagramm                  | Netzplan                       |
|------------------|---------------------------------|--------------------------------|
| **Grafikform**  | Balkendiagramm (tabellarisch)  | Netzwerkdiagramm (Knoten/Pfeile)|
| **Vertikale Achse** | Aufgabenliste (eine pro Zeile) | -                              |
| **Horizontale Achse** | Zeitachse (Tage/Wochen)       | -                              |
| **Aktivitäten** | Balken (Länge = Dauer, Dreiecke für Start/Ende) | Vierecke                      |
| **Abhängigkeiten** | Pfeile/Linien zwischen Balken (zeitbezogen) | Pfeile/Linien zwischen Vierecken (logisch/fachlich) |
| **Meilensteine**| Raute (Spitze auf Zeitpunkt)  | Gekipptes Viereck/Raute       |

#### **Fokus und Zweck**
| Merkmal          | Gantt-Diagramm                  | Netzplan                       |
|------------------|---------------------------------|--------------------------------|
| **Primärer Fokus** | Zeitlicher Ablauf, Fortschritt, Überwachung | Logische/fachliche Abhängigkeiten, Reihenfolge |
| **Kritischer Pfad** | Schwierig direkt erkennbar    | Einfach identifizierbar/analysierbar |
| **Zeitkomponente** | Explizit (Balkenlänge = Dauer) | Implizit (keine feste Skala)  |
| **Komplexität** | Einfach zu erstellen/verstehen, intuitiv | Aufwändiger, für komplexe Projekte |

#### **Vorteile/Nachteile (prüfungsrelevant)**
- **Gantt-Diagramm**: 
  - Vorteile: Klare Zeitvisualisierung, Fortschrittskontrolle, Vergleich mehrerer Projekte, geringer Aufwand.
  - Nachteile: Abhängigkeiten nur zeitbezogen, kritischer Pfad schwer erkennbar.
- **Netzplan**: 
  - Vorteile: Präzise Abhängigkeitsanalyse, Optimierung (z. B. kritischer Pfad), Projektstruktur.
  - Nachteile: Keine direkte Zeitdarstellung, höherer Erstellungsaufwand.

#### **Verwendung**
- **Gantt**: Tägliche Planung/Überwachung (z. B. Softwareentwicklung, Events).
- **Netzplan**: Komplexe Projekte mit Abhängigkeiten (z. B. Bau, IT-Großprojekte).
- **Umwandlung**: Netzplan → Gantt möglich (Abhängigkeiten an Zeitachse ausrichten).

**Prüfungstipp**: Merken: *Netzplan = Logik (Vierecke + Pfeile), Gantt = Zeit (Balken + Achsen)*. Quellen: Braintool, TimO, Wikipedia.

## Was bedeutet SARAH im Change-Management-Kontext für Ausbilder?

### SARAH im Change-Management-Kontext für Ausbilder

**Keine standardisierte Abkürzung "SARAH" in IHK-relevanten Rahmenplänen für IT-Fachberufe oder Change Management identifiziert.**

#### Analyse der Suchergebnisse:
- **Relevante Personen**: 
  - Prof. Dr. Sarah Hatfield (Hochschule Augsburg): Expertin für Change Management, Organisationsentwicklung, Personal Management. Fokus: Mensch in Transformation, Aufbrechen von Verhaltensmustern (Quelle [1]).
  - Sarah Paßfeld (XING-Profil): Change-Managerin, Begleiterin in HR-Transformation, Teamentwicklung (Quelle [4]).
  - Sarah Desai: Coachin für Transformation (Quelle [6]).
- **Themenbezug zu Ausbildern**:
  - Change Management als Schlüsselkompetenz für Ausbilder (z. B. Ausbilderschein, Team-Training, Mediatorin; Quellen [3], [5]).
  - Ausbildungen betonen systemische Ansätze, Gestalt-Methoden, agile Tools (Design Thinking, Scrum) zur Veränderungsbegleitung (Quelle [2]).
- **Kein Akronym**: SARAH steht **nicht** für ein Modell wie Kotter 8-Schritte oder ADKAR. Mögliche Fehlinterpretation als Personenname (z. B. Hatfield als Referenzexpertin).

#### Prüfungsrelevanz (IHK IT-Fachkräfte, z. B. Fachinformatiker):
- **Change Management** gehört zu **Wirtschafts- und Sozialkunde** (Rahmenplan 2020): Förderung von Veränderungen, Widerstandsmanagement, Mitarbeiterbeteiligung.
- **Für Ausbilder**: AdA-Seminar "Ausbildereignung" (IHK) integriert Change-Management-Elemente (Motivation, Teamentwicklung; § 24a BBiG). Kein "SARAH"-Modell.
- **Empfehlung**: Nutzen Sie etablierte Modelle:
  | Modell | Beschreibung | Relevanz für Ausbilder |
  |--------|--------------|------------------------|
  | **ADKAR** | Awareness, Desire, Knowledge, Ability, Reinforcement | Veränderung schrittweise umsetzen, Azubis motivieren. |
  | **Kotter** | 8 Schritte (z. B. Dringlichkeit schaffen) | Azubi-Transformation in digitalen Prozessen. |
  | **Lewin** | Unfreeze-Change-Refreeze | Verhaltensänderung bei IT-Projekten. |

**Fazit**: SARAH = **kein Fachbegriff**. Vermutlich Personenbezug (z. B. Hatfield). In Prüfungen: Fokussieren Sie auf Mensch-zentrierte Ansätze (Verhaltensänderung, Agilität). Quellen: IHK-Rahmenpläne, BBiG.
