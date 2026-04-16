#import "../layout/ba.typ": *

== Graph Grammatiken
Eine Graph Grammatik ist ein System aus Regeln die beschreiben wie ein Graph verändert werden kann. 
Jede Regel besteht aus zwei Teilen: einem Teilgraph der gesucht wird, und einem Teilgraph der ihn ersetzt. 
Durch wiederholtes Anwenden solcher Regeln kann aus einem kleinen Startgraph eine komplexe Struktur wachsen. 
Zum Beispiel kann aus einem einzelnen Knoten durch Regeln wie „füge zwei Kindknoten hinzu" ein ganzer Baum entstehen.

=== L-Systems
L-Systems sind eine frühe Anwendung dieser Idee, entwickelt in den 1960ern vom Biologen Aristid Lindenmayer um Pflanzenwachstum zu modellieren. 
Statt auf einem Graphen arbeiten sie auf einer Sequenz von Symbolen. 
In jedem Schritt werden alle Symbole gleichzeitig durch die passende Regel ersetzt. 
Ein Startsymbol F könnte die Regel haben „ersetze F durch F[+F][-F]", wobei + und - für eine Drehung stehen. 
Nach wenigen Iterationen entsteht so eine verzweigte Struktur die wie ein Baum aussieht.

L-Systems eignen sich gut für Vegetation, weil natürliche Strukturen oft selbstähnlich sind. 
Ein Ast sieht aus wie ein kleiner Baum, ein Zweig wie ein kleiner Ast. 
Mit wenigen Regeln lassen sich so sehr organisch wirkende Formen erzeugen.

===  Graph based Model Synthesis
Graph based Model Synthesis erweitert das Konzept von Graph Grammatiken in dem die Regeln diese selbstständig aus einem Beispiel errechnet werden. 
Ein bestehendes Modell das in kleine Strukturelemente zerlegt wird. 
Daraus werden Regeln abgeleitet wie Teilgraphen ersetzt werden dürfen. 
Durch wiederholtes Anwenden dieser Regeln entstehen neue Modelle welches lokal den gleichen Regeln wie das Beispiel hat, aber global aber eine andere Struktur haben kann.
Im Vergleich zu L-Systems können Regeln hier auf beliebige Graphstrukturen verweisen und komplexere räumliche Bedingungen beschreiben. Außerdem ist das Verfahren nicht auf lineare Symbolsequenzen beschränkt, was es für dreidimensionale Strukturen besser eignet.

=== Minimale Neuberechnung
Keiner dieser Ansätze unterstützt minimale Neuberechnung. Bei L-Systems baut jede Iteration direkt auf der vorherigen auf. Eine Regeländerung macht damit alle folgenden Iterationen ungültig, unabhängig davon wie klein die Änderung war. Bei Graph based Model Synthesis ist das Problem ein anderes: Die Regeln werden aus einem Beispiel abgeleitet und beschreiben lokale Nachbarschaftsbedingungen. Ändert sich eine Regel, ist nicht klar welche Teile des generierten Modells diese Bedingung noch erfüllen, ohne die gesamte Struktur neu zu prüfen. In beiden Fällen fehlt eine explizite Darstellung welche Teile des Ergebnisses von welchen Regeln abhängen. Genau das ist jedoch die Voraussetzung für minimale Neuberechnung.

