#import "../layout/ba.typ": *

= Future Work

== Nullwerte führen zu leeren Lösungen
Da der Null Wert per definition eine valider Wert ist kann es dazu kommen, dass sich ein Abhängigkeits-Kreis zu null als Lösung entwickelt, auch wenn es theoretisch andere Lösungen gebe. 
Um dies zu lösen müsste ein anderer Ansatz zur Lösung von Abhängigkeits-Kreisen genutzt werden. 

Arbeiten in Richtung closely connected Components in Verbindung könnten hier eine Lösung sein.

== Andere Datenstrukturen

Wie schon in @output_datastructure beschrieben eignen sich CSGs nicht zum direkten rendering.
Die Umwandlung zu einem Mesh mit "marching cubes" ist aufwendig und mehr wesentlich mehr Leistung benötigen, als die Generation selbst.
Somit besteht weiterhin die Forschungsfrage in wie weit minimale Neuberechnung von prozeduralen Meshen möglich ist.

== Nutzerfreundlichkeitsstudie
Die Nutzerfreundlichkeit des Systems wurde in dieser Arbeit bisher nur qualitativ betrachtet. 
Eine fundierte Bewertung sollte durch strukturierte Nutzerstudien oder Experteninterviews ergänzt werden. 
Dabei wäre insbesondere interessant, wie Nutzer mit unterschiedlichem Erfahrungshintergrund mit dem grafischen Editor umgehen. 
Erfahrene Entwickler könnten den Editor als zu einschränkend empfinden, da nur die im System vorgesehenen Operationen genutzt werden können, während weniger erfahrene Nutzer von der visuellen Darstellung der Abhängigkeiten profitieren könnten.
Ein konkreter Ansatz zur Verbesserung der Nutzerfreundlichkeit wäre die Einführung von aussagekräftigen Fehlermeldungen und Warnungen im Editor. 
Aktuell gibt das System wenig Rückmeldung darüber, warum ein bestimmter Generationsschritt fehlschlägt oder ein unerwartetes Ergebnis liefert. 
Eine bessere Visualisierung des Generationsprozesses, beispielsweise durch das Hervorheben von Knoten die neu berechnet werden, könnte dem Nutzer helfen nachzuvollziehen welche Teile der Welt von einer Änderung betroffen sind.

== Parallelisierung der Generierung
In der aktuellen Implementation werden unabhängige Knoten im Abhängigkeitsgraph sequenziell abgearbeitet. 
Da Knoten desselben Levels keine gegenseitigen Abhängigkeiten haben, könnten diese grundsätzlich parallel berechnet werden. 
Eine systematische Parallelisierung der Levelweise Berechnung könnte die Generierungszeit bei komplexen Algorithmen mit vielen unabhängigen Operationen erheblich reduzieren. 
Dabei müsste jedoch sichergestellt werden, dass Schreibzugriffe auf den Generator-Graphen thread-sicher sind, ohne dabei zu viel Overhead durch Synchronisation zu erzeugen.

== Automatische Cache-Optimierung
Aktuell muss der Nutzer manuell entscheiden, welche Knoten im Abhängigkeitsgraph gecacht werden sollen. 
Diese Entscheidung hat direkten Einfluss auf die Balance zwischen Speicherverbrauch und Neuberechnungszeit. 
Ein zu sparsames Caching führt dazu, dass bei Änderungen viele Knoten neu berechnet werden müssen, während ein zu großzügiges Caching unnötig viel Speicher verbraucht und den Overhead erhöht.

Ein interessanter Forschungsansatz wäre ein System, das diese Entscheidung automatisch trifft. 
Dazu könnte der Generator zur Laufzeit messen, wie häufig ein Knoten wiederverwendet wird und wie aufwendig seine Berechnung ist. 
Basierend auf diesen Metriken könnte das System dynamisch entscheiden, welche Knoten gecacht werden sollen. 
Ein solcher Ansatz würde die Nutzerfreundlichkeit erheblich verbessern, da der Nutzer sich nicht mehr mit den Details der Cache-Verwaltung beschäftigen müsste.

== Skalierung auf sehr große Welten
Die vorliegende Arbeit evaluiert das System anhand vergleichsweise kleiner Beispielwelten. Es bleibt offen, wie das System mit sehr großen Welten skaliert, die aus tausenden gleichzeitig aktiver Chunks und sehr tiefen Abhängigkeitsgraphen bestehen. Insbesondere die Größe des Generator-Graphen $G_"gen"$ wächst direkt mit der Anzahl der generierten Elemente. 
Bei sehr großen Welten könnte dies zu erheblichem Speicherverbrauch und längeren Traversierungszeiten führen. 
Zukünftige Arbeiten sollten untersuchen, ab welcher Weltgröße der Overhead des Systems die Vorteile der minimalen Neuberechnung überwiegt, und ob Optimierungen wie das selektive Entladen inaktiver Graphbereiche diesen Grenzwert verschieben können.

== Integration in bestehende Engines
Ein erklärtes Ziel dieser Arbeit ist es, das System in eine Spiel- oder Simulations-Engine einbettbar zu gestalten. 
Eine konkrete Evaluation dieser Integration steht jedoch noch aus. Zukünftige Arbeiten sollten untersuchen, welche Schnittstellen eine Engine bereitstellen muss und welcher Integrationsaufwand in bestehende Engines wie Unity oder Unreal Engine entsteht. 
Dabei sind insbesondere die Synchronisation zwischen dem Generator und dem Render-Thread sowie die Übergabe extern kontrollierter Variablen wie Kameraposition oder Spielzustand relevante Fragestellungen.

== Serialisierung und Persistenz
In der aktuellen Implementation existieren gecachte Zwischenergebnisse nur im Arbeitsspeicher und gehen beim Beenden der Anwendung verloren.
Für einen praktischen Einsatz wäre es jedoch wünschenswert, den Zustand des Generator-Graphen auf Disk zu persistieren. 
So könnten bereits berechnete Teile der Welt beim nächsten Start der Anwendung wiederverwendet werden, ohne sie vollständig neu berechnen zu müssen. 
Dabei stellen sich Fragen zur effizienten Serialisierung großer Graphstrukturen sowie zur Invalidierung gespeicherter Ergebnisse, wenn sich das Template zwischen zwei Sitzungen geändert hat.

