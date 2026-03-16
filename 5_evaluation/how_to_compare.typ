
Die Bewertung eines Systems zur prozeduralen Generierung ist nicht trivial, da unterschiedliche Systeme häufig unterschiedliche Ziele verfolgen. Während einige Ansätze primär auf maximale Generationsgeschwindigkeit oder realistische Ergebnisse optimiert sind, liegt der Fokus dieser Arbeit auf der effizienten Neuberechnung nach Änderungen am Generationsalgorithmus. Ziel ist es, bei kleinen Änderungen am Generationsprozess möglichst große Teile der bereits berechneten Welt wiederverwenden zu können.

Um die Reduktion der Neuberechnungszeit zu bewerten wird untersucht, wie stark sich die Laufzeit im Vergleich zu einer vollständigen Neugenerierung reduziert. Dazu werden im mehren Beispiel Welten die Laufzeit bei 20%, 50%, 80% oder 100% Neuberechnung gemessen.

Ein weiteres wichtiges Kriterium ist der Overhead des Systems. Da der Generationsalgorithmus nicht direkt als kompilierten Programmcode ausgeführt wird, sondern als Abhängigkeitsgraph interpretiert wird, entstehen zusätzliche Kosten. Diese entstehen insbesondere durch:
- die Verwaltung und Modifikation der Graphstruktur,
- das rekursive Auflösen der Abhängigkeiten während der Berechnung.

Ein klassischer, direkt implementierter Generationsalgorithmus könnte stärker durch den Compiler optimiert werden und benötigt keine zusätzliche Graphstruktur. Daher ist es wichtig zu testen, welchen Anteil der Laufzeit durch zusätzlichen Overhead verursacht wird. 
Den Laufzeit Anteil der Gartenstruktur lässt sich grob mit einem profiler messen. Hierfür wurde der Linux profiler perf genutzt. 

Den Overhead der Graphstruktur wurde gemessen indem eine Beispiel welt ohne Nutzung des Systems nach implementiert wurde.

Neben den reinen Laufzeiteigenschaften spielt auch die Nutzerfreundlichkeit des Systems eine Rolle. Durch den grafischen Editor lassen sich komplexe Abhängigkeiten oft leichter überblicken als in klassischem Quellcode.
Gleichzeitig erhöht dieser Ansatz jedoch auch die Komplexität des Systems. Während klassischer Programmcode sehr flexibel ist und ohne zusätzliche Struktur auskommt, erfordert der hier vorgestellte Ansatz eine explizite Modellierung aller Abhängigkeiten im Graphen. 

Im dritten sollte die Aufwand zu Erweiterung des Systems betrachtet werden. 
Meine Implementation nutzt nur simple Operationen auf CSGs. Dies entspricht nicht den wirklichen Datenstrukturen und Problemen in Spielen oder Simulationen. 
Daher würde eine Große Menge an weiteren Operationen und Datentypen implement werden müssen.

