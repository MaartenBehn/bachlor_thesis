
Die Bewertung eines Systems zur prozeduralen Generierung ist nicht trivial, da unterschiedliche Systeme häufig unterschiedliche Ziele verfolgen. Während einige Ansätze primär auf maximale Generationsgeschwindigkeit oder realistische Ergebnisse optimiert sind, liegt der Fokus dieser Arbeit auf der effizienten Neuberechnung nach Änderungen am Generationsalgorithmus. Ziel ist es, bei kleinen Änderungen am Generationsprozess möglichst große Teile der bereits berechneten Welt wiederverwenden zu können.

Im nächsten Abschnitt wird die theoretische Laufzeitcomplexität und des Systems analysiert.  

Um meine die reale Reduktion der Neuberechnungszeit zu untersuchen wird benchmarks auf meheren Beispiel Welten durchgeführt und 
es wird abgeschätzt wie viel Overhead das System gegen eine minimale Implementierung eines Generationsbespiel hat. 

Neben den reinen Laufzeiteigenschaften spielt auch die Nutzerfreundlichkeit des Systems eine Rolle. Durch den grafischen Editor lassen sich komplexe Abhängigkeiten oft leichter überblicken als in klassischem Quellcode.
Gleichzeitig erhöht dieser Ansatz jedoch auch die Komplexität des Systems. Während klassischer Programmcode sehr flexibel ist und ohne zusätzliche Struktur auskommt, erfordert der hier vorgestellte Ansatz eine explizite Modellierung aller Abhängigkeiten im Graphen.

Im dritten sollte die Aufwand zu Erweiterung des Systems betrachtet werden. 
Meine Implementation nutzt nur simple Operationen auf CSGs. Dies entspricht nicht den wirklichen Datenstrukturen und Problemen in Spielen oder Simulationen. 
Daher würde eine Große Menge an weiteren Operationen und Datentypen implement werden müssen.





