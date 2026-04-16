
In dieser Arbeit wurde gezeigt, dass minimale Neuberechnung für prozedurale Generierung grundsätzlich möglich ist. 
Die Beispielimplementation zeigt, dass sich ein Generationsalgorithmus als Abhängigkeitsgraph darstellen lässt und Zwischenergebnisse gezielt wiederverwendet werden können. Ändert sich ein Teil des Algorithmus, müssen nur die betroffenen Knoten neu berechnet werden.

Allerdings hat dieser Ansatz einen erheblichen Nachteil. 
Da der Algorithmus als Graph interpretiert wird statt direkt als kompilierten Code ausgeführt zu werden, ist er deutlich langsamer als eine direkte Implementierung. 
In den Benchmarks war eine optimierte direkte Implementierung etwa drei bis sechs mal schneller. Dieser Overhead entsteht vor allem durch das rekursive Auflösen der Abhängigkeiten und die polymorphe Natur des Graphen.

Dazu kommt, dass der Aufwand zur Implementierung aller benötigten Operationen und Datentypen sehr groß ist. 
Für einen realen Einsatz in einem Spiel oder einer Simulation würde eine deutlich größere Menge an Operationen benötigt werden als in dieser Arbeit implementiert wurde. Das macht das gesamte System wesentlich komplexer als eine direkte Implementierung.

Alles zusammen bedeutet das dieser Ansatz nur in einem sehr spezifischen Kontext sinnvoll ist. 
Nämlich dann, wenn die Neuberechnungszeit der Welt so dominant ist, dass der Overhead des Systems und der Implementierungsaufwand sich lohnen. 
Für die meisten praktischen Anwendungsfälle ist eine direkte Implementierung wahrscheinlich die bessere Wahl.
