#import "../layout/ba.typ": *

== Graphen

Die Datenstrukturen in dieser Arbeit basieren auf mathematische Graphen. 

Daher erklärt dieser Abschnitt die in der weiteren Arbeit genutzten Notationen.

Ein Graph $G := (V, E)$ ist besteht aus einer Menge an Knoten $V$ und einer Menge an Kanten $E$.
Die Funktionen $V(G) = V$ und $E(G) = E$ werden als verkürzte Notationen genutzt. 

Ein einzelner Knoten wird als $v in V$ und eine einzelne Kante als $e in E$ geschrieben.

Eine Kante ist ein Tuple zweier Knoten $e := (v_a, v_b)$. 
In dieser Arbeit sind Kanten grundsätzlich gerichtet und werden dann auch als $arrow(v_a v_b)$ geschrieben.

Die Menge aller eingehenden bzw. ausgehender Kanten eines Knoten $v$ wird als $E^-_G (v)$ und $E^+_G (v)$ geschrieben.

Die Menge aller Knoten die eine eingehende bzw. ausgehende Kante zu einem Knoten haben werden als $N^-_G (v)$ und $N^+_G (v)$ geschrieben, 
da sie als die Nachbarn von diesem Knoten verstanden werden.

Diese Notationen basieren auf den Notationen in "Modern Graph Theory" von Béla Bollobás @modern_graph_theory.





