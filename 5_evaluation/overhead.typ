#import "../layout/ba.typ": *

== Overhead

Ein weiteres wichtiges Kriterium ist der Overhead des Systems. Da der Generationsalgorithmus nicht direkt als kompilierten Programmcode ausgeführt wird, sondern als Abhängigkeitsgraph interpretiert wird, entstehen zusätzliche Kosten. Diese entstehen insbesondere durch:
- die Verwaltung und Modifikation der Graphstruktur,
- das rekursive Auflösen der Abhängigkeiten während der Berechnung.

Hierfür wurde das Beispiel #itodo("Name") in zwei weiteren Versionen implementiert. 

In der ersten würde die Generator-Graph-Verwaltungs-Logik entfernt. Hier wird der Abhängigkeits-Graph direkt evaluatiert ohne Zwischenspeicher anzulegen oder zu verwalten. 
Diese Änderunge reduziert zwar die Menge an Code signifikant jedoch hat keine großen Auswirkungen auf die Laufzeit. 
Dies hat wahrscheinlich Folgende Gründe: 
Die in Zwischenspeicher genutzten Mengen müssen bei der evaluation des Graphs eh angelegt werden und werden in diesem Fall nur wieder deallokiert anstatt weiterhin gespeichert zu bleiben.

Als zweites wurde eine Version des Generationsalgorithmus ohne Abhängigkeits-Graph direkt implementiert. 
Diese Version ist ca. $3 - 6$x schneller als das Beispiel. 
Dies hat wahrscheinlich mit dem Overhead durch die evaluation des Abhängigkeits-Graph zu tun. 
Einerseits können durch direkte Kapselung von loops die Allozierung und Erstellung von Mengen Vektoren gespart werden.  
Der Abhängigkeits-Graph benötigt durch seine Polymorphe-Natur viele Switch-Statements um zwischen den verschiedenen Funktionen die einen Wert erzeugen dynamisch zu unterschieden. Dies fällt bei einer direkten Implementierung weg. 
Dazu kann dadurch der Generationsalgorithmus könnte stärker durch den Compiler optimiert werden.

