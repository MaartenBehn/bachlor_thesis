#import "./layout/ba.typ": *

#set document(title: [Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation])

#show: scrartcl.with(
  title: "Minimale Neuberechnung Abhängigkeits-Graph basierter Regeln zur prozeduralen Welten-Generation",
  authors: (
    (
      name: "Maarten Behn",
      email: "behn@uni-bremen.de"
    )
  ),
  supervisors: ("Prof. Dr. Gabriel Zachmann", "Prof. Dr. Nico Hochgeschwender")
)

#import "@preview/cetz:0.4.2": canvas, draw, tree

#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= Einleitung

Prozedurale Generierung ist ein etabliertes Verfahren zur automatischen Erstellung komplexer virtueller Welten, das insbesondere in der Spieleentwicklung, Simulation und Computergrafik Anwendung findet.
Dabei werden zunächst grobe Strukturen erzeugt, die anschließend schrittweise durch immer feinere Details ergänzt werden. 
Wird der Generationsalgorithmus in irgendeiner Form angepasst, kann es vorkommen, dass eine bereits erzeugte Welt nicht mehr dem aktuellen Stand des Algorithmus entspricht.

Die Rechenzeit eines prozeduralen Generationsalgorithmus steigt mit der Menge der erzeugten Details. 
Insbesondere bei komplexen Algorithmen kann die vollständige Neugenerierung einer Welt sehr zeitaufwendig sein. 
Dies stellt ein Problem dar, da in der Praxis Generationsalgorithmen häufig iterativ entwickelt und angepasst werden. 
Lange Neugenerationszeiten können diesen Entwicklungsprozess erheblich verlangsamen.

Ziel dieser Arbeit ist es zu untersuchen, inwieweit sich die Neugenerationszeit einer prozeduralen Welt reduzieren lässt, 
wenn nur diejenigen Teile der Welt neu berechnet werden, die durch Änderungen am Generationsalgorithmus ungültig geworden sind.

Dazu wird ein System vorgestellt, welches einen Generationsalgorithmus als Abhängigkeitsgraph dargestellt. 
Dieses verwendet Zwischenergebnisse für diejenigen Teile des Graphen, die sich nicht geändert haben, wieder.

#outline(depth: 2)

= Stand der Technik

Dieses Kapitel gibt einen Überblick über bestehende Ansätze zur prozeduralen Generierung und bewertet wie weit sich diese zur minimale Neuberechnung eignen.
Zunächst werden Noise-basierte Verfahren betrachtet. 
Diese sind in der Praxis weit verbreitet, bieten aber kaum Möglichkeiten zur gezielten Teilneuberechnung. 
Danach werden L-Systems und Graph-basierte Ansätze untersucht, die durch ihre explizite Regelstruktur besser für eine solche Analyse geeignet wären, jedoch es keine konkreten Ansätze gibt.  
Anschließend werden KI-basierte Verfahren diskutiert und warum diese für minimale Neuberechnung grundsätzlich nicht geeignet sind. 
Schließlich werden die Systeme von Houdini und Blender Geometry Nodes erklärt welche den gleichen Ansatz wie diese Arbeit verfolgen, 
aber für einen anderen Kontext ausgelegt sind.

== Noise & Zufälligkeit <noise_based_generation>

Viele prozedurale Generatoren nutzen Noise-Algorithmen um Welten zu erzeugen. 
Die Grundidee ist, mehrere Noise-Funktionen wie Perlin-Noise oder Simplex-Noise mit unterschiedlichen Frequenzen und Amplituden zu überlagern. 
Ein Berg entsteht zum Beispiel durch eine Noise-Funktion mit niedriger Frequenz und hoher Amplitude, während kleinere Details wie Steine durch eine Funktion mit hoher Frequenz und niedriger Amplitude hinzugefügt werden. 
Die Struktur der Welt ergibt sich also nicht aus expliziten Regeln, sondern aus dem Zusammenspiel dieser Funktionen.

Der praktische Vorteil ist, dass sich dieser Ansatz leicht implementieren lässt und gut auf große Welten skaliert. 
Minecraft nutzt zum Beispiel Perlin-Noise um sein Gelände und Höhlen effizient zu generieren.

Das Problem ist, dass sich mit Noise-Funktionen nur schwer globale Bedingungen garantieren lassen. 
Ob ein generiertes Gelände zum Beispiel immer einen zugänglichen Weg zwischen zwei Punkten hat, lässt sich aus den Noise-Funktionen allein nicht bestimmen. 
Solche Regeln müssen im im späteren Generations Schritten überprüft und die Welt gegeben Falls angepasst werden. 
Jedoch werden in vielen Generations Systemen diese Fehler einfach akzeptiert wenn sie nur selten auftauchen.

Für minimale Neuberechnung sind Noise-basierte Verfahren besonders ungeeignet, da theoretische jede Noise Ebene einfluss auf jedes Ergebniss hat. Die Generierungslogik steckt implizit in der Komposition der Funktionen. Ändert man eine Funktion oder ihre Parameter, kann dies eine Komplett andere Welt bedeuten.

== Example based Model Synthesis 

Eine bekannte Arbeit im Bereich der constraint-basierten Generation ist Paul Merrels "Example-based Model Synthesis".
@model_synthesis

Die Grundidee besteht darin, aus einem kleinen Eingabedatensatz eine größere Struktur zu erzeugen, die lokal denselben Regeln folgt.

Der Eingabedatensatz besteht aus einer Gitterstruktur, bei der jeder Zelle ein Wert zugeordnet ist. Aus diesem Gitter wird eine Liste aller Nachbarkombinationen erstellt, die im Eingabedatensatz vorkommen. 

Diese Liste beschreibt die Regeln, nach denen ein neues Modell erzeugt wird. 
Der Generationsalgorithmus läuft dabei wie folgt ab: Zunächst werden allen Zellen des neuen Gitters sämtliche möglichen Werte zugeordnet.
Dann wird die Zelle mit den wenigsten verbleibenden Möglichkeiten ausgewählt und auf einen einzelnen Wert festgelegt. 
Anschließend werden aus den Nachbarzellen alle Werte entfernt, für die keine gültige Regel mehr existiert. 
Dieser Bereinigungsschritt wird rekursiv auf alle betroffenen Nachbarn ausgeweitet. 
Der Vorgang wiederholt sich, bis jede Zelle genau einen Wert enthält.

=== Minimale Neuberechnung mit Model Systhesis 

Ein möglicher Ansatz zur partiellen Neuberechnung prozedural generierter Welten könnte auf Verfahren der Example-based Model Synthesis aufbauen. Die grundlegende Idee wäre zunächst eine vollständige Welt mit dem Model-Synthesis-Algorithmus zu generieren. Wenn sich anschließend die zugrunde liegenden Regeln ändern, könnte versucht werden, nur die Teile der Welt zu verändern, die den neuen Regeln nicht mehr entsprechen.

Ein naheliegender Ansatz wäre, alle Felder zu identifizieren, deren aktuelle Werte gegen die neuen Regeln verstoßen. Für diese Felder müssten anschließend wieder mehrere mögliche Werte zugelassen werden, sodass der Model-Synthesis-Algorithmus erneut eine konsistente Lösung finden kann.

Dabei stellt sich jedoch ein grundlegendes Problem: Wenn einem Feld neue mögliche Werte hinzugefügt werden, sind diese zunächst nicht notwendigerweise mit den aktuellen Werten der Nachbarfelder kompatibel. Damit die lokalen Regeln wieder erfüllt sind, müssten auch den Nachbarfeldern zusätzliche mögliche Werte hinzugefügt werden. Dieser Prozess kann sich wiederum auf deren Nachbarn ausbreiten und so weiter.

Würde man dieses Verfahren naiv implementieren, indem für alle betroffenen Nachbarn wieder sämtliche möglichen Werte zugelassen werden, entstünde im Extremfall erneut ein vollständig unentschiedenes Gitter. In diesem Fall würde der Algorithmus effektiv wieder bei einem normalen Model-Synthesis-Prozess beginnen, wodurch kein Vorteil gegenüber einer vollständigen Neugenerierung entsteht.

Um dennoch einen Nutzen aus diesem Ansatz zu ziehen, müsste eine möglichst kleine Menge an Feldern gefunden werden, deren Wertebereiche erweitert werden, sodass anschließend wieder eine konsistente Lösung existiert. Diese Menge sollte idealerweise minimal sein, damit möglichst große Teile der bestehenden Welt unverändert bleiben können. Gleichzeitig müsste der Aufwand zur Bestimmung dieser Menge deutlich geringer sein als eine komplette Neugenerierung der Welt.

Eine theoretische Möglichkeit bestünde darin, den Raum der möglichen Werteerweiterungen systematisch zu durchsuchen. Beispielsweise könnte eine Breitensuche über den Graphen der möglichen Wertkombinationen durchgeführt werden, um eine minimale Menge an Änderungen zu finden, die wieder zu einer gültigen Konfiguration führt. Allerdings wächst dieser Suchraum sehr schnell und führt sowohl in Bezug auf Laufzeit als auch Speicherverbrauch zu erheblichen Komplexitätsproblemen.

Der Vorteil des ursprünglichen Model-Synthesis-Algorithmus liegt darin, dass zu jedem Zeitpunkt alle noch möglichen Kombinationen eine valide Lösung darstellen. Das Finden einer minimalen Erweiterung dieser Mengen, die nach einer Regeländerung wieder eine gültige Lösung ermöglicht, ist jedoch deutlich schwieriger als die ursprüngliche Generierung selbst. 

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


== KI basierte prozedurale Generation

Neuronale Netzwerke können genutzt werden um ähnliche Inhalte zu einem Trainings Datensatz zu erzeugen. 
In Arbeiten wie @evolvingmariolevels @Level_Generation_with_Constrained_Expressive_Range und @Compressing_and_Comparing_the_Generative_Spaces_of_Procedural_Content_Generators werden Neuronale Modelle genutzt um Levels aus bekannten 2D Spielen zu reproduzieren. 
Dabei wird in @evolvingmariolevels wird ein Level generations Model gegen ein Spieler Argent Modell trainiert, welches bewertet ob ein Level spielbar ist. 
Der Ansatz ist meistens fähig spielbare Levels zu generieren, wobei es vereinzelt zu generation Artefakten kommen kann.
Jedoch behandelt die Ansätze simple 2D Spiele, für die es viel vorhandene Level zu trainieren gibt. 

=== Terrain Diffusion

Im Ansatz „Terrain Diffusion“ werden Neuronale-Diffusion-Modelle verwendet. Diffusion-Modelle erzeugen Daten, indem sie iterativ aus zufälligem Rauschen eine strukturierte Lösung rekonstruieren. Dieses Verfahren wird ursprünglich für Bildgenerierung eingesetzt, kann jedoch auch zur Erzeugung von Höhenkarten verwendet werden.

Hier wird ein neuronales Modell auf reale Geländedaten trainiert, sodass es realistische Terrainstrukturen erzeugen kann. Um weiterhin unendliche Welten generieren zu können, wird das Gelände in Kacheln erzeugt, die deterministisch aus einem Seed generiert werden. Dadurch können neue Bereiche der Welt bei Bedarf berechnet werden, ähnlich wie bei klassischen Noise-basierten Verfahren.

Der Vorteil dieses Ansatzes liegt darin, dass größere geographische Strukturen realistischer modelliert werden können als mit klassischen Noise-Funktionen.

Ein Nachteil ist jedoch, dass das Verhalten des Systems stark vom Trainingsdatensatz abhängt und Generationsregeln nicht explizit definiert sind. Dadurch ist es schwierig sicherzustellen, dass bestimmte strukturelle Anforderungen immer erfüllt werden.
@terraindiffusion

=== Minimale Neuberechnung

KI-basierte Ansätze teilen ein grundlegendes Problem: 
Die internen Repräsentationen neuronaler Modelle sind nicht interpretierbar. 
Es ist daher nicht nachvollziehbar, welche Teile der Eingabe oder welche Gewichte des Modells zu welchen Teilen des generierten Ergebnisses beitragen. 
Ändert sich ein Parameter oder eine Eingabe, gibt es keine Möglichkeit, daraus abzuleiten, welche Teile einer bereits generierten Welt noch gültig sind. 
Eine minimale Neuberechnung setzt jedoch genau dieses Wissen voraus. 
Aus diesem Grund werden KI-basierte Ansätze in dieser Arbeit nicht weiter betrachtet.


== Houdini & Blender Geometry Nodes

Programme wie Houdini und Blender Geometry Nodes nutzen Abhängigkeits-Graph Systeme wie in dieser Arbeit vorgestellt.
Dabei werden auch Zwischenergebnisse gespeichert und wiederverwendet um die Laufzeit zu verbessern. 
Jedoch sind beide System auf die interaktive Erstellung einzelner Assets ausgelegt und nicht auf die prozedurale Generation großer zusammenhängender Welten mit tausenden von Elementen.  
Zudem sind dies geschlossene Programme die nicht darauf ausgelegt sind in eine Spiel- oder Simulations-Engine eingebettet zu werden. 
Das in dieser Arbeit vorgestellte System hingegen zielt explizit auf diesen Kontext ab, da der Generationsalgorithmus dort iterativ weiterentwickelt wird und Änderungen schnell in einer bereits bestehenden Welt sichtbar sein sollen.

= Theoretische Grundlagen 

Dieses Kapitel beschreibt die technischen Konzepte, auf denen das in dieser Arbeit vorgestellte System aufbaut. 
Dazu gehören Lazy Computation als Grundprinzip der minimalen Neuberechnung, 
Graphen als zentrale Datenstruktur, Constructive Solid Geometry zur Darstellung von Geometrie sowie Grafische Programmierung als Grundlage des Editors.

== Minimales errechnen (Lazy computation)

Minimales errechnen auf englisch Lazy computation beschreibt die Idee in Computerprogrammen die Daten erst dann zu errechnen wenn sie benötigt werden. 

Es reduziert Lag-spikes gerade beim starten eines neuen Prozesses, da Anstatt alle nutzbaren Daten nur die, die gerade angefragt benötigt werden errechnet werden.  

In Funktionale Programmiersprachen wie Haskell findet dieses Konzept vie Anwendung und erlaubt für unendliche Datenstrukturen. 


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


== Constructive Solid Geometry (CSG)

Constructive Solid Geometry (CSG) ist eine Methode zur Darstellung von Volumen, bei der komplexe Geometrien durch die Kombination primitiver Geometry (Box, Kugel, etc) dargestellt wird.

Diese Kombination sind standartmäßig Vereinigung, Schnittmenge und Differenz, wurden jedoch in späteren Arbeiten mit komplexeren Operationen,
wie Verformung, Duplikation, etc erweitert.

CSGs werden als directed acyclic graph (DAG) gespeichert. 
Jede Knoten is eine implizierte Operation auf den Volumen der Kinder. 
Die Blätter sind dahingegen durch Parameter definierte primitive Geometrien.

Der Vorteil dieser Darstellung ist, dass Geometrie über Parameter und Operationen beschrieben wird. Änderungen an Position, Größe oder anderen Parametern wirken sich direkt auf das resultierende Volumen aus, ohne dass die gesamte Geometrie neu definiert werden muss.

Jedoch eignen sich CSGs selten zum direkten rendering mit raytracing, da die Operationen zu leistungsaufwendig sind um mit jeden Ray den DAG 
zu rekursiv zu iterieren. Dazu steigt die Größe des DAGs schnell mit der Komplexität des CSGs. 
@csg_original @csg_advanced


== Grafische-Programmierung

Grafische-Programmierung ist eine From der Programmierung bei der Logik nicht als Code definiert ist sonder als Diagram 
in einem grafischen Editor. Funktionen werden als Knoten mit Input und Output dargestellt.
Dies können mit Linien verbunden werden um logische Abfolgen zu definieren. 

Grafische-Programmierung erlaubt ein besseren überblick über Programmabschnitte 
und ist durch seinen invitieren Syntax Einsteigerfreundlicher.

Grafische-Programme ausgeführt werden indem die Operationen als Graph dargestellt werden. 
Dieser kann vergleichbar zu Funktionenprogrammiersparchen rekursiv gelöst werden. 

Jedoch ist es auch möglich einen Grafische-Programme in Code zu übersetzen und Maschinen-Code zu kompilieren.
Dies kann massive Leistungsvorteile haben.

Populäre Programme in den Grafische-Programmierung verwendet wird, sind Unity Shader Graphs, Unreal Engine Templates und Blender Geometry Nodes. 

#ba_image("./../assets/Shader Graph.png", 100%, [ Der grafischen Editor von Unity Shader Graph ])


= Mein Lösungsansatz

Dieses Kapitel beschreibt wie das in der Einleitung formulierte Ziel der Reduktion der Neuberechnungszeit konkret umgesetzt wurde. 
Dabei werden die Komponenten des Systems vorgestellt und zentrale Algorithmen erklärt.
Daraufhin werden auf Besonderheiten im System eingegangen und Edge Cases diskutiert. 

Der vorgestellte Ansatz zeigt, dass sich prozedurale Generierung so strukturieren lässt, dass automatisch Erkannt werden kann welche Teile der Welt bei einer Änderungen am Algorithmus neu errechnet werden müssen.
Dafür muss der Algorithmus als Abhängigkeitsgraph modelliert werden. 


== Abhängigkeits-Graph

Jede mathematische Formel oder Algorithmus kann als Graph an Abhängigkeiten dargestellt werden. 
Dabei beschreibt jeder Knoten eine mathematische Operation die aus ein oder mehren Eingangswerten einen Ausgangswert errechnet. 
Die Eingangswerte eines Knoten sind die Ergebnisse andere Knoten im Graph. 
Dies bezeichne ich als Abhängigkeit, da die Ergebnisse der Eingangsknoten für die Berechnung benötigt werden. 
Das Ergebnis eines Knoten hängt nur von den Eingangswerten ab und hat damit keine Nebeneffekte. (siehe Funktionale Programmierung)
Knoten können keine Eingangswerte haben dann erzeugen diese immer die gleichen Werte und werden als konstant verstanden. 


== Framework

#ba_image("../assets/overview_diagramm.png", 100%, [Überblick über Editor, Abhängigkeits-Graph, dessen cache und der Welt. #itodo("Sauber zeichnen")])

Mein generations System besteht aus drei Bestandteilen. 
1. Ein Graphischer Editor indem ein Nutzer einen Abhängigkeits-Graph erstellen und bearbeiten kann. 

2. Das Template ist eine Datenstruktur die vom Editor erstellt wird und den Abhängigkeits-Graph sowie Informationen wie dieser generiert und zwischen gespeichert werden soll enthält.  

3. Der Generator vergleicht das aktuelle Template mit dem neuen Template und generiert die Bestandteile der Welt neu die nicht dem neuen Template entsprechen.

== Graphischer Editor

Zur interaktiven definition des Abhängigkeits-Graph wird ein Grafische-Programmierungs-Editor vergleichbar zu Unreal Templates, Blender Geometry Nodes oder Unity Shader Graph genutzt. 

Der Nutzer kann Knoten erstellen die einer Operation entsprechen und frei auf einer unendlichen Fläche angeordnet werden können. 
Diese Operationen haben auf der linken Seite eine Liste an Input Variabeln und an der Rechten Seite eine Liste an Ergebnissen. 

#ba_image("../assets/sphere.png", 80%, [Node um ein Kugel Volumen zu definieren. #itodo("Hintergrund")])


Die Variabeln und Ergebnisse sind farbig nach ihrem Datentyp kodiert und können mit Linien verbunden werden. 
Die Symbolsiert, das ein Ergebnis als Variabele für eine andere Operation verwendet werden soll. 

So können komplexe Algorithm über Knoten Verbindungen von links nach rechts dargestellt werden, 
parallele Stränge werden übereinander angeordnet. 
Die fördert eine Darstellung die komplexe Abhängigkeiten übersichtlich darstellen kann.  

#ba_image("../assets/nodes.png", 80%, [Eine Kugel dessen Größe seiner X Position entspricht. #itodo("Hintergrund")])

== Template 

Das Template $:= (G_"ab", G_"ch")$ besteht aus dem Abhängigkeits-Graph $G_"ab"$ und einem "cache" Graphen $G_"ch"$. 

$G_"ab"$ ist ein Graph der die zu generierende Welt als rekursive Formel an Operationen beschreibt. 

Die ein gehenden Nachbarn $N^-_G_"ab"$ errechnen die Eingangswerte für eine Operation und die 
ausgehenden Nachbarn $N^+_G_"ab"$ sind alle Operationen die das Ergebnis benötigen. 

#todo("Beispiel?")

/*Datentypen sind meist durch andere Datentypen definiert z.B. 
ist eine 3D Position durch 3 Zahlen definiert. 

Ein $v in V(G_"val")$ hat folgende Eigenschaften: 

$N^-_G_"val" (v) := "Werte die für die Errechnung genutzt werden."$

$N^+_G_"val" (v) := "Werte indem es für die Errechnung genutzt wird."$
*/

$G_"ch"$ enthält einen Knoten für jeden Knoten in $G_"ab"$ der Zwischengespeichert werden soll. 
Dies ist eine Untermenge aller Knoten in $G_"ab"$. $V(G_"ch") subset V(G_"ab")$

Bei der Entscheidung wie groß diese Untermenge sein soll muss zwischen dem "Overhead" durch zwischengespeicherung und der Zeitersparniss durch wiederverwendung der Ergebnisse abgewägt werden. 

Die ein gehenden Nachbarn $N^-_G_"ch"$ sind alle caches von dem der Knoten abhängt. 
Man findet diese indem man den Baum der Abhängigkeiten in $G_"ab"$ über alle Verzweigungen rekursiv durchsucht bis man auf jeden Weg einen auf einen Knoten in $G_"ch"$ stößt.

#todo("Grafik von Datentypen und Abhängigkeits-Graph")

=== Level

Wenn der $G_"ab"$ ein directed acyclic Graph (DAG) ist dann kann jedem Knoten $v in G_"ab"$ ein Level $l(v)$ zugeordnet werden.
Dies ist definiert als:
$
  l(v) > l(v_i) quad forall v_i in N^-_G_"ab" (v)
$
Also das Level eines Knoten ist immer größer als das Level aller Knoten von den er abhängt.

Um den $G_"ab"$ zu errechnen werden die Knoten der Level aufsteigend errechnet.  
Die Rheinfolge innerhalb eines Levels ist nicht relevant. 

=== Einen Prozeduralen Algorithmus als Template darstellen

Bis zu diesem Abschnitt habe ich das Template sehr allgemein beschrieben. 

Um mit dem Template eine Prozedurale Welt zu generieren haben ich mich entschieden, dass das Template final ein Volumen als 
"constructive solid geometry" (CSG) errechnet.

Diese CSG setzt sich durch union und remove Operationen auf primitiven Geometrien wie Kugeln und Boxen zusammen. 

Daher sind die Operationen die ich implementiert habe: 
- CSG Union und Remove
- Kugel aus Position und Durchmesser
- Box aus Position und Seitenlänge
- Alle Positionen auf einem Gitter die innerhalb eines Volumen sind.
- Eine Menge an zufälligen Positionen innerhalb eines Volumen. siehe: genauer dazu
- Addition, Subtraktion, Multiplikation und Division von Positionen und Zahlen
- etc.

=== Generation eines Templates <generation_of_template>

Operationen im Abhängigkeits-Graph $G_"ab"$ können auch Mengen an Werten erzeugen. 
In meiner implementation sind dies die beiden Operationen die ein Gitter und zufällige Positionen in einem Volumen errechnen. 

Nun kann es sein, dass die weiteren Operationen pro Element in dieser Menge ausgeführt werden sollen. 
Dies ist der Bestandteil von prozeduraler Generation der es möglich immer feinere Details zu generieren.
Zu Beispiel errechnet man eine Menge an Positionen an den Apfelbäume stehen sollen 
und dann generiert man pro Baum die Positionen der Äpfel.

Dies ergibt einen klaren Unterschied in der Laufzeit von Algorithmen auf dem Template zu Algorithmen auf der generierten Welt. 
Die Menge an Knoten im Abhängigkeits-Graph und so auch den cache Graph skaliert mit der Menge an Operationen des Generationsalgorithums.
Wohin die Menge der Elemente in der Welt mit dem Größen der Mengen an rechneten Werten skaliert.
In anderen Worten alle Knoten im Template zu iterieren ist relativ schnell möglich wohin gegen die Laufzeit alle Elemente in der Welt zu iterieren exponentiell steigen kann. 

Daher arbeiten alle Algorithmen im meinen System immer nur auf den Knoten des Templates. 
Sie nutzen die Abhängigkeiten im Template um heraus zu finden wie die Welt neu generiert werden muss. 

== Generator

Der Generator enthält einen Graphen $G_"gen"$ der den cache Graphen $G_"ch"$ im Template entspricht.
Jeder Knoten $v_"gen" in V(G_"gen")$ speichert welchem Knoten $v_"ch" in V(G_"ch")$ er entspricht $v_"ch" = $ *cache*$(v_"gen")$.
Dazu hat ein Knoten $v_"gen" in V(G_"gen")$ das Level seines "cache" Template Knoten $l(v_"gen") = l($*cache*$(v_"gen"))$.

Jedoch wo $G_"ch"$ nur einen Knoten pro Operation enthält, enthält $G_"gen"$ einen Knoten pro Ergebnis welches errechnet werden muss. 

#todo("Beispiel")

Dazu hält der Generator $:= (G_"gen", Q_"tasks")$ eine Queue $Q_"tasks"$ die zwei Arten Aufträgen auf $G_"gen"$ nach ihren Level sortiert.    
$
"pop"(Q_"tasks") := min_(q in Q_"tasks") (l(q))
$

Errechnungs-Aufträge errechnen den das Ergebnis eines Knoten in $G_"gen"$ und Kind-Update-Aufträge 
erzeugen oder löschen Kinder sodass sie dem Template entsprechen.

=== Abhängigkeite Werte im Generator Graph finden

Um einen Knoten in $G_"gen"$ zu errechnen benötigt man die Ergebnisse der Knoten in $G_"gen"$ von den dieser Knoten abhängt. 
Wie ich in @generation_of_template erklärt habe ist es Laufzeittechnisch nicht möglich diese mit z.B. einer Tiefensuche zu suchen.

Stattdessen wird für jeden Template Knoten $v in V(G_"ch")$ einer der Knoten von den er abhängt $N^-_G_"ch" (v)$ als Erstellungs-Knoten $v_c in V(G_"ch")$ im Template markiert $v_c = $*create*$(v)$.    

Um nun für einen Knoten $v_"gen" in V(G_"gen")$ alle anderen Knoten zu finden von er abhängt $N^-_G_"gen" (v_"gen")$, 
werden die relative Schritte in $G_"ch"$ vom Erstellungs-Knoten $v_c$ zu den anderen Abhängigen Knoten als Baum gespeichert 
$T_"rel" (v_"gen")$.

Ein relativer Schritt $v_"step"$ gibt entweder an das man 
von einem Knoten $v in V(G_"ch")$ hoch (*up*($v_"step"$) = True) in einen Knoten $v_"up" in V(G_"ch")$ 
von dem $v$ abhängt ($v_"up" in N^-_G_"ch" (v)$) 
oder runter (*up*($v_"step"$) = False) in einen Knoten $v_"down" in V(G_"ch")$ 
der von $v$ abhängt ($v_"down" in N^+_G_"ch" (v)$) gehen soll. 

Da ein Knoten $v in V(g_"ch")$ mehr als einen eingehenden oder ausgehenden Nachbarn haben kann speichert ein relativer Schritt auch
in welchen Nachbarn gegangen werden soll (*cache*($v_"step"$)) und dazu ob dieser Nachbar eine Abhängigkeit für $v_"gen"$ ist (*deps*($v_"step"$) = True).

Jeder relative Schritt $v_"step"$ gibt speichert auch in welche der Nachbar Knoten gegangen werden soll. 

Diese relativen Schritte nutzen nur Knoten die ein kleineres Level haben als $v_"gen"$. 
Da im Generator Knoten im Level aufsteigend erstellt werden, ist so sichergestellt das alle relativen Wegen existieren.

Für einen Knoten im Template kann es mehrere Knoten im Generator geben, daher können pro Abhängigkeit eines cache Knoten 
auch mehrere Knoten im Generator gefunden werden.

#block(
  breakable: false,
  algorithm-figure(
    "Finde abhänige Knoten in " + $G_"gen"$,
    vstroke: .5pt + luma(200),
    {
    import algorithmic: *

    Procedure("FindDeps", ($v_"gen"$, $v_"gen creates"$), {
      Assign($T$, $T_"rel" (v_"gen")$)
      Assign($D$, $nothing$)
      Assign($Q$, $nothing$)
      Line[*push*($Q$ , $(v_"root" in T, v_"gen creates")$)] 
      LineBreak

      While($Q != nothing$, {
        Assign($(v_"step", v_"gen")$, [*pop*($Q$)])
        LineBreak

        If([*deps*($v_"step"$)], { 
          Line[*push*($D$ , $v_"gen"$)] 
        })
        LineBreak

        For($v_"child step" in N^+_T (v_"step")$, {

          
          Assign($N$, IfElseInline([*up*($v_"child step"$)], $N^-_G_"gen" (v_"gen")$, $N^+_G_"gen" (v_"gen")$))
          LineBreak

          For($v in N$, {
            If([*cache*($v_"child step"$) = *cache*($v$)], {
              Line[*push*($Q, (v_"child step", v)$)] 
            })
          })


        })
      })
      Return($D$)
    })
  }))


#todo("Beispiel Zeichung")


=== Kind-Update-Aufträge

Kind-Update-Aufträge enthalten den Index des Erstellungs-Knoten und den Index eines Erstellungs-Eintrag $E_"create" (v_"ch")$ in dessen Template-Knoten.
Dieser Erstellungs-Eintrag definiert wie viele Kinder es geben soll *num*$(v_"ch", v_"gen creates")$. 
Dies sind entweder es genau $n$ pro Erstellungs-Knoten oder, oder hängen von dem Wert des Erstellungs-Knoten $v_"gen creates"$ ab 
wie z.B. einer Positions Menge.
Dazu gibt *valid*$(v_"gen", v_"gen creates")$ an ob ein Kind $v_"gen"$ noch für den Erstellungs-Knoten $v_"gen creates"$ noch valide ist. 
z.B. ob eine Position noch in der Menge an Positionen ist. 

Darauf wird die vorhandene Menge an Kindern mit der gewünschten Menge verglichen und bei Ungleichheit neue Kinder Knoten erzeugt oder gelöscht. 

Wenn eine neuer Knoten erzeugt wird werden mit dem Baum an relativen Schritten die Indexe von allen abhängige Knoten gesucht und im Knoten gespeichert.
#block(
  breakable: false,
  algorithm-figure(
    "Kinder updaten",
    vstroke: .5pt + luma(200),
    {
    import algorithmic: *
    let create = Call.with("Create")
    let delete = Call.with("Delete")
    let findDeps = Call.with("FindDeps")
    let addtask = Call.with("AddTask")

    Procedure("UpdateChild", ($v_"gen"$, $v_"ch child"$), {
      LineBreak
      Assign($C$, ${v in N^+_G_"gen" (v_"gen") | "cache"(v) = v_"ch child"}$)

      LineBreak
      Assign($C_"to delete"$, ${v in C | not "valid"(v, v_"gen") }$)

      LineBreak
      For($v in C_"to delete"$, {
        LineBreak
        Line(delete(($v$)))
      })

      LineBreak
      Assign($n$, [*num*($v_"ch child", v_"gen"$)])
      Assign($i$, $0$)

      For($i < n - |C \\ C_"to delete"|$, {
        LineBreak
        Line(create(($v_"ch child"$, $v_"gen"$)))
      })
    })
    LineBreak

    Procedure("Create", ($v_"ch"$, $v_"gen creates"$), {
      
      Line([*push*($V(G_"gen"), v_"new"$)])
      LineBreak
      
      Assign([*cache*($v_"new"$)], $v_"ch"$)
      LineBreak

      Assign($D$, findDeps(($v_"new"$, $v_"gen creates"$)))
      LineBreak

      Assign($N^-_G_"gen" (v_"new")$, $D$)  
      LineBreak

      For($v in D$, {
        Line([*push*($N^+_G_"gen" (v)$, $v_"new"$)])
      })
      LineBreak
      
      Line([*pushCalculate*($Q_"task"$, $v_"new"$)])
    })
    LineBreak

    Procedure("Delete", ($v_"gen"$), {
      LineBreak
        
      For($v in N^-_G_"gen" (v_"gen")$, {
        LineBreak
        Line([*remove*($N^+_G_"gen" (v)$, $v_"gen"$)])
      })
        LineBreak

      For($v in N^+_G_"gen" (v_"gen")$, {
        LineBreak
        Line(delete(($v$)))
      })
      
      Line([*remove*($V(G_"gen")$, $v_"gen"$)])
    })
  }))

=== Errechnungs Aufträge 
Errechnungs Aufträge errechnen den Wert von einem Knoten $v_"gen" in V(G_"gen")$ neu. 
Dabei wird der Knoten im Abhängigkeits-Graph rekursiv errechnet.

Wenn ein der Algorithmus auf einen Knoten $v_"ab" in V(G_"ab")$ stößt, welcher ein cache Knoten hat $v_"ab" in V(G_"ch")$ werden die Werte der jeweiligen abhängigen Knoten von $v_"gen"$ verwendet. 

#todo("Beispiel")

=== Abhängigkeits Kreise
Das Template kann Abhängigkeits Kreise enthalten. 
Um trotzdem eine valide Lösung errechnen zu können muss es für jeden Knoten $v_"val"$ einen validen Null Wert geben. 

So kann der Abhängigkeits Graph iterativ gelöst werden. 
Dazu werden pro Kreis im Abhängigkeits-Graph eine Kante als durchgeschnitten markiert 
$N^+_"cut" (v) subset.eq N^+_G_"dep" (v) quad v in V(G_"dep")$.
Der Abhängigkeits-Graph ohne die durch geschnittenen Kanten 
$N^+_"not cut" (v) := N^+_G_"dep" (v) without N^+_"cut" (v)$ ist ein DAG. 
Also kann jedem Knoten ein Level $l(v)$ zu geordnet werden. 
$
  l(v) > l(v_i) quad forall v_i in N^+_"not cut" (v)
$

Die Knoten werden Level nach Level erzeugt und so sichergestellt das alle nicht geschnittenen Abhängigkeiten schon errechnet worden sind, wenn der Knoten selbst errechnet wird. 
Hat ein Knoten geschnittene Abhängigkeiten werden diese zu Errechnung genutzt wenn sie existiert. Andernfalls wird der Null Wert verwendet.
Jeder Knoten der Null Werte für seine geschnittenen Abhängigkeiten nutzt wird nochmal errechnet, sobald alle Knoten einmal errechnet wurden.  
Dies wird so lange wiederholt bis keine Null Werte mehr verwendet worden sind.


== Implementation 

Für die Beispiel Implementation habe ich Rust als Sprache gewählt, 
da sie erlaubt speichersicheren low level code zu schreiben um die Laufzeit von Algorithm effektiv zu verbessern 
und ein in Gegensatz zu C++ ein umfassenden leicht zu nutzenden Package-Manager hat.  

=== Stabiele Listen
Alle Graphen sind mit stabilen Listen implementiert.

Eine stabile Listen ist eine sich automatisch vergrößerndes Array. 
Wenn dass aktuelle Array voll ist wird ein größeres Array alloziert und die werte mit einer memcopy Operation rüber kopiert.
Dazu änderen sich die Indexe von Elementen in stabilen Listen nicht.
Wenn ein Element entfernt wird, werden die weiteren Elemente nicht aufgeschoben um die Lücke zu schließen, stattdessen wird der Index des nächsten freien Element gespeichert.
Dazu speichert die List speichert den Index des ersten freien Element, welches genutzt wird wenn ein neues Element eingefügt wird. 
Der dort gespeicherte nächste freie Index wird dann als erster freier Index gespeichert.
Dies erlaubt Einfüge-, Entfernungs- und Zugriffslaufzeit von $O(1)$. 

Dazu wird pro Element eine Versionsnummer gespeichert. 
Bei einem Zugriff wird die Version des Index mit der Version des Elements an der Stelle des Index verglichen. 
So bleiben Indexe valide solange das Element in der Liste ist und es wird erkannt wenn man mit veralteten Index zugreift. 

Die oberen 32Bit des Indexes werden genutzt um Versionsnummer zu speichern.
Somit können in einer stabilen List $2^32$ Elemente gespeichert werden.

Stabiele Listen erlauben Graphen effizient als Listen darzustellen, indem in den Knoten die Indexe der anderen Knoten gespeichert werden zu den Kanten existieren. Stabiele listen sind dabei wesentlich schneller als HashMaps.
@slotmap_crate


=== Multi Threading

Der Collapser sowie die Sampeling Operationen werden in asynchronous Workern ausgeführt. 
Zur Kommunikation werden Channel verwendet. @channels_theory & @async_channel

Der Composer läuft im Render Thread und errechnet bei jeder Änderung das aktuelle Template. 
Dieses Template wird über ein Channel zum Collapser gesendet. Wenn der Channel noch ein altes Template enthält werden die Änderungen Notizen des alten Template zum neuen hinzugefügt und das Template wird ersetzt. 

Die errechnete CSG Darstellung der Welt wird mit einem weiteren Channel an die Sampler gesendet, welche dieses in ein Voxel DAG oder Mesh umrechnet und auf die GPU gelanden. 

Wenn die neue Welt hochgenanden wurde wird der Render Thread über ein Channel über diese Änderung informiert. 

=== Small Vectors

Für die Zwischenspeicherung der Werte werden Small Vectors verwendet. 
Diese haben die Eigenschaft, dass die ersten N Elemente direkt auf dem Stack alloziert werden. 
Erst wenn diese voll sind wird ein Array auf dem Stack alloziert. 

Da alle Werte müssen als Liste behandelt werden, da ein Knoten immer von mehreren Knoten für ein Input abhängt.
Jedoch enthält diese Listen meist doch nur ein Element. 
Small Vectoren erlauben für diese Fälle die Stack allozieren zu sparen und bieten bessere Cache Lokalität.
@smallvec_crate

=== Output Datenstruktur <output_datastructure>

Das Kernconzept, einen sehr großen Graphen der eine prozeduralen Algorithmus darstellt, zu bearbeiten, indem man die Abhängigkeiten in einem vergleichbar kleinen Template nutzt, enthält keine konkreten Anahmen über die Art der Geometrie. 
In meiner Implementation habe ich CSG genutzt, da es einer sehr allgemeine Form ist, Volumen darzustellen und diese leicht zu bearbeiten sind.

Gerade CSGs mit vielen Knoten sind jedoch nicht performant zu rendern. 
Deshalb können die CSGs in meiner Implementation entweder als Sparse Voxel DAGs oder mit marching cubes gesampled werden.

Voxel Datenstrukturen können relativ effizient mit ray marching geraytraced werden. 
@dda @nvidia_octree

Mit Hilfe von marching cubes kann ein CSG als Mesh approximiert werden. 
@marching_cubes


== Beispiele 

Im Folgenden werden mehrere Beispiele vorgestellt, die die Funktionen des Systems demonstrieren. 
Dabei wird zuerst in minimalen Beispielen gezeigt wie das System teile der Generierten Welt wiederverwenden kann 
und danach eine komplexe Welt vorgestellt, welche den Umfang des Systems darstellt.

=== Nur finales Volumen neu errechnen

Das erste Beispiel generiert eine große Anzahl von Bäumen, die auf einem Gitter verteilt sind. Jeder Baum besteht aus einem Stamm (Zylinder) und einer Baumkrone (Kugel). Die Positionen aller Bäume werden aus einer Gitter-Operation berechnet und im Cache gespeichert. Die Form der Baumkrone wird als separate Operation im Abhängigkeitsgraphen modelliert.

Wenn nun die Form oder Größe der Baumkrone geändert wird betrifft diese Änderung nur den Teilgraphen, der die Krone berechnet. Dabei können die Positionen der Bäume wiederverwenden. Der Generator erkennt, dass nur die CSG-Volumen der Kronen ungültig sind, und berechnet ausschließlich diese neu.

#figure(
  image("./assets/trees.png", width: 80%),
  caption: [Trees],
) <fig-trees>

#todo("Update Image")

=== Extern kontrollierte Variable

Knoten im Abhängigkeitsgraphen können nicht nur von anderen berechneten Knoten abhängen, sondern auch von extern kontrollierten Variablen. 
Ein typisches Beispiel ist die Kameraposition, die vom der Game Engine zur Verfügung gestellt wird und sich kontinuierlich verändern kann.

In diesem Beispiel wird die Kameraposition als konstanter Knoten im Abhängigkeitsgraphen modelliert.
Darauf aufbauend wird eine Positions-Menge berechnet, die alle Weltabschnitte (Chunks) innerhalb eines bestimmten Radius um die Kamera enthält. 
Da diese Menge direkt von der Kameraposition abhängt, wird sie neu berechnet, sobald sich die Kameraposition ändert.

Bewegt sich die Kamera, erkennt der Generator, dass der Wert des Kamerapositions-Knotens ungültig geworden ist, und errechnet alle abhängigen Knoten neu.
Chunks, die nun außerhalb des Radius liegen, werden gelöscht. 
Gleichzeitig werden für Chunks, die nun im Radius sind, neue Knoten erzeugt und deren Werte berechnet. 
Chunks, die sich weiterhin im gültigen Bereich befinden, bleiben unverändert im Cache und müssen nicht neu berechnet werden.

Dieses Prinzip lässt sich über die Kameraposition hinaus auf weitere extern kontrollierte Variablen verallgemeinern.
Für ein LOD-System kann die Entfernung zur Kamera genutzt werden, um die Detailstufe einzelner Objekte zu bestimmen. 
Für View Culling kann die Blickrichtung der Kamera als externe Variable genutzt werden, um nur sichtbare Weltbereiche zu generieren und nicht sichtbare zu verwerfen. 
Darüber hinaus können auch spielzustandsabhängige Variablen genutzt werden. 
Zum Beispiel ob ein bestimmtes Gebiet betreten wurde oder ein Ereignis eingetreten ist genutzt werden um Teile der Welt dynamisch zu laden oder zu verändern, ohne den den Rest der Welt neu zu errechnen.

Extern kontrollierte Variablen ermöglichen es damit, das System nicht nur für statische Änderungen am Generationsalgorithmus einzusetzen, sondern auch für dynamische auf den Spieler reagieren kann.

= Analyse

Die Bewertung eines Systems zur prozeduralen Generierung ist nicht trivial, da unterschiedliche Systeme häufig unterschiedliche Ziele verfolgen. Während einige Ansätze primär auf maximale Generationsgeschwindigkeit oder realistische Ergebnisse optimiert sind, liegt der Fokus dieser Arbeit auf der effizienten Neuberechnung nach Änderungen am Generationsalgorithmus. Ziel ist es, bei kleinen Änderungen am Generationsprozess möglichst große Teile der bereits berechneten Welt wiederverwenden zu können.

Im nächsten Abschnitt wird die theoretische Laufzeitcomplexität und des Systems analysiert.  

Um meine die reale Reduktion der Neuberechnungszeit zu untersuchen wird benchmarks auf meheren Beispiel Welten durchgeführt und 
es wird abgeschätzt wie viel Overhead das System gegen eine minimale Implementierung eines Generationsbespiel hat. 

Neben den reinen Laufzeiteigenschaften spielt auch die Nutzerfreundlichkeit des Systems eine Rolle. Durch den grafischen Editor lassen sich komplexe Abhängigkeiten oft leichter überblicken als in klassischem Quellcode.
Gleichzeitig erhöht dieser Ansatz jedoch auch die Komplexität des Systems. Während klassischer Programmcode sehr flexibel ist und ohne zusätzliche Struktur auskommt, erfordert der hier vorgestellte Ansatz eine explizite Modellierung aller Abhängigkeiten im Graphen.

Im dritten sollte die Aufwand zu Erweiterung des Systems betrachtet werden. 
Meine Implementation nutzt nur simple Operationen auf CSGs. Dies entspricht nicht den wirklichen Datenstrukturen und Problemen in Spielen oder Simulationen. 
Daher würde eine Große Menge an weiteren Operationen und Datentypen implement werden müssen.


== Theoretische Laufzeit

Die Kern Idee des System ist das der Generationsalgorithmus der Welt als Abhängigkeits-Graph definiert ist. 
Angenommen der Abhängigkeits-Graph hat $a$ Knoten. 
Die errechneten Ergebnisse von manchen Knoten im Abängigkeits-Graph werden zwischen gespeichert dies ist durch den Cache-Graph definiert. 
Angenommen dieser hat $c$ Knoten wobei $c <= a$ ist.
Wir definieren einen Cache-Faktor als $c_f := c / a$.
Ein Knoten im Abhängigkeits-Graph kann mehrere Knoten im Generator haben und jeder dieser Knoten kann wieder mehrere Kinder Knoten für ein Kind im Abhängigkeits-Graph haben. Daher definieren wir einen Branche-Faktor $b_f$ der die durchschnittliche Menge an Kindern pro Abhängigkeits-Knoten definiert. Zu letzt müssen bei einer Änderung des Abhängigkeits-Graph nur manche Knoten neu errechnet werden.
Den Faktor der zu neu errechnen Knoten im Generator nennen wir $g_f$.

Somit ist die Laufzeitcomplexit einer Errechnung nach Template-Änderung oder Änderung einer externen Variabel: 
$ O(((a c_f)^(b_f)) / g_f) = O(a^(b_f)) $

Dagegen ist die Laufzeit ein Template zu errechnen $O(a^2)$. 
Die quadratische Laufzeit entsteht da pro Cache-Knoten die relativen Pfade errechnet werden müssen. 
Bei großen Welten mit vielen Details kann $b_f$ wesentlich größer als 2 sein und Faktoren im Bereich von $10-100$ sind nicht unrealistisch.


== Reduktion der Neuberechnungszeit

#import "@preview/lilaq:0.6.0" as lq

Um die Reduktion der Neuberechnungszeit zu bewerten wird untersucht, wie stark sich die Laufzeit im Vergleich zu einer vollständigen Neugenerierung reduziert. 

#ba_image("../assets/full.png", 100%, [])
#ba_image("../assets/full_graph.png", 100%, [])

#figure(lq.diagram(
  lq.hviolin(
    (15, 18, 16, 14, 18, 23, 20, 21, 17, 21),
    (11, 17, 16, 18, 22, 18, 14, 18, 17),
    (5, 4.5, 6.1, 5.4, 4, 5, 5.8, 4.6, 6),
    (4, 5, 4.9, 7.7, 4.6, 4.4, 9, 4.5, 5.3, 5.5),
    y: (4, 3, 2, 1),
    trim: false,
    extrema: false,
    boxplot: none,
  ),
  xlabel: [Neuberechnungszeit (ms)],
  ylabel: [Stelle im Graph],
),
  caption: [Unterschied der Neuberechnungszeit zwischen verschiedenen geänderten Stellen im Graph]
)

Stellen: 
- 4 ganz linke Box2D Node
- 3 mittlere Path2D Node
- 2 untere Disk Node 
- 1 Sphere Node der Baum Krone auf der rechten Seite

In diesem Beispiel sieht man das Neuberechnungszeit nicht linear abfällt, sonder alle Änderungen wo die Wege und Bäume neu berechnet werden müssen im Durchschnitt 17ms benötigen wohin Änderungen die nur das finale Volumen betreffen um Durchschnitt 5ms benötigen.
Somit lässt sich davon ausgehen das die Berechnung der Wege und Bäume ca. 12ms benötigt, welche weg fallen wenn die zwischengespeicherten Daten verwendet werden.

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


== Nutzerfreundlichkeit

Durch den grafischen Editor kann der Generationsprozess als Abhängigkeits-Graph visualisiert und direkt bearbeitet werden. 
Dadurch lassen sich komplexe Zusammenhänge zwischen einzelnen Operationen häufig leichter nachvollziehen als in klassischem Quellcode, 
da Datenflüsse und Abhängigkeiten explizit dargestellt sind.

Insbesondere bei der experimentellen Entwicklung von Generationsalgorithmen kann dieser Ansatz Vorteile bieten. 
Änderungen am Graphen können direkt im Editor vorgenommen werden, ohne dass der gesamte Algorithmus neu implementiert werden muss. 
In Kombination mit der minimalen Neuberechnung des Generators können Anpassungen am Generationsprozess schnell getestet werden, 
da nur die betroffenen Teile der Welt neu berechnet werden.

Gleichzeitig hängt die wahrgenommene Nutzerfreundlichkeit stark vom jeweiligen Nutzertyp ab. 
Nutzer mit viel Erfahrung in klassischer Softwareentwicklung bevorzugen häufig eine direkte Implementierung in Quellcode, 
da diese mehr Kontrolle bietet und weniger strukturelle Einschränkungen hat. 
Für weniger erfahrene Nutzer oder für Anwender, die primär konzeptionell arbeiten möchten, 
kann ein grafischer Editor hingegen zugänglicher sein. 

Die visuelle Darstellung der Abhängigkeiten erleichtert das Verständnis des Systems und erlaubt es, Generationslogik zu definieren, ohne sich stark mit den Details einer Programmiersprache beschäftigen zu müssen. 

Allerdings kann ein solcher Editor auch einschränkend wirken, da nur die im System vorgesehenen Operationen und Strukturen genutzt werden können.

Insgesamt bietet der grafische Ansatz insbesondere für komplexe prozedurale Systeme Vorteile, da er eine bessere Übersicht über den Generationsprozess ermöglicht und iterative Änderungen am Algorithmus erleichtert, während klassische Code-basierte Ansätze weiterhin mehr Flexibilität für erfahrene Entwickler bieten.


== Erweiterbarkeit

Um das System um weitere Operationen oder oder Datentype zu erweitern ist ein gutes Verständnis der Codestruktur benötigt.
Jedoch sind keine grundlegenden Änderungen nötigt. 
Der Editor, das Template und der Generator stellen keine Erwartungen an die Art der Datentypen oder Operationen im Abhängigkeits Graph. 
Die Datentypen und Operationen sind mit Typed Unions implement daher können diese einfach erweitert werden.
Jedoch muss die neue Variation an jeder Stelle wo ein Datentyp oder Operation allgemein verwendet wird implementiert werden
um sie in das bestehende Netz an möglichen Abhängigkeiten zu intrigieren.


= Future Work

== Nullwerte führen zu leeren Lösungen
Da der Null Wert per definition eine valider Wert ist kann es dazu kommen, dass sich ein Abhängigkeits-Kreis zu null als Lösung entwickelt, auch wenn es theoretisch andere Lösungen gebe. 
Um dies zu lösen müsste ein anderer Ansatz zur Lösung von Abhängigkeits-Kreisen genutzt werden. 

Arbeiten in Richtung closely connected Components in Verbindung könnten hier eine Lösung sein.

== Andere Datenstrukturen
Wie schon in @output_datastructure beschrieben eignen sich CSGs nicht zum direkten rendering.
Die Umwandlung zu einem Mesh mit "marching cubes" ist aufwendig und benötigt wesentlich mehr Leistung benötigen, als die Generation selbst.
Somit besteht weiterhin die Forschungsfrage in wie weit minimale Neuberechnung von prozeduralen Meshen direkt möglich ist.

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
Dabei müsste jedoch sichergestellt werden, dass Schreibzugriffe auf den Generator-Graphen thread-sicher sind, ohne dabei zu viel Overhead durch Synchronisation zu benötigen.

== Automatische Cache-Optimierung
Aktuell muss der Nutzer manuell entscheiden, welche Knoten im Abhängigkeitsgraph gecacht werden sollen. 
Ein zu sparsames Caching führt dazu, dass bei Änderungen viele Knoten neu berechnet werden müssen, während ein zu großzügiges Caching unnötig viel Speicher verbraucht und den Overhead erhöht.

Ein interessanter Forschungsansatz wäre ein System, das diese Entscheidung automatisch trifft. 
Dazu könnte der Generator zur Laufzeit messen, wie häufig ein Knoten wiederverwendet wird und wie aufwendig seine Berechnung ist. 
Basierend auf diesen Metriken könnte das System dynamisch entscheiden, welche Knoten gecacht werden sollen. 

== Skalierung auf sehr große Welten
Die vorliegende Arbeit evaluiert das System anhand vergleichsweise kleiner Beispielwelten. 
Es bleibt offen, wie das System mit sehr großen Welten skaliert, die aus tausenden gleichzeitig aktiver Chunks und sehr tiefen Abhängigkeitsgraphen bestehen. 
Bei sehr großen Welten könnte dies zu erheblichem Speicherverbrauch führen. 
Zukünftige Arbeiten sollten untersuchen, wie ein solches System auf gesamten Spielwelten agiert.

== Integration in bestehende Engines
Diese Arbeit stellt ein System vor welches Spiel- oder Simulations-Engine einbettbar sein soll. 
Jedoch wurde die Frage einer Integration in eine bestehende Game Engine nicht behandelt.

Zukünftige Arbeiten sollten untersuchen, welche Schnittstellen eine Engine bereitstellen muss und welcher Integrationsaufwand in bestehende Engines wie Unity oder Unreal Engine entsteht. 
Dabei sind insbesondere die Synchronisation zwischen dem Generator und dem Render-Thread sowie die Übergabe extern kontrollierter Variablen wie Kameraposition oder Spielzustand relevante Fragestellungen.

== Serialisierung und Persistenz
In der aktuellen Implementation existieren gecachte Zwischenergebnisse nur im Arbeitsspeicher und gehen beim Beenden der Anwendung verloren.
Für einen praktischen Einsatz wäre es jedoch hilfreich, den Zustand des Generator-Graphen auf Disk zu speichern. 
So könnten bereits berechnete Teile der Welt beim nächsten Start der Anwendung wiederverwendet werden, ohne sie vollständig neu berechnen zu müssen. 
Dabei stellen sich Fragen zur effizienten Serialisierung großer Graphstrukturen sowie zur Invalidierung gespeicherter Ergebnisse, wenn sich das Template zwischen zwei Sitzungen geändert hat.

= Fazit

In dieser Arbeit wurde gezeigt, dass minimale Neuberechnung für prozedurale Generierung grundsätzlich möglich ist. 
Die Beispielimplementation zeigt, dass sich ein Generationsalgorithmus als Abhängigkeitsgraph darstellen lässt und Zwischenergebnisse gezielt wiederverwendet werden können. Ändert sich ein Teil des Algorithmus, müssen nur die betroffenen Knoten neu berechnet werden.

Jedoch da der Algorithmus als Graph interpretiert wird statt direkt als kompilierten Code ausgeführt zu werden, ist er deutlich langsamer als eine direkte Implementierung. 
In den Benchmarks war eine optimierte direkte Implementierung etwa 3 - 6x schneller. Dieser Overhead entsteht vor allem durch das rekursive Auflösen der Abhängigkeiten und die polymorphe Natur des Graphen.
Dazu kommt, dass der Aufwand zur Implementierung aller benötigten Operationen und Datentypen. 

Trotzdem bietet mein Ansatz mein ein graphisches Interface um Prozedurale Generationsalgorithen interaktiv zu entwickeln. 
Es bietet eine vereinfachte Abstraktions-Ebene zum testen von Generationslogik die keine Wissen über Programmiersprachen benötigt. 

Für einen realen Einsatz in einem Spiel oder einer Simulation würde ist mein Ansatz sinnvoll, wenn der Generationsalgorithmus für eine prozedurale Welt Personen von entwickelt werden soll die nicht umfassend programmieren können und sehr interaktiv jede Änderung testen wollen.

#show bibliography: set heading(numbering: "1")
#bibliography("citations.bib")

#include "./layout/eigenständigkeit.typ"

#include "./layout/ai_disclaimer.typ"


