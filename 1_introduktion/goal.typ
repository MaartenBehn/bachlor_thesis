#import "../layout/ba.typ": *

Prozedurale Generierung ist ein etabliertes Verfahren zur automatischen Erstellung komplexer virtueller Welten, das insbesondere in der Spieleentwicklung, Simulation und Computergrafik Anwendung findet.
Dabei werden zunächst grobe Strukturen erzeugt, die anschließend schrittweise durch immer feinere Details ergänzt werden. 
Wird der Generationsalgorithmus in irgendeiner Form angepasst, kann es vorkommen, dass eine bereits erzeugte Welt nicht mehr dem aktuellen Stand des Algorithmus entspricht.

Die Rechenzeit eines prozeduralen Generationsalgorithmus steigt mit der Menge der erzeugten Details. 
Insbesondere bei komplexen Algorithmen kann die vollständige Neugenerierung einer Welt sehr zeitaufwendig sein. 
Dies stellt ein Problem dar, da in der Praxis Generationsalgorithmen häufig iterativ entwickelt und angepasst werden. 
Lange Neugenerationszeiten können diesen Entwicklungsprozess erheblich verlangsamen.

Ziel dieser Arbeit ist es zu untersuchen, inwieweit sich die Neugenerationszeit einer prozeduralen Welt reduzieren lässt, 
wenn nur diejenigen Teile der Welt neu berechnet werden, die durch Änderungen am Generationsalgorithmus ungültig geworden sind.

Dazu wird ein System vorgestellt, welches einen Generationsalgorithmus als Abhängigkeitsgraph dargestellt. 
Dieses verwendet Zwischenergebnisse für diejenigen Teile des Graphen, die sich nicht geändert haben, wieder.

