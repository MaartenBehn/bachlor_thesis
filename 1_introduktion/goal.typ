#import "../layout/ba.typ": *

Prozedurale Welten werden mit Algorithmen generiert. 
Dabei werden werden erst grobe Eigenschaften generiert und diese dann mit immer feiner werdenden Details ausgeschmückt.
Wenn der Generations Algorithmus in irgendeiner form angepasst wird kann es sein das eine vorher generierte Welt nicht mehr dem 
aktuellen Algorithmus entspricht.
Die Rechenzeit eines prozeduralen Algorithmus steigt mit der Menge an Details die generiert wird.
Bei komplexen Algorithmen die viele Details generieren, 
kann die lange Neugenerationszeit einer Welt beim iterativen entwickeln von generations Algorithmen stören. 

== Ziel der Arbeit <goal>

Ziel dieser Arbeit ist zu erforschen in wie weit die Neugenerationszeit einer prozeduralen Welt verschnellert werden kann, 
wenn nur die Aspekte der Welt neugeneriert werden die nicht mehr den neuen Algorithmus entspricht.
Dazu habe ich ein System entwickelt in welchem der generations Algorithmus als Abhängigkeits-Graph dargestellt wird. 
Bei einer Neugeneration können zwischen Ergebnisse für Abschnitte des Abhängigkeits-Graph, welche sich nicht veränder haben wiederverwendet werden.  



