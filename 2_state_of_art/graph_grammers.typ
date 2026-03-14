#import "../layout/ba.typ": *

== L-Systems

L-Systems (Lindenmayer-Systeme) sind ein regelbasiertes Verfahren zur Beschreibung und Generierung komplexer Strukturen. Sie wurden ursprünglich  zur Modellierung biologischer Wachstumsprozesse entwickelt und werden heute häufig in der prozeduralen Generierung natürlicher Strukturen eingesetzt, beispielsweise für Pflanzen, Bäume oder Korallen.

Ein L-System besteht im Kern aus einem Alphabet von Symbolen, einem Startsymbol, und einer Menge an Produktionsregeln.

Die Produktionsregeln definieren, wie jedes Symbol durch eine Folge anderer Symbole ersetzt wird. Ausgehend vom Startsymbol wird in jedem Iterationsschritt jedes Symbol gemäß den definierten Regeln ersetzt. Dadurch entsteht schrittweise eine immer längere Symbolsequenz.
Nach mehreren Iterationen entsteht eine lange Symbolfolge, die anschließend interpretiert werden kann. 

Ein wesentlicher Vorteil von L-Systems ist ihre Fähigkeit, mit wenigen Regeln sehr komplexe und selbstähnliche Strukturen zu erzeugen. Besonders fraktalartige Formen und verzweigte Strukturen wie Pflanzen lassen sich damit sehr kompakt beschreiben.

Ein Nachteil von L-Systems besteht darin, dass sie primär auf rekursiven Ersetzungsregeln basieren und daher weniger flexibel für die Beschreibung allgemeiner struktureller Abhängigkeiten sind. Die erzeugten Strukturen folgen strikt den definierten Produktionsregeln, wodurch es schwierig sein kann, globale Einschränkungen oder komplexe Interaktionen zwischen entfernten Teilen der Struktur zu modellieren.

Ein weiterer Aspekt im Kontext dieser Arbeit ist, dass Änderungen an den Produktionsregeln typischerweise eine vollständige Neuberechnung aller Iterationen erfordern. Da jede Iteration auf der vorherigen basiert, können Änderungen an einer Regel potenziell die gesamte erzeugte Struktur beeinflussen. Dadurch eignet sich dieser Ansatz nur eingeschränkt für Szenarien, in denen eine minimale Neuberechnung nach Änderungen des Generationsalgorithmus angestrebt wird.

== Graph based Model Synthesis 

Die Arbeit Graph based Model Synthesis verbindet die Idee von Graph Grammatiken und Model-Synthesis.  

Die Grundidee besteht darin, dass Generationsregeln nicht direkt auf einer expliziten Geometrie arbeiten, sondern auf dem zugrunde liegenden Graphen angewendet werden. Eine Regel beschreibt dabei eine Transformation eines Teilgraphen in einen anderen Teilgraphen. Durch wiederholte Anwendung solcher Regeln kann ein initialer Graph schrittweise erweitert oder verändert werden.

Ein Beispiel für diesen Ansatz ist die Verwendung von Graph-Grammatiken zur prozeduralen Modellierung von Polygonmodellen. Dabei wird ein bestehendes Modell zunächst in eine Menge kleiner Strukturelemente zerlegt. Aus diesen Elementen wird anschließend eine Menge von Regeln abgeleitet, die beschreiben, wie lokale Graphstrukturen miteinander kombiniert werden dürfen. Durch wiederholte Anwendung dieser Regeln können neue Modelle erzeugt werden, die lokal ähnliche Strukturen wie das ursprüngliche Beispiel aufweisen.

Ein Vorteil dieses Ansatzes ist, dass komplexe strukturelle Zusammenhänge explizit im Graphen dargestellt werden. Dadurch können Generationsregeln sehr präzise definieren, unter welchen Bedingungen eine Transformation erlaubt ist. Gleichzeitig lassen sich globale Strukturen einfacher kontrollieren als bei rein stochastischen Verfahren wie Noise-basierten Methoden.

Ein Nachteil besteht jedoch darin, dass die Definition geeigneter Graphregeln häufig aufwendig ist und ein gutes Verständnis der zugrunde liegenden Datenstruktur erfordert. Außerdem kann die Anwendung vieler Transformationsregeln auf großen Graphen zu einem hohen Rechenaufwand führen.

