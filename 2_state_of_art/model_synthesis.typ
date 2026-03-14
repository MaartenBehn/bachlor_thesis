#import "../layout/ba.typ": *

== Example based Model Synthesis 

Eine spannende Arbeit im Bereich "constraint based generation" ist Paul Merrels "Example-based Model Synthesis".
@model_synthesis

Die Idee des Algorithmus ist aus einem kleinen Input-Datensatz eine größere Struktur zu erzeugen die lokal den gleichen Regeln folgt. 

Dabei besteht der Input-Datensatz aus einer Gitter Struktur, wo jede Celle im Gitter ein Wert zu geordnet wird. 
Nun wird eine Liste aller Nachbar Kombinationen erstellt die im Input Input-Datensatz vorkommen. 
Diese Liste beschreibt die Regeln nachdem ein neues Modell erzeugt wird. 

Generations Algorithmus:
1. Dabei werden dem Gitter des neuen Modells in jeder Zelle alle Werte zugeordnet. 
2. Wähle die Zelle mit den wenigsten Werten aus und entferne alle bis auf einen. 
3. Entferne alle Werte aus den Nachbar Zellen für die eine Regel nicht mehr erfüllt ist.
4. Wiederhole 3. für jede Nachbar Zelle bei der Werte entfernt wurden. 
5. Wiederhole 2. bis alle Zellen nur noch einen Wert enthalten.

=== Minimale Neuberechnung mit Model Systhesis 

Ein möglicher Ansatz zur partiellen Neuberechnung prozedural generierter Welten könnte auf Verfahren der Example-based Model Synthesis aufbauen. Die grundlegende Idee wäre zunächst eine vollständige Welt mit dem Model-Synthesis-Algorithmus zu generieren. Wenn sich anschließend die zugrunde liegenden Regeln ändern, könnte versucht werden, nur die Teile der Welt zu verändern, die den neuen Regeln nicht mehr entsprechen.

Ein naheliegender Ansatz wäre, alle Felder zu identifizieren, deren aktuelle Werte gegen die neuen Regeln verstoßen. Für diese Felder müssten anschließend wieder mehrere mögliche Werte zugelassen werden, sodass der Model-Synthesis-Algorithmus erneut eine konsistente Lösung finden kann.

Dabei stellt sich jedoch ein grundlegendes Problem: Wenn einem Feld neue mögliche Werte hinzugefügt werden, sind diese zunächst nicht notwendigerweise mit den aktuellen Werten der Nachbarfelder kompatibel. Damit die lokalen Regeln wieder erfüllt sind, müssten auch den Nachbarfeldern zusätzliche mögliche Werte hinzugefügt werden. Dieser Prozess kann sich wiederum auf deren Nachbarn ausbreiten und so weiter.

Würde man dieses Verfahren naiv implementieren, indem für alle betroffenen Nachbarn wieder sämtliche möglichen Werte zugelassen werden, entstünde im Extremfall erneut ein vollständig unentschiedenes Gitter. In diesem Fall würde der Algorithmus effektiv wieder bei einem normalen Model-Synthesis-Prozess beginnen, wodurch kein Vorteil gegenüber einer vollständigen Neugenerierung entsteht.

Um dennoch einen Nutzen aus diesem Ansatz zu ziehen, müsste eine möglichst kleine Menge an Feldern gefunden werden, deren Wertebereiche erweitert werden, sodass anschließend wieder eine konsistente Lösung existiert. Diese Menge sollte idealerweise minimal sein, damit möglichst große Teile der bestehenden Welt unverändert bleiben können. Gleichzeitig müsste der Aufwand zur Bestimmung dieser Menge deutlich geringer sein als eine komplette Neugenerierung der Welt.

Eine theoretische Möglichkeit bestünde darin, den Raum der möglichen Werteerweiterungen systematisch zu durchsuchen. Beispielsweise könnte eine Breitensuche über den Graphen der möglichen Wertkombinationen durchgeführt werden, um eine minimale Menge an Änderungen zu finden, die wieder zu einer gültigen Konfiguration führt. Allerdings wächst dieser Suchraum sehr schnell und führt sowohl in Bezug auf Laufzeit als auch Speicherverbrauch zu erheblichen Komplexitätsproblemen.

Der Vorteil des ursprünglichen Model-Synthesis-Algorithmus liegt darin, dass zu jedem Zeitpunkt alle noch möglichen Kombinationen eine valide Lösung darstellen. Das Finden einer minimalen Erweiterung dieser Mengen, die nach einer Regeländerung wieder eine gültige Lösung ermöglicht, ist jedoch deutlich schwieriger als die ursprüngliche Generierung selbst. 

