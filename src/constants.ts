import { DayStatus, CourseDay, UserProgress, CourseModule, Flashcard } from './types';

export const MOCK_USER_PROGRESS: UserProgress = {
  currentStreak: 12,
  learningStreakDays: 12,
  totalMinutesLearned: 420,
  completedDays: [],
  dayRatings: {},
  energyLevel: 4,
  preferredSessionLengths: [45, 90],
  lastEnergyRating: 4,
};

export const COURSE_MODULES: CourseModule[] = [
  {
    id: "ihk_a_fuehrung",
    courseId: "it_projektleiter_ihk",
    title: "A: Mitarbeiterführung & Personal",
    shortCode: "Teil A",
    description: "Personalplanung, Führung, Qualifizierung und Arbeitsrecht (§7 Rahmenplan).",
    learningGoals: [
      "Qualitativen & quantitativen Personalbedarf ermitteln",
      "Führungsmethoden & Teamdynamiken beherrschen",
      "Qualifizierungsmaßnahmen (Training on/off the job) planen",
      "Arbeitsrecht (BetrVG, KSchG, AGG) anwenden"
    ],
    dayIds: [1, 2, 3, 4],
    recommendedPracticeTypes: ["CASE", "MC"],
    estimatedMinutesTotal: 180
  },
  {
    id: "ihk_b_prozesse",
    courseId: "it_projektleiter_ihk",
    title: "B: Betriebliche IT-Prozesse",
    shortCode: "Teil B",
    description: "Prozessanalyse und die zentrale Projektdokumentation (§4/§12 Rahmenplan).",
    learningGoals: [
      "IT-Geschäftsprozesse analysieren & optimieren",
      "Projektdokumentation für die Prüfung erstellen",
      "Vorgehensmodelle begründen"
    ],
    dayIds: [5, 6],
    recommendedPracticeTypes: ["CASE", "FR"],
    estimatedMinutesTotal: 90
  },
  {
    id: "ihk_d_anbahnung",
    courseId: "it_projektleiter_ihk",
    title: "D8: Projektanbahnung",
    shortCode: "D8",
    description: "Kundenberatung, Wirtschaftlichkeit, Angebotserstellung (§13 Abs. 2 Nr. 1).",
    learningGoals: [
      "Beratungsgespräche führen & Ziele analysieren",
      "Wirtschaftlichkeit prüfen (WiBe, ROI, Amortisation)",
      "Angebote erstellen & Vertragsrecht beachten"
    ],
    dayIds: [7, 8],
    recommendedPracticeTypes: ["CASE", "FR"],
    estimatedMinutesTotal: 90
  },
  {
    id: "ihk_d_organisation",
    courseId: "it_projektleiter_ihk",
    title: "D9: Organisation & Durchführung",
    shortCode: "D9",
    description: "Planung (PSP), Steuerung, Controlling und Abschluss (§13 Abs. 2 Nr. 2).",
    learningGoals: [
      "Aufbau- & Ablauforganisation festlegen",
      "Ressourcen-, Kosten- & Terminplanung (Netzplan)",
      "Controlling, Risikomanagement & Claim Management",
      "Projektabschluss & Nachkalkulation"
    ],
    dayIds: [9, 10, 11],
    recommendedPracticeTypes: ["CASE", "MC"],
    estimatedMinutesTotal: 135
  },
  {
    id: "ihk_d_marketing",
    courseId: "it_projektleiter_ihk",
    title: "D10: Projektmarketing",
    shortCode: "D10",
    description: "Stakeholdermanagement, Präsentation und Akzeptanz (§13 Abs. 2 Nr. 3).",
    learningGoals: [
      "Stakeholder analysieren & einbinden",
      "Projekt im Umfeld des Kunden vermarkten",
      "Präsentationen durchführen & Konflikte moderieren"
    ],
    dayIds: [12, 13],
    recommendedPracticeTypes: ["CASE"],
    estimatedMinutesTotal: 90
  }
];

export const MOCK_COURSE_DAYS: CourseDay[] = [
  {
    id: 'day-1',
    dayNumber: 1,
    title: 'A: Stakeholder-Analyse & Interessen',
    description: 'Definition von Stakeholdern und Analyse ihrer Erwartungen, Ängste und Interessen im IT-Projektumfeld.',
    estimatedMinutes: 45,
    status: DayStatus.OPEN,
    tags: ["Teil A", "Führung", "Stakeholder", "Kommunikation"],
    theoryContent: "### Rollen und Interessen im Projekt\n\nIm Kontext eines IT-Projekts (z. B. Einführung eines neuen Zertifikatssystems oder VMI) ist die **Stakeholder-Analyse** essenziell. Stakeholder sind alle Personen oder Gruppen, die vom Projekt betroffen sind oder es beeinflussen können.\n\n**Wichtige Stakeholder und deren Interessen/Befürchtungen (exemplarisch aus den Quellen):**\n\n*   **Geschäftsführung/Management:** Erwartung von **Kosteneinsparungen** und **Effizienzsteigerung**. Befürchtung negativer Auswirkungen auf das operative Geschäft oder Nichtfunktionalität des Systems.\n*   **Mitarbeiter/Anwender:** Interesse, die Arbeitsfähigkeit zu behalten (z. B. durch einen neuen Token mit Zertifikaten). Angst vor Freisetzung oder **Überwachung der Leistung**.\n*   **Betriebsrat (BR):** Hauptinteresse ist die Vermeidung von Überwachung der Mitarbeiter und der Schutz personenbezogener Daten. \n*   **IT-Mitarbeiter:** Erwartung neuer Verantwortlichkeiten und Karrierechancen. Befürchtung von Überstunden und Mehrarbeit.\n*   **Neues Systemhaus/Anbieter:** Ziel ist die Kundengewinnung und Stärkung der Marktposition.\n\nZur **Projektvermarktung** müssen diese Erwartungen und Ängste adressiert werden, beispielsweise durch Machbarkeitsstudien, Präsentation der Erfolgsfaktoren oder die Integration der Mitarbeiter ins Projekt.",
    audioScript: "Willkommen zum ersten Tag deines Lernsprints! Heute tauchst du direkt in die **sozialen und organisatorischen Herausforderungen** eines IT-Projektleiters ein. Du bist nicht nur für die Technik, sondern vor allem für die Menschen verantwortlich. Konzentriere dich darauf, die **Stakeholder** – vom Mitarbeiter bis zur Geschäftsleitung – genau zu verstehen. Was erwarten sie? Was befürchten sie? Nur wenn du ihre Interessen kennst, kannst du das Projekt erfolgreich vermarkten und führen. Das Verständnis der Ängste des Betriebsrats bezüglich Überwachung oder der Sorge der Mitarbeiter um ihren Arbeitsplatz ist dabei genauso wichtig wie die technischen Spezifikationen. Dies ist der Grundstein für effektive Kommunikation und Change Management. Pack es an, und lerne, wie du alle Beteiligten ins Boot holst!",
    animationScript: "Visualisiere eine Stakeholder-Matrix (Macht/Interesse) mit den Schlüsselfiguren (Management, Mitarbeiter, Betriebsrat, Projektleiter). Hebe die Konfliktpunkte (z. B. Effizienz vs. Überwachung) hervor.",
    questions: []
  },
  {
    id: 'day-2',
    dayNumber: 2,
    title: 'A: Vertragsrecht und Haftung',
    description: 'Erklärung zentraler rechtlicher Aspekte (Gewährleistung, Haftung, Schutzrechte) bei der Beauftragung externer IT-Dienstleister.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil A", "Recht", "Vertrag", "Beschaffung"],
    theoryContent: "### Rechtliche Bestimmungen in IT-Verträgen\n\nBeim Abschluss eines Vertrages mit einem Systemhaus zur Erstellung oder Anpassung einer Lösung (z.B. ein neues Portalsystem für Zertifikatsbestellung) müssen spezifische rechtliche Aspekte beachtet werden. Diese Punkte sichern dein Unternehmen ab:\n\n*   **Gewährleistung:** Der Softwarelieferant ist verantwortlich für die **Mängelbeseitigung** von funktionsbedingten Fehlern der Software.\n*   **Haftung:** Regelungen zur Haftung für den **Ausfall der Portallösung** oder bei Lieferverzug.\n*   **Nutzungsrecht:** Klare Definition, dass die Nutzung der Software in der Regel nur für den Auftraggeber (z.B. den Energieerzeuger) zulässig ist.\n*   **Geheimhaltung:** Verpflichtung des Auftragnehmers (Systemhaus), Zertifikate oder schützenswerte Daten **Dritten nicht zugänglich** zu machen.\n*   **Schutzrechte Dritter:** Der Auftragnehmer muss sicherstellen, dass **Schutzrechte Dritter** nicht verletzt werden, oder diese auf eigene Kosten erwerben.\n*   **Vertragsänderungen:** Regelungen, die es dem Auftraggeber erlauben, Änderungen während des Projektes zu verlangen (Basis für das spätere Change Management).",
    audioScript: "Heute geht es ums Kleingedruckte: IT-Vertragsrecht. Als Projektleiter agierst du oft an der Schnittstelle zur Rechtsabteilung. Du musst die Kernbegriffe verstehen, selbst wenn du kein Jurist bist. Denke daran, wenn du ein externes Systemhaus beauftragst, muss der Vertrag mehr als nur den Preis regeln. Wer haftet bei Ausfall? Wie lange gilt die Gewährleistung für Mängel? Und ganz wichtig: Ist klar geregelt, dass die erstellte Software nur in deinem Unternehmen genutzt werden darf? Insbesondere die Punkte **Geheimhaltung** und **Schutzrechte Dritter** sind kritisch, gerade bei Projekten mit sicherheitsrelevanten Daten wie Zertifikaten. Dieses Wissen gibt dir die nötige Sicherheit und Kontrolle im Beschaffungsprozess.",
    animationScript: "Visualisiere ein digitales Dokument mit fünf markierten Abschnitten: Gewährleistung, Haftung, Nutzungsrecht, Geheimhaltung und Schutzrechte Dritter, wobei jeder Abschnitt kurz erklärt wird.",
    questions: []
  },
  {
    id: 'day-3',
    dayNumber: 3,
    title: 'A: Personalführung und -entwicklung',
    description: 'Strategien zur Personalentwicklung und Qualifizierung, insbesondere in internationalen Rollouts und bei technischen Neuerungen.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil A", "Personal", "Führung", "Schulung"],
    theoryContent: "### Schulungs- und Qualifizierungskonzepte\n\nDie Einführung neuer Systeme (VMI, Zertifikatsinfrastruktur) erfordert oft die Anpassung der Personalentwicklungspläne und umfassende Schulungen. Dies gilt besonders bei internationalen Projekten (z. B. Standorte in West- und Osteuropa).\n\n**Inhalte eines Schulungskonzeptes (unter Berücksichtigung internationaler Teilnehmer):**\n\n1.  **Art der Trainings:** Auswahl geeigneter Methoden wie **Webinare**, Inhouseseminare oder **Computer-Based-Trainings (CBTs)**, um große, geografisch verteilte Gruppen zu erreichen.\n2.  **Multiplikatoren-Konzept:** Einsatz von geschulten lokalen Mitarbeitern, die die Schulungen vor Ort durchführen können, was Skalierung und kulturelle Anpassung erleichtert.\n3.  **Zeitplan:** Realistische Planung der Trainings im Kontext des Projekt-Rollouts.\n4.  **Themen:** Festlegung der fachlichen Inhalte (z. B. operativer Umgang mit dem neuen Softwaremodul, neue Logistikprozesse).\n5.  **Ressourcen und Kosten:** Planung und Beschaffung der benötigten Ressourcen und Budgetierung.\n\n**Weiterführende Personalentwicklung:** Einführung von Personalentwicklungsplänen zur Sicherstellung der Produktqualität (Qualitätssicherungsmaßnahme).",
    audioScript: "Als IT-Projektleiter bist du ein Change-Agent. Neue Systeme sind nutzlos, wenn die Anwender sie nicht beherrschen. Deshalb ist der **Schulungsplan** dein wichtigstes Führungsinstrument. Stell dir vor, du rollst eine Lösung für 50.000 Mitarbeiter in verschiedenen Ländern aus. Kannst du alle persönlich schulen? Nein! Du musst auf skalierbare Methoden wie **Webinare** oder **CBTs** setzen und eventuell **Multiplikatoren** ausbilden, die das Wissen lokal verbreiten. Sorge dafür, dass der Nutzen für die Vertriebs- oder Lagermitarbeiter klar dargestellt wird, um die Akzeptanz zu fördern. Qualifizierung ist nicht nur eine Kostenstelle, sondern eine Investition in den Projekterfolg.",
    animationScript: "Visualisiere eine Weltkarte mit verschiedenen Standorten (Deutschland, Schweden, Ungarn, etc.). Ein Projektleiter erklärt mithilfe eines Monitors (Webinar-Symbol) die neuen Prozesse an die internationalen Standorte.",
    questions: []
  },
  {
    id: 'day-4',
    dayNumber: 4,
    title: 'A/B: IT-Architektur & Konfigurationsmanagement',
    description: 'Verständnis der Integration neuer IT-Komponenten in die bestehende Architektur und deren Dokumentation in der CMDB.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil A", "Teil B", "CMDB", "Infrastruktur"],
    theoryContent: "### Configuration Management Database (CMDB)\n\nDie **Configuration Management Database (CMDB)** dient der zentralen IT-Organisation zur Verwaltung aller Konfigurationselemente (**Configuration Items**, CIs). Neue IT-Lösungen, wie die Infrastruktur für Zertifikate und Tokens, müssen in der CMDB registriert werden.\n\n**Fünf neue Informationen in der CMDB, die das Zertifikats-/Token-System betreffen:**\n\n1.  **Art der Token und Zertifikate:** Genaue Spezifikation der Hardware und des Verschlüsselungstyps.\n2.  **Laufzeit der Zertifikate:** Wichtig für die Planung von Erneuerungsprozessen.\n3.  **Verschlüsselungstiefe:** Technische Details zur Sicherheit.\n4.  **Versionsstand der Softwarelösung:** Die Version der Standardsoftware zur Beschaffung und Verwaltung der Zertifikate.\n5.  **Verfahren/Applikationen:** Welche Anwendungen (Webinhalte, Mailverkehr) zukünftig mit dem Zertifikat verschlüsselt werden.\n\nDiese Informationen sind notwendig, um den IT-Betrieb (Service und Support) sicherzustellen und zukünftige Änderungen (Changes) und Kapazitätsplanungen korrekt durchzuführen.",
    audioScript: "Infrastruktur ist das Rückgrat deines Projekts. Aber was passiert nach dem Rollout? Dann übernimmt der IT-Betrieb, und dafür braucht er eine saubere Dokumentation. Hier kommt die **CMDB** ins Spiel. Sie ist wie das Inventarverzeichnis der IT. Du musst sicherstellen, dass alle neuen Komponenten – der Zertifikatsserver, die Token-Art, die Software-Version – dort exakt erfasst werden. Denk daran: **Configuration Management** ist essenziell für einen reibungslosen Support und die Einhaltung von Sicherheitsstandards. Wenn du weißt, welche Zertifikate wie lange gültig sind, vermeidest du Pannen in der Zukunft. Verknüpfe die technische Dokumentation direkt mit deinem OLA-Konzept.",
    animationScript: "Visualisiere eine schematische Datenbank (CMDB), aus der Datenkarten (Laufzeit, Version, Verschlüsselung) für IT-Security-Sticks herausgezogen werden.",
    questions: []
  },
  {
    id: 'day-5',
    dayNumber: 5,
    title: 'B: Prozessanalyse & VMI-Konzept',
    description: 'Analyse ineffizienter Logistikprozesse im ERP-System und das Konzept des Vendor Managed Inventory (VMI).',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil B", "Prozesse", "VMI", "Analyse"],
    theoryContent: "### Schwachstellenanalyse und VMI (Vendor Managed Inventory)\n\nWenn Logistikprozesse als veraltet und ineffizient bewertet werden, ist eine **Schwachstellenanalyse** notwendig. Am Beispiel der Bado AG zeigten sich Missstände wie überhöhte Lagerbestände und inakzeptable Verweildauern, was zu kostenintensivem Lagerbestand führte. Das alte ERP-System war nicht in der Lage, Lagerkennziffern zu ermitteln, um automatische Bestellungen zu generieren.\n\n**Sieben mögliche Schwachstellen in Logistikprozessen/ERP-Systemen:**\n\n1.  **Hohe Lagerkosten** aufgrund überhöhter Bestände.\n2.  **Fehlende Reaktionsschnelligkeit** auf Bedarfsschwankungen.\n3.  **Keine Lagerkennziffernauswertung** möglich.\n4.  **Keine zeitaktuelle zentrale Bestandsführung**.\n5.  Auftreten von **Nichtlieferbarkeit** (Out of Stock).\n6.  Inkompatible **Schnittstellen** zwischen Systemen.\n7.  Manuelle Prozesse zur Feststellung des Bedarfs (z. B. Außendienstmitarbeiter reisen zur Tochtergesellschaft).\n\n**Lösung: Vendor Managed Inventory (VMI):** Hierbei erfolgt die Steuerung der Logistikprozesse **einzig und allein durch den Lieferanten** (Supplier), nicht durch den Kunden. Das Warenwirtschaftssystem soll zukünftig automatisch Bestands- und Verkaufszahlen ermitteln und eine automatische Disposition durchführen.",
    audioScript: "Prozesse sind der Herzschlag jedes Unternehmens. Im Projektmanagement musst du verstehen, wie diese Prozesse ablaufen – und wo sie brechen. Konzentriere dich auf die **Schwachstellenanalyse**. Warum sind die Lagerbestände zu hoch? Weil das ERP-System keine **Lagerkennziffern** liefert! Die Lösung ist oft eine Prozessinnovation, wie das **VMI-Konzept** – die lieferantengesteuerte Bestandsverwaltung. Das bedeutet einen tiefgreifenden **Change** in der Verantwortung. Du musst die Anforderungen an das neue System definieren, damit es diese automatische Steuerung leisten kann.",
    animationScript: "Visualisiere zwei Lagerhallen. Die erste ist überfüllt (hohe Kosten). Die zweite wird von einem zentralen Dashboard (VMI-System) gesteuert, wobei Bestände automatisch angezeigt und Lieferungen ausgelöst werden.",
    questions: []
  },
  {
    id: 'day-6',
    dayNumber: 6,
    title: 'B: Anforderungen und Lastenheft',
    description: 'Erstellung eines Lastenheftes zur Systembeschaffung und Definition von funktionalen und nicht-funktionalen Anforderungen.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil B", "Dokumentation", "Lastenheft", "Anforderungen"],
    theoryContent: "### Aufbau und Inhalt des Lastenheftes\n\nDas **Lastenheft** definiert die Gesamtheit der Anforderungen aus Sicht des Auftraggebers und ist die Grundlage für die Ausschreibung zur Beauftragung eines geeigneten Systemhauses.\n\n**Fünf fachliche Inhalte des Lastenheftes:**\n\n1.  **Beschreibung der Ausgangssituation:** Detaillierte Darstellung des Problems (z.B. altes Systemhaus wechselt in die USA; veraltete Logistik).\n2.  **Zielsetzung:** Klar definierte Ziele der neuen Lösung (z.B. neue Lösung für Zertifikatsbestellung; Kostensenkung Logistikprozesse).\n3.  **Funktionale Anforderungen:** Was das System *leisten* muss (z.B. Bestellfunktion, automatisierte Disposition, Berechtigungskonzept).\n4.  **Nicht-funktionale Anforderungen:** Qualitative Merkmale (z.B. Lizenzvereinbarungen, Verfügbarkeit, Bedienerfreundlichkeit, Kompatibilität zur bestehenden Hard- und Softwarearchitektur).\n5.  **Rahmenbedingungen:** Fristen und Termine für die Umsetzung.\n\n**Sechs Anforderungen an das neue Logistiksystem (VMI):**\n\n*   **Automatisierter Datenabgleich** zwischen den Systemen.\n*   Möglichkeit zum ausführlichen **Reporting und Controlling**.\n*   **Kompatibilität** zu bestehender IT-Architektur.\n*   **Einbindung mobiler Geräte**.\n*   Automatische Ermittlung von **Bestands- und Verkaufszahlen** pro Produkt.\n*   Automatischer **Datenimport und -export** zwischen Alt- und Neusystem.",
    audioScript: "Das **Lastenheft** ist deine wichtigste Kommunikationsbrücke zum potenziellen Systemhaus. Es definiert *WAS* erreicht werden soll, nicht *WIE*. Du musst präzise beschreiben, welche funktionalen und nicht-funktionalen Anforderungen die neue Software erfüllen muss. Stell dir vor, du kaufst ein neues Logistikmodul: Du musst nicht nur fordern, dass es 'automatische Bestellungen' generiert (funktional), sondern auch, dass es 'intuitiv bedienbar' ist und '24/7 verfügbar' sein soll (nicht-funktional). Je klarer die Anforderungen im Lastenheft sind, desto besser wird der Ausschreibungsprozess und das Ergebnis.",
    animationScript: "Visualisiere ein Lastenheft als Fundament, auf dem ein IT-System aufgebaut wird, mit Beschriftungen für 'Ziele', 'Funktionen' und 'Rahmenbedingungen'.",
    questions: []
  },
  {
    id: 'day-7',
    dayNumber: 7,
    title: 'D8: Projektanbahnung & Projektauftrag',
    description: 'Erstellung des Projektauftrages und die strukturierte Vorbereitung der Entscheidung zur Systemauswahl (Nutzwertanalyse).',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Anbahnung", "Projektauftrag", "Auswahl"],
    theoryContent: "### Der Projektauftrag und die Auswahl des Dienstleisters\n\nZum Abschluss der Projektinitiierung wird der **Projektauftrag** erstellt. Er ist die formelle Freigabe und enthält die wichtigsten Rahmenbedingungen und Eckpunkte des Vorhabens.\n\n**Fünf wesentliche Aspekte des Projektauftrages:**\n\n1.  **Projektziele:** Klare Definition, was erreicht werden soll (z. B. Einführung VMI-Pilotprojekt in 12 Monaten, Kostensenkung).\n2.  **Budget:** Die finanziellen Mittel, die für die Realisierung bereitstehen.\n3.  **Termine:** Wesentliche Ecktermine und Fristen (z. B. Projektstart, geplantes Ende).\n4.  **Verantwortlichkeiten:** Benennung des Projektleiters und des Auftraggebers.\n5.  **Projektrisiken:** Erste Identifikation potenzieller Risiken.\n\n**Vorbereitung der Anbieterentscheidung:** Die **Nutzwertanalyse** ist ein Verfahren zur objektiven Bewertung verschiedener Angebote (von Systemhäusern) anhand vordefinierter Kriterien.\n\n**Fünf Kriterien der Nutzwertanalyse:**\n\n*   **Referenzen** des Anbieters.\n*   **Zertifizierung** des Systemhauses.\n*   **Angebotspreis** (Beschaffungs- und Folgekosten).\n*   **Verfügbarkeit** des Systemhauses (z. B. 24/7 Support).\n*   **Kompatibilität** und Schnittstellen zur bestehenden Architektur.\n\nDie Gewichtung dieser Kriterien kann mithilfe des **paarweisen Vergleiches** ermittelt werden.",
    audioScript: "Der **Projektauftrag** ist dein Mandat – die offizielle Erlaubnis, loszulegen. Er muss kurz, prägnant und von der Geschäftsleitung abgesegnet sein. Er bindet die wichtigsten Parameter: Budget, Zeit und die Hauptziele. Danach kommt die Phase der Anbieterwahl. Du hast mehrere Angebote? Dann nutze die **Nutzwertanalyse**. Das ist kein Bauchgefühl, sondern ein strukturiertes Verfahren, um objektive Kriterien wie Preis, Referenzen und Support-Verfügbarkeit zu gewichten. Wichtig ist dabei der **paarweise Vergleich**, um die relative Bedeutung jedes Kriteriums festzulegen.",
    animationScript: "Visualisiere den Projektauftrag als eine Startflagge. Anschließend zeige eine Waage, die die Kriterien der Nutzwertanalyse (z. B. Preis vs. Qualität) gewichtet.",
    questions: []
  },
  {
    id: 'day-8',
    dayNumber: 8,
    title: 'D9: Projektstrukturplan (PSP) und Meilensteine',
    description: 'Strukturierung des Projektes in Phasen, Teilprojekte und Arbeitspakete sowie die Definition von Meilensteinen.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Organisation", "Struktur", "Meilensteine"],
    theoryContent: "### Projektstruktur und Zeitliche Planung\n\nEine überschaubare Projektplanung erfordert die hierarchische Gliederung in **Teilprojekte** und **Arbeitspakete**.\n\n**Fünf Projektphasen (exemplarisch für VMI-System):**\n\n1.  **Planung:** Definition von Zielerreichungsgrößen, Analyse der Stakeholder.\n2.  **Analyse:** IST-Analyse der Geschäftsprozesse, Definition der Anforderungen.\n3.  **Konzeptentwicklung:** Sollkonzept und Migrationskonzept entwickeln.\n4.  **Piloteinführung/Implementierung:** Anpassung der Software, Datenmigration, Rollout.\n5.  **Abschluss:** Erfolgskontrolle, Projektnachkalkulation.\n\n**Vier mögliche Teilprojekte:** Angebotsanalyse, **Implementierung** des Logistikmoduls, Schulung der Anwender, **Anforderungsanalyse**.\n\n**Meilensteine:** Sie sind markante, wichtige Ereignisse im Projekt, die entweder einen Start oder ein Ende markieren.\n\n**Fünf weitere Meilensteine (neben Start und Ende):**\n\n*   **Lastenheft** erstellt.\n*   Auswertung der Angebote abgeschlossen (Systemhaus ausgewählt).\n*   Analyse der Logistikprozesse abgeschlossen.\n*   Neue Softwarelösung **implementiert** (Inbetriebnahme).\n*   System **getestet** und abgenommen / Rollout abgeschlossen.",
    audioScript: "Dein Projekt ist zu groß, um es in einem Stück zu planen. Du zerlegst es mit dem **Projektstrukturplan (PSP)** in **Phasen**, **Teilprojekte** und dann in steuerbare **Arbeitspakete**. Wenn du beispielsweise das Teilprojekt 'Schulung' definierst, sind die Arbeitspakete: Schulungsbedarf ermitteln, Ressourcen planen, Unterlagen erstellen und evaluieren. Gleichzeitig setzt du **Meilensteine** – das sind deine Wegpunkte. Sie sind binär (erreicht oder nicht erreicht) und signalisieren den Erfolg oder Misserfolg wichtiger Zwischenergebnisse. Saubere Strukturierung ist der Schlüssel zur Kontrolle.",
    animationScript: "Visualisiere ein hierarchisches Baumdiagramm (PSP), das sich von der Hauptaufgabe in Teilprojekte und schließlich in kleine 'Arbeitspakete' aufteilt. Blinke die Meilensteine im Zeitstrahl auf.",
    questions: []
  },
  {
    id: 'day-9',
    dayNumber: 9,
    title: 'D9: Projektrisikomanagement',
    description: 'Identifizierung, Bewertung und Planung von Gegenmaßnahmen für typische Projektrisiken.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Risiko", "Controlling", "Ishikawa"],
    theoryContent: "### Risikomanagement – Identifikation und Steuerung\n\nIm Verlauf eines Projektes können unterschiedliche Risiken auftreten. Ein aktives **Risikomanagement** identifiziert diese und plant entsprechende **Gegenmaßnahmen**. Zur Risikoidentifikation kann das **Ishikawa-Diagramm** (Ursache-Wirkungs-Diagramm) verwendet werden.\n\n**Fünf Risiken und passende Gegenmaßnahmen (exemplarisch):**\n\n| Risiko (Quelle) | Gegenmaßnahme (Quelle) |\n| :--- | :--- |\n| **Insolvenz** des Systemhauses | **Regelmäßige Berichterstattung** und finanzielle Überprüfung des Anbieters. |\n| **Mitarbeiterverfügbarkeit** (Fehlzeiten) | **Geprüfte Personaleinsatzplanung** und Redundanzen im Team. |\n| **Nichteinhalten der Termine** | **Verdichtung der Controllingmaßnahmen** und engere Überwachung des kritischen Pfades. |\n| **IT-Schnittstellen** sind nicht kompatibel | **Qualitätssicherungsmaßnahmen** (QS) der Istanalyse durch externe Berater. |\n| **Übersteigen der Projektkosten** | **Verkürzung der Controllingzyklen** und Frühwarnsysteme. |\n\nWeitere Risiken umfassen die **Akzeptanz des Endproduktes** (Gegenmaßnahme: Informationsoffensive) und das Fehlen von Vorerfahrungen bei der Aufwandsschätzung.",
    audioScript: "Risiken lauern überall. Ein guter Projektleiter reagiert nicht nur, er antizipiert. Du musst die potenziellen Stolpersteine – von der **Insolvenz** deines Systemlieferanten bis zu **Schnittstellenproblemen** – proaktiv identifizieren. Wende Methoden wie das Ishikawa-Diagramm an, um die Ursachen zu analysieren. Der Schlüssel liegt in der Planung von **Gegenmaßnahmen**. Wird das Projekt teurer? Dann verkürze deine **Controllingzyklen**. Drohen Terminverzögerungen? Dann verstärke die Überwachung der Meilensteine. Präventives Risikomanagement spart dir später viel Stress und Geld.",
    animationScript: "Visualisiere eine Risikoliste, bei der rote Risikosymbole durch grüne Schutzschilde (Gegenmaßnahmen) ersetzt werden. Zeige kurz ein Ishikawa-Diagramm mit Ursachenzweigen.",
    questions: []
  },
  {
    id: 'day-10',
    dayNumber: 10,
    title: 'D9: Earned Value Management (EVM)',
    description: 'Berechnung und Interpretation der wichtigsten Earned Value Kennzahlen (CPI, SPI, EAC) zur Messung von Zeit und Kosten.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Controlling", "EVM", "Kosten"],
    theoryContent: "### Kennzahlen des Earned Value Management (EVM)\n\nEVM ist ein wichtiges Instrument zur integrierten Messung von Zeit, Kosten und Leistung eines Projektes. Es basiert auf den Werten:\n\n*   **PV (Planned Value):** Geplante Kosten der bis zum Stichtag zu erledigenden Arbeit.\n*   **AC (Actual Cost):** Tatsächlich angefallene Kosten bis zum Stichtag.\n*   **EV (Earned Value):** Wert der tatsächlich geleisteten Arbeit (Budget der fertiggestellten Arbeitspakete).\n*   **BAC (Budget at Completion):** Gesamtkostenbudget des Projekts.\n\n**Vier zentrale Kennzahlen und deren Interpretation (Formeln basierend auf Quelle):**\n\n| Kennzahl (Formel) | Interpretation | Beispiel (CPI = 0,69) |\n| :--- | :--- | :--- |\n| **Kosteneffizienz (CPI)** = EV / AC | **CPI < 1.0**: Projekt ist **zu teuer** (Kostenüberschreitung). | Nur 69 Cent Wert für jeden ausgegebenen Euro. |\n| **Zeiteffizienz (SPI)** = EV / PV | **SPI < 1.0**: Projekt ist **in Verzug** (Terminabweichung). | Projektfortschritt liegt bei 82 % des Geplanten. |\n| **Kostenabweichung (CV)** = EV – AC | Negativer Wert zeigt Kostenüberschreitung an. | CV = -400.000 €: Projekt ist um 400.000 € über Budget. |\n| **Terminabweichung (SV)** = EV – PV | Negativer Wert zeigt Zeitverzug an. | SV = -200.000 €: Projekt ist 200.000 € im Verzug. |\n\n**Prognose für das Projektende:** Die voraussichtlichen Gesamtkosten (**EAC**) und die voraussichtliche Gesamtdauer (**ETAC**) werden auf Basis der aktuellen Effizienz (CPI/SPI) geschätzt. Wenn das Projekt z. B. 12 Monate dauern sollte, aber der SPI nur 0,82 beträgt, wird die ETAC bei 14,6 Monaten liegen.",
    audioScript: "Als IT-Projektleiter ist das **Earned Value Management** dein mächtigstes Controlling-Werkzeug. Es erlaubt dir, in jedem Moment zu wissen: 'Bin ich zu teuer? Bin ich zu langsam?' Merke dir: **CPI** (Kosten) und **SPI** (Zeit) müssen größer als 1 sein, um im grünen Bereich zu liegen. Wenn dein CPI bei 0,69 liegt, verbrennst du Geld! Diese Kennzahlen ermöglichen dir auch eine präzise **Prognose** der Gesamtkosten (**EAC**) und der Gesamtprojektdauer (**ETAC**). Mit diesem Wissen kannst du fundierte Entscheidungen treffen, um das Ruder herumzureißen.",
    animationScript: "Visualisiere ein Diagramm, das PV, AC und EV über die Zeit darstellt (S-Kurve). Hebe die Bereiche hervor, in denen AC über EV liegt (Kostenüberschreitung) und PV über EV (Zeitverzug).",
    questions: []
  },
  {
    id: 'day-11',
    dayNumber: 11,
    title: 'D9: Change Request & Qualitätssicherung',
    description: 'Etablierung eines formalen Change Request Prozesses und Entwicklung von Maßnahmen zur kontinuierlichen Qualitätssicherung.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Change", "Qualität", "Prozesse"],
    theoryContent: "### Der Change Request (CR) Prozess\n\nWenn sich Anforderungen während des Projektes ändern (z.B. Austausch eines Zertifikatsservers aufgrund inakzeptabler Antwortzeiten), muss ein formalisierter **Change Request Prozess** durchlaufen werden.\n\n**Ablauf des CR-Prozesses (vereinfacht):**\n\n1.  **Start/Antrag:** Ein Change Request wird eingereicht.\n2.  **Relevanz prüfen:** Feststellung, ob der CR berechtigt und notwendig ist.\n3.  **Kalkulation:** Berechnung der Auswirkungen auf Kosten, Zeit und Ressourcen.\n4.  **Wirtschaftlichkeit prüfen/Genehmigung:** Entscheidung über Annahme oder Ablehnung des CR.\n5.  **Planung/Durchführung:** Bei Genehmigung Anpassung der Projektplanung und Umsetzung des Changes (z.B. Verfassen eines Lastenheftes für den neuen Server, Angebotseinholung, Beschaffung).\n6.  **Erfolg prüfen/Abschluss:** Überprüfung der erfolgreichen Implementierung.\n\n### Qualitätssichernde Maßnahmen\n\nDie Qualität der Projektergebnisse muss kontinuierlich überwacht und sichergestellt werden.\n\n**Fünf Qualitätssicherungsmaßnahmen:**\n\n*   **Einführung von standardisierten Softwaretestverfahren** zur Überprüfung der korrekten Funktion.\n*   **Auditierung** des Rollout-Teams und der Vorgehensweisen.\n*   **Risikocontrolling** (kontinuierliche Neubewertung von Risiken).\n*   Planung und Evaluierung **neuer Logistikprozesse**.\n*   Verwendung **standardisierter Vorgehensweisen** beim Rollout.",
    audioScript: "Änderungen sind in IT-Projekten unvermeidlich, aber sie dürfen nicht chaotisch sein. Der **Change Request Prozess** ist dein Filter. Jede Änderung muss formell beantragt, auf Auswirkungen kalkuliert und genehmigt werden, bevor du sie umsetzt. Das schützt dich vor Budget- und Terminüberschreitungen. Parallel dazu musst du die **Qualität** der Ergebnisse sichern. Das erreichst du durch standardisierte **Testverfahren**, die du im **Qualitätsplan** festlegst, und durch kontinuierliches **Risikocontrolling**. Qualität ist kein Zufall, sondern das Ergebnis disziplinierter Prozesse.",
    animationScript: "Visualisiere den CR-Prozess als einen Trichter, durch den nur genehmigte Änderungen (mit Kosten- und Zeitanpassung) hindurchkommen.",
    questions: []
  },
  {
    id: 'day-12',
    dayNumber: 12,
    title: 'D9/B: Operational Level Agreement (OLA) & Support',
    description: 'Vorbereitung eines OLA zur Sicherstellung des internen Services und Konzeption eines Service Desks für den Rollout.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Support", "OLA", "ITIL"],
    theoryContent: "### Service und Support (OLA)\n\nFür eine erfolgreiche Piloteinführung und den späteren Betrieb des Systems muss **Service und Support** bereitgestellt werden. Dies kann oft nicht durch Projektressourcen allein sichergestellt werden, weshalb die Unterstützung interner Abteilungen (z. B. zentrale IT) durch ein **Operational Level Agreement (OLA)** abgesichert wird.\n\n**Fünf Elemente eines OLA:**\n\n1.  **Leistungsgegenstand:** Genaue Formulierung der zu erbringenden Leistung (z. B. Unterstützung bei Störungen des VMI-Systems).\n2.  **Ort und Zeiträume der Leistungserbringung:** Festlegung der Verfügbarkeit (z. B. 24/7 Support in den jeweiligen Ländern).\n3.  **Mitwirkungspflichten der Partner:** Was die Projektseite bzw. die unterstützende IT-Abteilung leisten muss.\n4.  **Definition der organisatorischen Schnittstellen:** Klare Regelungen, wer wann als Ansprechpartner fungiert.\n5.  **Verantwortlichkeiten:** Zuordnung der Zuständigkeiten für definierte Aufgaben.\n\n**Konzept für den Servicedesk (Rollout):** Um einen erfolgreichen Rollout zu gewährleisten, muss ein Servicedesk eingerichtet werden, der die Anwender bei Problemen unterstützt. Inhalte hierfür sind die **Auswahl regionaler Helpdesk-Mitarbeiter**, deren **Schulung** (Qualifizierung), der Aufbau der **technischen Infrastruktur** und die Definition von **Standards und Prozessen** (z. B. zur Fehlerbehebung).",
    audioScript: "Dein Pilotprojekt ist nur dann ein Erfolg, wenn der Betrieb danach reibungslos läuft. Du brauchst einen stabilen Support. Da die Projektressourcen endlich sind, sicherst du die Unterstützung der zentralen IT durch das **Operational Level Agreement (OLA)** ab. Das OLA ist im Grunde ein Vertrag zwischen internen Abteilungen. Es definiert, wer wann und wo unterstützt. Gleichzeitig musst du für den Rollout einen **Servicedesk** konzipieren – inklusive der Auswahl, Schulung regionaler Mitarbeiter und der technischen Aufbauarbeit. Ein solides OLA ist die Garantie für eine hohe Verfügbarkeit der Lösung.",
    animationScript: "Visualisiere zwei Hände (Projektteam und IT-Abteilung), die sich über einem Dokument (OLA) die Hand geben. Im Hintergrund läuft ein Helpdesk-System.",
    questions: []
  },
  {
    id: 'day-13',
    dayNumber: 13,
    title: 'D10: Projektmarketing & Abschluss',
    description: 'Erstellung eines Projektmarketingplans und die Durchführung der formalen Abnahme und des Projektabschlusses.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil D", "Marketing", "Abnahme", "Abschluss"],
    theoryContent: "### Projektmarketing und Projektabnahme\n\nUm die Akzeptanz und den Erfolg des Projektes intern zu sichern, ist ein **Projektmarketingplan** notwendig.\n\n**Fünf Inhalte eines Projektmarketingplanes:**\n\n1.  **Ziele:** Darstellen der Notwendigkeit und des strategischen Nutzens.\n2.  **Inhalte (Botschaft):** Was vermittelt werden soll (z. B. Darstellung der Einsparpotenziale, Nutzen für Logistik/Vertrieb).\n3.  **Zielgruppen:** Adressierung der richtigen Gruppen (Führungskräfte, Fachabteilungen, Anwender).\n4.  **Instrumente/Medien:** Einsatz von Projektpräsentationen, internen Rundschreiben oder Kundenumfragen.\n5.  **Terminplan:** Wann die Kommunikationsmaßnahmen erfolgen (vor Start, Kick-off, am Ende).\n\n### Projektabschluss\n\nDer Projektabschluss beinhaltet die formelle **Abnahme** und das Lernen für die Zukunft (**Lessons Learned**).\n\n**Fünf Elemente des Abnahmeprozesses:**\n\n*   **Verfahrensabgleich** mit dem Pflichtenheft.\n*   Bereitstellung der **Testszenarien und -dokumentation**.\n*   Vorbereitung von **Checklisten** zur Durchführung der Abnahme.\n*   Behandlung von Fehlern und Mängeln.\n*   **Fristenregelung** für die Abnahme.\n\n**Fünf Inhalte des Projektabschlusses (Workshop/Präsentation):**\n\n1.  **Ergebnisse der Evaluationsphase** (z. B. Entwicklung der Lagerbestände/Kostensituation).\n2.  **Nachkalkulation** des Projektes.\n3.  **Erkenntnisse für Folgeprojekte** (**Lessons Learned**), z. B. dass die ursprüngliche Zeitplanung nicht ausreichend war.\n4.  Abschluss der **Dokumentation** und Archivierung der Unterlagen.\n5.  **Freigabe** des Abschlussberichtes und Vorbereitung der Übergabe an den Auftraggeber.",
    audioScript: "Heute schließt sich der Kreis, vom Start bis zur Ziellinie. Bevor du feierst, musst du den Projekterfolg kommunizieren – das ist das Ziel deines **Projektmarketingplans**. Präsentiere der Geschäftsleitung die **Einsparpotenziale** und sorge für positive interne Publicity. Der formale Akt ist die **Abnahme**, bei der du anhand von Checklisten prüfst, ob die Lösung die Anforderungen des Pflichtenhefts erfüllt. Am Ende des Projekts sind die **Lessons Learned** Gold wert: Dokumentiere, was gut lief und wo die Zeitplanung unterschritten wurde, um bei Folgeprojekten (z. B. Rollout in andere Tochtergesellschaften) die Fehler zu vermeiden.",
    animationScript: "Visualisiere eine Projektmarketing-Kampagne (Plakate, Intranet-Banner). Zeige dann eine Unterschrift auf einem Abnahmeformular, gefolgt von einem 'Lessons Learned' Notizbuch.",
    questions: []
  },
  {
    id: 'day-14',
    dayNumber: 14,
    title: 'Generalwiederholung: Der IT-Projektleiter Zyklus',
    description: 'Zusammenfassung und Wiederholung der Kernkompetenzen von Planung, Controlling, Prozessanalyse und rechtlichen Rahmenbedingungen.',
    estimatedMinutes: 45,
    status: DayStatus.LOCKED,
    tags: ["Teil A", "Teil B", "Teil D", "Generalwiederholung"],
    theoryContent: "### Kompakte Zusammenfassung der Kernkompetenzen\n\nDer **Geprüfte IT-Projektleiter** benötigt umfassende Kenntnisse in drei Handlungsbereichen:\n\n*   **Teil A (Führung & Personal):** Fokus auf die Interaktion mit Stakeholdern, insbesondere dem Betriebsrat, und die Einhaltung rechtlicher Rahmenbedingungen in Verträgen (Gewährleistung, Haftung, Geheimhaltung). Die Entwicklung von Qualifizierungskonzepten für internationale Teams ist essenziell.\n*   **Teil B (IT-Prozesse):** Beinhaltet die Analyse ineffizienter Geschäftsprozesse (z. B. Veraltetes ERP-Logistikmodul) und die Definition von Anforderungen im **Lastenheft**. Die Verwaltung der IT-Assets erfolgt über die **CMDB**.\n*   **Teil D (Profilspezifische Aufgaben):** Umfasst den gesamten Projektzyklus:\n    *   **Anbahnung:** Projektauftrag, Nutzwertanalyse und paarweiser Vergleich.\n    *   **Organisation/Durchführung:** PSP, Meilensteine, Risikomanagement (Ishikawa, Gegenmaßnahmen) und Qualitätssicherung.\n    *   **Controlling:** Nutzung von **EVM** zur integrierten Messung von Zeit und Kosten (CPI, SPI, EAC). \n    *   **Service:** Sicherstellung des Betriebs durch **OLA** und Servicedesk-Konzept.\n    *   **Abschluss/Marketing:** Interne Projektvermarktung und formelle Abnahme (Testszenarien, Lessons Learned).\n\nDiese Kenntnisse sind notwendig, um sowohl komplexe logistische Herausforderungen (VMI) als auch sicherheitsrelevante Infrastrukturprojekte (Zertifikatsvergabe) zu leiten.",
    audioScript: "Glückwunsch! Du hast den Lernsprint erfolgreich absolviert. Sieh diesen Tag als deinen persönlichen Audit. Wir haben alle wesentlichen Phasen eines Projekts abgedeckt: von der formalen Genehmigung im **Projektauftrag** über das eiserne Controlling mit **EVM** bis hin zur rechtlichen Absicherung durch **Gewährleistungs- und Haftungsregeln**. Jetzt geht es darum, diese Methoden zu verinnerlichen. Ein IT-Projektleiter muss gleichzeitig Fachexperte, Jurist und Motivator sein. Wenn du diese 13 Tage verstanden hast, bist du optimal auf die Komplexität der IHK-Prüfungen vorbereitet. Konzentriere dich nun auf deine Schwachstellen und starte die Generalprobe!",
    animationScript: "Visualisiere eine Zeitleiste, die den vollständigen Projektzyklus (Initiierung, Planung, Durchführung, Abschluss) darstellt und dabei die Logos CPI/SPI, Lastenheft, OLA und Lessons Learned integriert.",
    questions: []
  }
];

export const MOCK_FLASHCARDS: Flashcard[] = [
  {
    id: "card-1",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_anbahnung",
    topic: "Projektauftrag",
    type: "definition",
    difficulty: "core",
    front: "Nennen Sie fünf wesentliche Aspekte eines Projektauftrages.",
    back: "Fünf wesentliche Aspekte des Projektauftrages sind: Projektziele, Budget, Termine/Zeitplan, Projektrisiken und die Definition der Verantwortlichkeiten (z. B. Projektleitung, Auftraggeber).",
    tags: ["Anbahnung", "Dokumentation"]
  },
  {
    id: "card-2",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_controlling",
    topic: "Earned Value Management (EVM)",
    type: "definition",
    difficulty: "core",
    front: "Definieren Sie den Cost Performance Index (CPI) und seine Interpretation.",
    back: "Der CPI ist der **Kosteneffizienz-Index** und wird berechnet als **EV / AC** (Earned Value / Actual Cost). Ist der **CPI < 1.0**, liegt eine **Kostenüberschreitung** vor; das Projekt ist zu teuer.",
    tags: ["Controlling", "EVM", "Kennzahlen"]
  },
  {
    id: "card-3",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_controlling",
    topic: "Earned Value Management (EVM)",
    type: "definition",
    difficulty: "core",
    front: "Definieren Sie den Schedule Performance Index (SPI) und seine Interpretation.",
    back: "Der SPI ist der **Zeiteffizienz-Index** und wird berechnet als **EV / PV** (Earned Value / Planned Value). Ist der **SPI < 1.0**, liegt ein **Zeitverzug** vor; das Projekt ist zu langsam.",
    tags: ["Controlling", "EVM", "Kennzahlen"]
  },
  {
    id: "card-4",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_anbahnung",
    topic: "Anbieterauswahl",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie vier Kriterien, die in einer Nutzwertanalyse zur Auswahl eines Systemhauses herangezogen werden können.",
    back: "Vier Kriterien sind: **Referenzen**, **Zertifizierung** des Systemhauses, der **Angebotspreis** (Beschaffungs- und Folgekosten) und die **Kompatibilität** zur bestehenden Architektur oder die Verfügbarkeit des Supports (24/7).",
    tags: ["Anbahnung", "Ausschreibung"]
  },
  {
    id: "card-5",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Risikomanagement",
    type: "case",
    difficulty: "core",
    front: "Welches Risiko im Projekt kann durch 'Verdichtung der Controllingmaßnahmen' reduziert werden?",
    back: "Das Risiko des **Nichteinhaltens der Termine der Meilensteine** oder der generelle Zeitverzug kann durch die Verdichtung der Controllingmaßnahmen verringert werden.",
    tags: ["Risiko", "Controlling"]
  },
  {
    id: "card-6",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_abschluss",
    topic: "Projektabnahme",
    type: "definition",
    difficulty: "detail",
    front: "Erläutern Sie drei Elemente des Abnahmeprozesses einer neuen IT-Infrastruktur.",
    back: "Drei Elemente des Abnahmeprozesses sind: Der **Verfahrensabgleich** aus dem Pflichtenheft, die Bereitstellung der **Testszenarien und -dokumentation** und die Fristenregelung (z.B. für die Behandlung von Mängeln und Fehlern).",
    tags: ["Abschluss", "Qualität"]
  },
  {
    id: "card-7",
    courseId: "it_projektleiter_ihk",
    moduleId: "teila_recht",
    topic: "Vertragsrecht",
    type: "definition",
    difficulty: "core",
    front: "Was umfasst die Gewährleistung in einem Vertrag mit einem Softwarelieferanten für eine Portallösung?",
    back: "Die Gewährleistung beinhaltet die Verantwortung des Softwarelieferanten für die **Mängelbeseitigung von funktionsbedingten Fehlern** der Software.",
    tags: ["Recht", "Vertrag"]
  },
  {
    id: "card-8",
    courseId: "it_projektleiter_ihk",
    moduleId: "teila_recht",
    topic: "Vertragsrecht",
    type: "definition",
    difficulty: "detail",
    front: "Welche Vorkehrung schützt den Auftraggeber hinsichtlich 'Schutzrechte Dritter' in einem IT-Vertrag?",
    back: "Der Auftragnehmer (Systemhaus) verpflichtet sich, **Schutzrechte Dritter nicht zu verletzen** bzw. sich diese auf seine Kosten zu beschaffen, um den Auftraggeber vor rechtlichen Konsequenzen zu schützen.",
    tags: ["Recht", "Vertrag"]
  },
  {
    id: "card-9",
    courseId: "it_projektleiter_ihk",
    moduleId: "teilb_prozesse",
    topic: "Logistikprozesse",
    type: "definition",
    difficulty: "core",
    front: "Definieren Sie 'Vendor Managed Inventory' (VMI).",
    back: "VMI ist eine **lieferantengesteuerte Bestandsverwaltung**. Die Steuerung der Logistikprozesse erfolgt einzig und allein durch den Lieferanten und nicht durch den Kunden oder Abnehmer.",
    tags: ["Prozesse", "VMI"]
  },
  {
    id: "card-10",
    courseId: "it_projektleiter_ihk",
    moduleId: "teilb_prozesse",
    topic: "Schwachstellenanalyse",
    type: "compare",
    difficulty: "detail",
    front: "Nennen Sie drei typische Schwachstellen, die bei der Analyse eines veralteten ERP-Logistikmoduls auftreten können.",
    back: "Drei Schwachstellen sind: Keine **Lagerkennziffernauswertung** möglich, das Auftreten von **überhöhten Lagerbeständen** / inakzeptablen Verweildauern (resultierend in hohen Kosten) und **inkompatible Schnittstellen**.",
    tags: ["Prozesse", "Analyse"]
  },
  {
    id: "card-11",
    courseId: "it_projektleiter_ihk",
    moduleId: "teilb_dokumentation",
    topic: "Lastenheft",
    type: "definition",
    difficulty: "core",
    front: "Was ist der Unterschied zwischen funktionalen und nicht-funktionalen Anforderungen im Lastenheft?",
    back: "Die **funktionalen Anforderungen** beschreiben, was das System **leisten** soll (z. B. Bestellfunktion, automatische Disposition). Die **nicht-funktionalen Anforderungen** beschreiben die **qualitativen** Merkmale (z. B. Verfügbarkeit, Bedienerfreundlichkeit, Lizenzvereinbarungen).",
    tags: ["Lastenheft", "Anforderungen"]
  },
  {
    id: "card-12",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Operational Level Agreement (OLA)",
    type: "definition",
    difficulty: "core",
    front: "Was ist ein OLA und wofür wird es im Projektkontext benötigt?",
    back: "Ein **Operational Level Agreement (OLA)** ist ein **interner Absicherungsvertrag** zwischen der Projektleitung und der zentralen IT-Abteilung. Es wird benötigt, um die Bereitstellung von Service und Support für das neue System zu garantieren, da dies oft nicht mit reinen Projektressourcen sichergestellt werden kann.",
    tags: ["OLA", "Support", "Service"]
  },
  {
    id: "card-13",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "OLA",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie drei Elemente, die in einem OLA inhaltlich vorbereitet werden müssen.",
    back: "Drei Elemente sind: Genaue Formulierung des **Leistungsgegenstandes**, **Ort und Zeiträume** der Leistungserbringung und die Definition der **organisatorischen Schnittstellen** oder Mitwirkungspflichten der Partner.",
    tags: ["OLA", "Support"]
  },
  {
    id: "card-14",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Projektstrukturierung",
    type: "definition",
    difficulty: "core",
    front: "Nennen Sie vier mögliche Teilprojekte bei der Einführung eines IT-Systems.",
    back: "Vier mögliche Teilprojekte sind: **Anforderungsanalyse**, **Angebotsanalyse** (Auswahl), **Implementierung** des neuen Moduls und **Schulung der Anwender** (Qualifizierung).",
    tags: ["PSP", "Organisation"]
  },
  {
    id: "card-15",
    courseId: "it_projektleiter_ihk",
    moduleId: "teila_personal",
    topic: "Mitarbeiterführung",
    type: "definition",
    difficulty: "detail",
    front: "Welche Befürchtung des Betriebsrates muss bei der Einführung neuer IT-Lösungen (z.B. Zertifikatssystem) beachtet werden?",
    back: "Der Betriebsrat (BR) befürchtet die **Überwachung der Mitarbeiter** sowie den mangelnden **Schutz personenbezogener Daten** durch die neue Lösung.",
    tags: ["Personal", "Betriebsrat"]
  },
  {
    id: "card-16",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Qualitätssicherung",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie drei qualitätssichernde Maßnahmen im Projektverlauf.",
    back: "Drei Maßnahmen sind: **Einführung von standardisierten Softwaretestverfahren**, **Risikocontrolling** (kontinuierliche Neubewertung von Risiken) und die **Auditierung** der neuen Prozesse oder des Rollout-Teams.",
    tags: ["Qualität", "Controlling"]
  },
  {
    id: "card-17",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_controlling",
    topic: "EVM Prognose",
    type: "definition",
    difficulty: "challenge",
    front: "Wie werden die erwarteten Gesamtkosten am Projektende (EAC) berechnet, wenn angenommen wird, dass die aktuelle Kosteneffizienz (CPI) bestehen bleibt?",
    back: "EAC = **BAC / CPI** (Budget at Completion / Cost Performance Index).",
    tags: ["Controlling", "EVM", "Prognose"]
  },
  {
    id: "card-18",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_controlling",
    topic: "EVM Prognose",
    type: "definition",
    difficulty: "challenge",
    front: "Wie wird die voraussichtliche Gesamtdauer des Projektes (ETAC) berechnet, wenn die aktuelle Zeiteffizienz (SPI) bestehen bleibt?",
    back: "ETAC = **Geplante Dauer / SPI** (Schedule Performance Index).",
    tags: ["Controlling", "EVM", "Prognose"]
  },
  {
    id: "card-19",
    courseId: "it_projektleiter_ihk",
    moduleId: "teilb_dokumentation",
    topic: "CMDB",
    type: "definition",
    difficulty: "core",
    front: "Welche zwei Informationen bezüglich eines neuen Zertifikats- und Token-Systems müssen in der Configuration Management Database (CMDB) registriert werden?",
    back: "Die **Laufzeit der Zertifikate** und die **Art der Token und Zertifikate** müssen in der CMDB aufgenommen werden.",
    tags: ["CMDB", "ITIL"]
  },
  {
    id: "card-20",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_marketing",
    topic: "Projektmarketing",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie drei Aspekte, die in einem Kommunikationskonzept zur internen Vermarktung eines Projektes beschrieben werden.",
    back: "Drei Aspekte sind: Die **Ziele** (Notwendigkeit, strategisch), die **Inhalte** (die Botschaft, z. B. Einsparpotenziale) und die **Instrumente** (Medien wie Rundschreiben oder Präsentationen).",
    tags: ["Marketing", "Kommunikation"]
  },
  {
    id: "card-21",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Change Management",
    type: "definition",
    difficulty: "core",
    front: "Was sind die ersten drei Schritte in einem Change Request Prozess?",
    back: "Die ersten Schritte sind: 1. Einreichung des **Change Requests (CR) / Start**, 2. **Berechtigung** des Antragstellers prüfen (falls relevant) und 3. **Relevanz des Changes prüfen**.",
    tags: ["Change", "Prozesse"]
  },
  {
    id: "card-22",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_marketing",
    topic: "Stakeholder",
    type: "case",
    difficulty: "detail",
    front: "Welche Erwartungen hat das 'neue Systemhaus' als Stakeholder an das Projekt?",
    back: "Das neue Systemhaus erwartet **Kundengewinnung** und die **Stärkung seiner Marktposition**.",
    tags: ["Stakeholder", "Anbahnung"]
  },
  {
    id: "card-23",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_abschluss",
    topic: "Projektabschluss",
    type: "definition",
    difficulty: "core",
    front: "Nennen Sie drei notwendige Inhalte eines Projektabschluss-Workshops oder einer Abschluss-Präsentation.",
    back: "Drei Inhalte sind: Die **Nachkalkulation** des Projektes, die **Erkenntnisse für Folgeprojekte** (**Lessons Learned**) und die **Archivierung der Projektunterlagen** (oder die Freigabe des Abschlussberichts).",
    tags: ["Abschluss", "Lessons Learned"]
  },
  {
    id: "card-24",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_organisation",
    topic: "Meilensteine",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie drei wichtige Meilensteine in der Planungs- und Ausschreibungsphase eines IT-Projekts.",
    back: "Drei Meilensteine sind: Das **Lastenheft ist erstellt**, die **Analyse der Prozesse ist abgeschlossen** und die **Auswertung der Angebote** ist abgeschlossen.",
    tags: ["Meilensteine", "Planung"]
  },
  {
    id: "card-25",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Qualifizierung",
    type: "definition",
    difficulty: "detail",
    front: "Welche Art von Training eignet sich besonders gut für die Schulung von ca. 50.000 internationalen Mitarbeitern?",
    back: "Aufgrund der hohen Anzahl und internationalen Verteilung eignen sich skalierbare Methoden wie **Webinare** oder **Computer-Based-Trainings (CBTs)**, oft unterstützt durch ein Multiplikatoren-Konzept.",
    tags: ["Schulung", "Personal"]
  },
  {
    id: "card-26",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_organisation",
    topic: "PSP",
    type: "compare",
    difficulty: "core",
    front: "Was ist der Unterschied zwischen einem Teilprojekt und einem Arbeitspaket?",
    back: "Ein **Teilprojekt** ist eine logische Gliederungsebene (z. B. 'Schulung der Anwender'). Ein **Arbeitspaket** ist die unterste, nicht weiter unterteilbare Einheit, die zur Erfüllung des Teilprojekts notwendig ist (z. B. 'Schulungsunterlagen erstellen').",
    tags: ["PSP", "Organisation"]
  },
  {
    id: "card-27",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_abschluss",
    topic: "Evaluierung",
    type: "definition",
    difficulty: "challenge",
    front: "Nennen Sie zwei Erkenntnisse, die durch eine dreimonatige Evaluationsphase nach der Piloteinführung eines VMI-Systems gewonnen werden können.",
    back: "Es können die **Entwicklung der Lagerbestände** (Verweildauern, Umschlagshäufigkeiten) und die **Entwicklung der Kostensituation** (Einsparungen vs. Betriebskosten) objektiv beurteilt werden.",
    tags: ["Abschluss", "Controlling"]
  },
  {
    id: "card-28",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_risiko",
    topic: "Risikomanagement",
    type: "definition",
    difficulty: "detail",
    front: "Welche Methode zur Risikoidentifikation basiert auf der Zerlegung eines Problems in Kategorien wie Mensch, Maschine, Methode?",
    back: "Das **Ishikawa-Diagramm** (oder Ursache-Wirkungs-Diagramm).",
    tags: ["Risiko", "Analyse"]
  },
  {
    id: "card-29",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_durchfuehrung",
    topic: "Support",
    type: "definition",
    difficulty: "detail",
    front: "Nennen Sie zwei Inhalte für das Konzept zur Einrichtung eines Servicedesks für einen internationalen Rollout.",
    back: "Die **Auswahl regionaler Helpdesk-Mitarbeiter** (Qualifizierung) und der **Aufbau der technischen Infrastruktur** (z. B. Datenbanken zur Erfassung von Service-Calls).",
    tags: ["Support", "Service"]
  },
  {
    id: "card-30",
    courseId: "it_projektleiter_ihk",
    moduleId: "teild_marketing",
    topic: "Stakeholder",
    type: "case",
    difficulty: "detail",
    front: "Welche Befürchtung äußern Vertriebsmitarbeiter der Zentrale beim Übergang zum VMI-System (lieferantengesteuerte Bestandsverwaltung)?",
    back: "Sie befürchten den Wegfall von Auslandsdienstreisen, eine Reduzierung der Provision oder die Freisetzung, da sie nicht mehr zur Feststellung des Bedarfs zu den Tochtergesellschaften reisen müssen.",
    tags: ["Stakeholder", "Marketing"]
  }
];
