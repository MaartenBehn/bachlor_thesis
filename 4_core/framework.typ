#import "../layout/ba.typ": *
#import "@preview/cetz:0.4.2": canvas, draw, tree

== Framework

#todo("Overview diagramm")

Mein generations System besteht aus drei Bestandteilen. 
1. Ein Graphischer Editor indem ein Nutzer einen Abhängigkeits-Graph erstellen und bearbeiten kann. 

2. Das Template ist eine Datenstruktur die vom Editor erstellt wird und den Abhängigkeits-Graph sowie Informationen wie dieser generiert und zwischen gespeichert werden soll enthält.  

3. Der Generator vergleicht das aktuelle Template mit dem neuen Template und generiert die Bestandteile der Welt neu die nicht dem neuen Template entsprechen.

== Composer 

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
Dies ist eine Untermenge aller Knoten in $G_"ab"$. 

$V(G_"ch") subset V(G_"ab")$

Bei der Entscheidung wie groß diese Untermenge sein soll muss zwischen dem "Overhead" durch zwischengespeicherung und der Zeitersparniss durch wiederverwendung der Ergebnisse abgewägt werden. 

Die ein gehenden Nachbarn $N^-_G_"ch"$ sind alle caches von dem der Knoten abhängt. 
Man findet diese indem man den Baum der Abhängigkeiten in $G_"ab"$ über alle Verzweigungen rekursiv durchsucht bis man auf jeden Weg einen auf einen Knoten in $G_"ch"$ stößt.

#todo("Algorithmus angeben? eigentlich ist das nicht wichtig.")

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

Um mit dem Template eine Prozedurale Welt zu generieren haben ich mich entschieden, dass das Template final eine Volumen als 
constructive solid Geometry CSG errechnet.

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
In meiner implementation ist das die beiden Operationen die ein Gitter und zufällige Positionen in einem Volumen errechnen. 

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
Jedoch wo $G_"ch"$ nur einen Knoten pro Operation enthält, enthält $G_"gen"$ einen Knoten pro Ergebnis welches errechnet werden muss. 

#todo("Beispiel")

Dazu hält der Generator $:= (G_"gen", Q)$ eine Queue $Q$ die zwei Arten Aufträge auf $G_"gen"$ nach ihren Level sortiert.    
$
"pop"(Q) := min_(q in Q) (l(q))
$

Errechnungs-Aufträge errechnen den das Ergebnis eines Knoten in $G_"gen"$ und Kind-Update-Aufträge 
erzeugen oder löschen Kinder sodass sie dem Template entsprechen.

=== Abhängigkeite Werte im Generator Graph finden

Um einen Knoten in $G_"gen"$ zu errechnen benötigt man die Ergebnisse der Knoten in $G_"gen"$ von den dieser Knoten abhängt. 
Wie ich in @generation_of_template erklärt habe ist es Laufzeittechnisch nicht möglich diese mit z.B. einer Tiefensuche zu suchen.

Stattdessen wird für jeden Template Knoten $v in V(G_"ch")$ einer der Knoten von den er abhängt $N^-_G_"ch" (v)$ als Erstellungs-Knoten $v_c in V(G_"ch")$ im Template markiert $v_c = "create"(v)$.    

Um nun für einen Knoten $v_"gen" in V(G_"gen")$ alle anderen Knoten zu finden von er abhängt $N^-_G_"gen" (v_g)$. 
Werden im Template die relativen Schritte vom Erstellungs-Knoten zu den anderen Abhängigen Knoten gespeichert. 

Diese relativen Schritte nutzen nur Knoten die ein kleineres Level haben als $v_"gen"$. 
Da im Generator Knoten im Level aufsteigend erstellt werden, ist so sichergestellt das alle relativen Wegen existieren.
Die relativen Wege sind als Baum implementiert sodass per Tiefen-Suche alle anderen $N^-_G_"gen" (v_g)$ gefunden werden können.  

Für einen Knoten im Template kann es mehrere Knoten im Generator geben, daher können pro Abhängigkeit eines cache Knoten 
auch meherere Knoten im Generator gefunden werden.

/*
#canvas({
  import draw: *
  let encircle(i) = {
    std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .5em, std.move(dx: -.35em, dy: -.45em, [#i])))
  }

  set-style(content: (padding: 0.5em))
  tree.tree(
    ([Erstellungs-Knoten], (
        [Hoch in #encircle($2$)],
        ([Expression #encircle($1$)], `Int(1)`),
        `Plus`,
        ([Expression #encircle($2$)], `Int(2)`),
      ),
      `Lt`,
      ([Expression #encircle($4$)], `Int(4)`),
    ),
    direction: "up",
  )
})
*/

#todo("Exmaple relative Wege Datenstruktur")

=== Kind-Update-Aufträge 
Kind-Update-Aufträge enthalten den Index des Erstellungs-Knoten und den Index eines Erstellungs-Eintrag in dessen Template-Knoten.
Dieser Erstellungs-Eintrag definiert entweder dass es genau $n$ Knoten geben soll, oder die Menge vom Datentypen abhängt z.B. einen pro Position in Positions Menge. 
Darauf wird die vorhandene Menge an Kindern mit der gewünschten Menge verglichen und bei Ungleichheit neue Kinder Knoten erzeugt oder gelöscht. 

Wenn eine neuer Knoten erzeugt wird werden mit dem Baum an relativen Schritten die Indexe von allen abhängige Knoten gesucht und im Knoten gespeichert.

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

/*
==== Implementierung 

In der Implementierung wird zwischen geschnittenen und nicht geschnittenen Abhängigkeiten unterschieden.

Die nicht geschnittenen Abhängigkeiten sind als ein Baum an Schritten implementiert. 
Schritte gehen entweder hoch in ein Knoten vom dem dieser abhängig ist, oder runter ein einen Knoten der von diesem abhängt. 

Wenn ein neuer Knoten im Collapser erzeugt wird, wird der Baum genutzt um alle abhängigen Knoten im Collapser zu finden.

Geschnittene Abhängigkeiten werden als Weg an Schritten gespeichert und erst gesucht, wenn deren Wert benötigt wird, 
Geschnittene Abhängigkeiten haben ein höheres Level als der Knoten selbst und existieren zur Zeit des Knoten wahrscheinlich noch nicht.
*/

