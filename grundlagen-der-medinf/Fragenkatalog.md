https://md.kif.rocks/FragenkatalogGrundlagen
# Fragenkatalog Grundlagen der Medizininformatik

> - Mitschrieb: Jules, Lara, Harun <3 
> - Fragenkatalog hat 8 Themen
> - ca 25. Fragen
> - Mögliche Antowrten findet ihr Unten

> Klausur:
> - 4 Fragen werden ausgewählt
> - 80 Minuten Zeit
> - Mittwoch 06.02 - 10:15 
> - selber Raum

## 1 - Med.Dokumentation
* Erläutern Sie was man in der Med.Dokumentation als Terminologische Kontrolle versteht.
* Nennen Sie 4 Wichtigste Probleme der Med. Fachsprache die eine Terminologische Kontrolle notwendig macht.
* Und Erläutern sie mögliche Maßnahmen

## 2 - ICD-10
* Erlätuern Sie inwieweit die ICD-10 alle Anforderungen an Vollständigkeit und Überschneidungsfreiheit genügt

* Vergleichen Sie das Klassifikationsystem ICD-10 mit dem Klassifikationssystems OPS hinsichtslich:
    * des Verwendungszwecks
    * des symantischen Bezugssystems
    * sowie des geografischen Verbreitungsgrads
* Erläutern Sie mit einem Satz in welchem Zusammenhang beide Systeme mit dem DRG System stehen.
----

Beim medizinischen Ordnungssystem ICD10 verwendet man in Deutschland die sog. Kreuz-Stern-Notation.
* Beschreiben Sie was man darunter versteht und begründen Sie warum diese hilfreich und Notwendig ist.

* Vergleichen Sie das vom DIMDI herausgegebene System der ICD-Alpha-ID mit dem amtlichen ICD Katalog und begründigen Sie die Vorteile des Alpha Systems

## 3 - Erlösberchnung
* Nennen Sie die Formeln nach denen im DRG (Diagnosis Related Groups) System die Erlöse aus der Krankenhausbehadlung berechnet werden.
* Erläutern Sie die Formelbestandteile
(Produkt aus x und y)
* Erklären Sie was man in diesem Zusammenhang unter einem DRG Case Mix und einem Case Mix Index versteht.

## 4 - ICD-O-3
Was unterscheidet das medizinische Ordnungssystem von ICD-O-3 von der ICD-10?
* Beschreiben Sie:
    * inhaltliche Unterschiede 
    * Unterschiede im strukturellem Aufbau
    der Ordnungssysteme.

## 5 - Recall and Precision
Recall und Precision, sind bekanntlich Maßzahlen für die Güte eines Retrievalergebnisses. (Informationsbeschaffung)
* Definieren Sie diese beiden Begriffe unter Angabe der Berechnungsformel und erläutern Sie die Formelbestandteile.
* Beschreiben Sie mit einem Satz wie sich Probleme durch Synonyme in der Medizin auf den Recall auswirken.
* Wie kann man die Recall Rate messen? Nennen Sie 3 Möglichkeiten? 

## 6 - KIS
* Nennen Sie 3 allgemeine Ziele der Informationslogistik, die für ein Krankenhausinformationssystem besonders wichtig sind.
* Erläutern Sie Diese jeweils an einem Beispiel. 
* Wofür dient die Modelliereung von KIS?
* Nennen Sie 2 wichtige Verwendungszwecke der Modellierung
* Begründen Sie diese.
----
Bei der Integration von Komponenten eines Krankenhaussystems ist es wichtig, die Problematik der Semantik Integration und der Datenintegration zu lösen.
* Erklären sie die beiden Probleme anhand jeweils eines Beispieles und nennen sie auch jeweils einen Lösungsansatz.
-----
Die Vielfalt der technischen Heterogenität der Systeme in großen Krankenhäusern (z.B.: Unikliniken) ist hoch.
* Führen Sie 2 wichtige Gründe auf, warum man sich nicht auf das homogene Informationssystem eines einzelnen Anbieters beschränkt.



## 7 - HL7
Am wichtigsten in Kommunikationssystemen ist HL7. HL7 definiert das Kommunikationssystem aus 3 verschieden Blickwinkeln.
* Trigger Events
* Abstarct Message Definiton 
* Encoding Rules
    * Beschrieben Sie jeweils in ein bis zwei Sätzen, was diese 3 bedeuten.

## 8 - Kommunikationsserver
* Beschreiben Sie die wichtigsten Aufgaben eines Kommunikationsservers in einem KIS, mit verteilter Datenhaltung 

# Mögliche Antworten
Diese Antworten sind nur exemplarisch und sind vermutlich nicht vollständig.
## Zu 1 - Terminologische Kontrolle
* Terminologische Kontrolle:
    * **Maßnahmen**, die direkt oder indirekt der Definition und Abgrenzung der Begriffe und der **Zuordnung von Benennungen und Begriffen** dienen, [nach Gauss 2005]
    * Also Maßnahmen, die genau Beschreiben wie gewissen Sachen beschrieben werden müssen
* Probleme (P) der Fachsprache die Maßnahmen (M) der Term.Kont nötig macht:
    * Synonyme (anderes Wort, gleiche Bedeutung)
        * Bsp: Wadenbeinbruch = Fibulafraktur
        * P: **Unvollständige** Suchergebnisse
        * M: **Äquivalenzklassen**
             Benennungregeln (Bsp: Nur Latein)
    * Homonyme (gleiches Wort, andere Bedeutung)
        * Bsp: OB = Ohne Befund oder Oberbauch ...
        * P: **Irrelevante** Suchergebnisse 
        * M: **Zusatzinformationen** / Hinweise
    * Hyponyme (Oberbegriffe) / Hyperonyme (Unterbegriffe)
        * Bsp: Myokardinfarkt > Hinter/Seiten/Vorderwandinfarkt
        * P: **Unvollständige** Suchergebnisse
        * M: Systematische Anordnung der Begriffe (**Hierarchie**)
## Zu 2 - ICD-10
### IDC-10 Anforderungen
* Vollständigkeit:
    * **Nahezu vollständig**, da regelmäßig aktualisiert
* Überschneidungsfreiheit:
    * Semantisches Bezugssystem **wechselt** zwischen **Ätiologie** und **Organsystem** (Probleme durch Überschneidungen!)
    * deshalb Kreuz-Stern-Notation mit Querverweisen auf in anderen Kapiteln doppelt aufgeführte Diagnosen:
        - Kreuz: Ätiologisches Bezugssystem (Ursache)
        - Stern: Organsystem-Bezug (betroffenes Organ)
---
### Vergleich ICD-10 / OPS
* Verwendungszwecks:
    * ICD-10:
      **Klassifizierung** von **Diagnosen** für eine klarere Kommunikation, Dokumentation, **Kostenabrechnung** (Gruppierung in DRG) und Statistik
    * OPS:
      Klassifizierung von **Prozeduren und Operationen** für Dokumentation, **Kostenabrechnung** (DRG), Qualitätssicherung
* semantischen Bezugssystems:
    * IDC-10:
      wechsel zwischen Ätiologie und Organsystem (Probleme durch Überschneidungen!),
    deshalb Kreuz-Stern-Notation mit Querverweisen auf in anderen Kapiteln doppelt aufgeführte Diagnosen:
    * OPS:
      Primär der Lokalisation nach
* Verbreitung:
   * ICD-10: Weltweit gültiges System. Wird von WHO herausgegeben.
   * OPS: Verbindlich für Deutsche Krankenhäusern.
* Zusammenhang zum DRG-System:
        Verwendung der OPS und ICD-10 neben Diagnosen Prozedurencodes etc. für die **Eingruppierung der Patienten in DRG-Klassen**, welche sich mit den Kosten der Behandlungen in den Krankenhäusern beschäftigt.
------
* Kreuz-Stern-Notation
    * Kreuz: **Ätiologisches** Bezugssystem (Ätiologie: Lehre von den Krankheitsursachen; Gesamtheit der ursächlichen Faktoren, die zu einer bestehenden Krankheit geführt haben)
    * Stern: **Organsystem**-Bezug
    * Hilfreich da man ggf. den Fall in höhere Komplexitätsstufe einstufen kann --> mehr GELD :dollar: :dollar:
* ICD-10-Alpha-ID
    * **Nicht** klassifizierend, da inhaltlich identische Diagnosen beliebig viele Alpha-ID-Codes haben können 
    * Unbegrenzte Zahl an Synonymen mit eigener ID-Nummer und Referenz auf den ICD-10; deshalb flexibel erweiterbar, ohne die ICD-10-Struktur zu ändern 
    * **Semantikfreier** Alpha-ID-Code: Fortlaufende Nummer ohne weitere inhaltliche Information 
    * Stabile Alpha-ID-Nummern: Eine einmal vergebene Alpha-ID bleibt für immer mit dem Eintrag verbunden, auch wenn der ICD- 10-Code sich in Folge von Strukturänderungen/Erweiterungen ändert 

---
## Zu 3 - Erlösberechnung
* G-DRG-Erlös = **Basisfallwert * Bewertungsrelation** (BR)
* Basisfallwert:
    * Landesweit einheitlicher Geldbetrag (ca 3450 €), der bei der Berechnung der DRG-Erlöse für die Krankenhausbehandlung verwendet wird. 
* Bewertungsrelation:
    *  Bundesweit gültige Kennzahl, die für jede einzelne G-DRG-Fallgruppe auf Basis einer Kostenkalkulation (erstellt durch Institut für das Entgeldsystem im Krankenhaus) festgelegt wird.
* Casemix (CM):
    * **Summe** der Bewertungsrelationen BR aller innerhalb einer Zeiteinheit abgerechneten Fälle (1 bis n): CM = BR1 + BR2 + … + BRn
* Casemix-Index (CMI):
    * Casemix geteilt durch die Zahl der abgerechneten Fälle n: CMI = CM / n  
    * **Mittlere Bewertungsrelation** als Kennzahl
---
## Zu 4 - ICD-O-3
### Inhaltliche Unterschiede:
* Schlüssel für **Onkologie** (Krebs)
* Gibt genauere Informationen über z.B. den Tumor 
### Unterschiede Aufbau:
* 2 Achsig aufgebaut
* **Topographie** ICD-10
* **Morphologie** (Histologie / Ausbreitung / Differenzierung ..)
* Bsp: C34.1 8070/33  (ICD) (ICDO3)
---
## Zu 5 - Recall and Precision
* DE = Dokumentationseinheiten
* Recall (Vollzähligkeit):
    * Verhältnis wie viele der relevanten Suchergebnisse gefunden wurden
    * Zahl der **selektierten** und relevanten DE / Zahl der **gespeicherten** und relevanten DE
    * Missing-Ratio: 1-Recall
* Precision (Relevanz):
    * Verhältnis wie viele der angezeigten Suchergebnisse relevant sind
    * Anzahl der **selektierten** und relevanten DE / Anzahl der **selektierten** DE
    * Noise: 1-Precision
* Problem der Synonyme:
    * Nicht alle relevante DE werden gefunden --> niedriger Recall
* Messung der Recall-Rate:
    * Überprüfung aller Dokumentationseinheiten in einem Dokumentenspeicher (abzählen)
    * **Stichprobe** aus dem Dokumentenspeicher, Abschätzen der Grundgesamtheit der aufzufindenden Dokumente anhand der Häufigkeit in der Stichprobe
    * Heimlich eingeschleuste Dokumente mit den Selektionsmerkmalen; hinterher Abfrage dieser Dokumente im Dokumentenspeicher 
---
## Zu 6 - KIS
### Ziele / Beispiele:
* „**Die richtigen Informationen**“ | Letzten Laborwerte von Patient X
* „**in der richtigen Form**“ | Zusammengefasst und Sortiert
* „**den richtigen Personen**“ | dem Arzt der sie braucht
* „**zum richtigen Zeitpunkt**“ | wenn der Patient im Behandlungsraum ist
* „**an den richtigen Ort**“ | Auf dem Bildschirm im Behandlungsraum

### Modelierung KIS:
* Die Auswahl von KIS-Komponenten und damit die Bewertung ihrer Brauchbarkeit für ein Krankenhaus setzt eine **vollständige** und widerspruchsfreie Beschreibung **der Anforderungen** voraus. 
* Das **Management** des KIS sowie seiner Komponenten ist auf solche **Beschreibungen** angewiesen. Management = Planung + Steuerung + Überwachung
* Systembeschreibungen sind Grundlage für das **customizing** kommerzieller Systeme (Customizing = kundenspezifische Systemanpassungen im Rahmen der durch den Hersteller vorgegebenen Möglichkeiten)
* Systembeschreibungen sind Grundlage für die softwaretechnische KIS-**Entwicklung** (z.B. Eigenentwicklungen durch das Krankenhaus, kommerzielle Entwicklungen)
---
### Semantik-Integration:
* Problem: **keine** systemübergreifend gültigen **einheitlichen** **Bezeichnungen** für dieselben Dinge, Geräte, Untersuchungsmethoden usw.
 * Bsp: Lungenübersichtsaufnahme = Thorax p.a.
 * Lösung:
    * Vereinbarung Vokabular
    * Einheitliche Codes
    * Querverweise
### Daten-Integration:
* Problem: Daten könne **nicht zugegriffen** werden
* Bsp: Daten liegen als Papierakte, im falschen Dateiformat oder auf anderen Sub-Systemen vor
* Lösung:
    * Digitalisierung der Papierakten
    * Zentrale Datenbank auf der alles gespeichert ist
    * Zentrale Datenbank mit verweisen auf Sub-Systeme
    * Kommunikationsserver der Datenstrukturen konvertieren kann
### Heterogenität:
* Kein Hersteller bietet alle gewünschten (Sub-)Systeme an
* Austausch alter Systeme wäre zu teuer (jährliches dazuschalten von neuen Systemen)
* Andere (Partner)-Krankenhäuser nutzen andere Systeme
---
## Zu 7 - HL7
* Trigger Events:
    * **Auslösende** Anwendungsereignisse
    * Was ist **Anlass** für den Nachrichtenversand
    * Welches Ereignis im KIS löst die Nachricht aus?
* Abstract Message Definition:
    *  Grundlegende **Struktur** einer Nachricht
    * Was soll die Nachricht enthalten?
    * **Wie** sind die Informationen **angeordnet**, gruppiert und gegliedert
    * wie sind die Bedeutungen geregelt?
* Encoding Rules:
    * **Darstellung** der Nachrichten **für** die **Übertragung**
    * Wie werden die Daten **technisch** dargestellt, formatiert und verpackt?
---
## Zu 8 - Kommunikationsserver
### Nachrichtenempfang
* Technische Schnittstelle zum Empfänger mit Unterstützung von Transportprotokollen, wie z.B. FTP-Protokoll oder Socket-Kommunikation
* Pufferung der eingehenden Nachricht (Achtung: Notwendig, da die Nachrichten intern meist als Warteschlange abgearbeitet werden)
* Protokollierung der eingegangenen Nachrichten zum Zweck der Nachverfolgung
* Acknowledgement (Quittung als Empfangsbestätigung) an den Absender
### Nachrichtenindentifikation
* Überprüfung der Nachrichtensyntax (formale Richtigkeit der Nachricht)
* Inhaltliche Identifizierung und Zuordnung
### Nachrichtenkonvertierung
* Passend für Subsysteme
   * Transposition (Umorganisation der Daten, neue Reihenfolge der Felder)
   * Transformationen (Umkodierung (Bsp: M --> männlich), Kappen von langen Texten...)
* Benötigt dafür Wissen über Nachrichtentypen usw...
### Nachrichtenweiterleitung
* Welcher Empfänger? Ggf. Vervielfältigung.
* Über welchen Weg? 
### Nachrichtenweiterleitung
* Puffer bis Empfängersystem bereit ist
* Protokollierung des Versands
### Fehlerbehandlung
* Überpfüfung aller 5 Schritte
* Ggf. Log-Daten mit Fehler erstellen.
![](https://i.imgur.com/ZXLkFIQ.png)
[Bild: modif. von Lautenbacher 2018 nach Heitmann 1996]
