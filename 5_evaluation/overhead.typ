
== Overhead

Ein weiteres wichtiges Kriterium ist der Overhead des Systems. Da der Generationsalgorithmus nicht direkt als kompilierten Programmcode ausgeführt wird, sondern als Abhängigkeitsgraph interpretiert wird, entstehen zusätzliche Kosten. Diese entstehen insbesondere durch:
- die Verwaltung und Modifikation der Graphstruktur,
- das rekursive Auflösen der Abhängigkeiten während der Berechnung.

Ein klassischer, direkt implementierter Generationsalgorithmus könnte stärker durch den Compiler optimiert werden und benötigt keine zusätzliche Graphstruktur. Daher ist es wichtig zu testen, welchen Anteil der Laufzeit durch zusätzlichen Overhead verursacht wird. 
Den Laufzeit Anteil der Gartenstruktur lässt sich grob mit einem profiler messen. Hierfür wurde der Linux profiler perf genutzt. 

Den Overhead der Graphstruktur wurde gemessen indem eine Beispiel welt ohne Nutzung des Systems nach implementiert wurde.


