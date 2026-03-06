#import "../layout/ba.typ": *

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

== Einen Prozeduralen Algorithmus als Template darstellen

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

=== Ergebnis Mengen

Operationen im Abhängigkeits-Graph $G_"ab"$ können auch Mengen an Werten erzeugen. 
In meiner implementation ist das die beiden Operationen die ein Gitter und zufällige Positionen in einem Volumen errechnen. 

Nun kann es sein, dass die weiteren Operationen pro Element in dieser Menge ausgeführt werden sollen. 
Dies ist der Bestandteil von prozeduraler Generation der es möglich immer feinere Details zu generieren.
Zu Beispiel errechnet man eine Menge an Positionen an den Apfelbäume stehen sollen 
und dann generiert man pro Baum die Positionen der Äpfel.




== Generator

Der Collapser enthält einen Graphen der den errechneten Template entspricht.
Dazu eine Queue an Aufträgen der noch zu erzeugenden und errechnenden Knoten. Diese Listen sind nach Level der Knoten sortiert. 
Der Collapser führt die Aufträge der Queue iterativ aus bis es keine Aufträge mehr gibt.

==== Formale Definition

$"Collapser" := (G_"col", Q)$

Ein $v in V(G_"col")$ hat folgende Eigenschaften: 

$N^-_G_"col" (v) := "Collapser Knoten die zur Errechnung benötigt werden."$

$t(v) := "Der Template Knoten der dem Collapser Knoten entspricht."$

$"created"(v) := "Der Knoten der diesen Knoten erzeugt hat."$

$v_i in N^-_G_"col" (v) quad "data"(v, v_i) := "Der Wert des ahängigen Knoten der diesem Knoten zu geordnet ist."$


$Q$ ist die Queue in Aufträgen 
Jeder Auftrag $q in Q$ hat ein Level $l(q)$. 
Dieses entspricht bei Erzeugungs-Aufträgen dem Level des zeugenden Knoten 
und bei Errechnungs-Aufträgen das Level des des zu errechnen Knoten.

$"pop"(Q) := min_(q in Q) (l(q))$


==== Erzeugungs Aufträge 
Erzeugungs Aufträge enthalten den Index eines Knoten im Collapser Graph und den Index eines Erzeugungs-Eintrag in dessen Template-Knoten.
Dieser Erzeugungs-Eintrag definiert entweder dass es genau $n$ Knoten geben soll, oder die Zahl vom Datentypen abhängt.

Darauf wird die vorhandene Menge an Kindern mit der gewünschten Menge verglichen und bei Ungleichheit neue Kinder Knoten erzeugt / gelöscht. 

#todo("Algorithmus")

==== Wenn ein Knoten erzeugt wird 
Wenn ein Knoten erzeugt werden die Knoten von dem er im Template abhängt im Collapser-Graph gesucht.
Hierfür werden die vorerrechneten relativen Schritte verwendet die wie eine Weganweisung dienen um den Collapser-Graph von dem neu erzeugten Knoten zu sein Abhängigkeiten zu gelangen.  

#todo("Algorithmus")

==== Wenn ein Knoten gelöscht wird
Wenn ein Knoten gelöscht wird werden rekursiv alle Knoten gelöscht die von ihm abhängen. 

#todo("Algorithmus")


=== Errechnungs Aufträge 
Errechnungs Aufträge errechnen den Wert von einem Knoten neu. 

Dabei wird die der DAG der die Formel des Wert beschreibt rekursiv gelöst.

Wenn die Formel Hooks zu anderen Template Knoten enthält werden die entsprechenden Knoten in der Liste der Abhängigen Knoten des "Collapser" Knoten gesucht und die Werte zu Errechnung der Formel genutzt. 

Grundlegende Eigenschaft des Systems ist das es mehrere Knoten im Collapser für einen Knoten im Template geben kann.
Und so einen für eine Hook eine Liste an Werten gefunden wird. 

Daher sind alle Operationen zum errechnen der Formel als Operationen auf Listen geschrieben.

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

=== Vorrechnete Schritte zu Abhängigkeiten

Um zu vermeiden, dass im Collapser alle Knoten durchsucht werden müssen um die abhängigen Knoten zu finden, 
werden speichert jeder Knoten im Abhängigkeits-Graph die relativen Schritte zu den Knoten von den er abhängig ist. 

Um nun die alle abhängigen Knoten im Collapser Graph zu finden können diese Relativen Schritte wie eine Wegbeschreibung genutzt werden.

#todo("Vielleicht ein Beispiel")

==== Implementierung 

In der Implementierung wird zwischen geschnittenen und nicht geschnittenen Abhängigkeiten unterschieden.

Die nicht geschnittenen Abhängigkeiten sind als ein Baum an Schritten implementiert. 
Schritte gehen entweder hoch in ein Knoten vom dem dieser abhängig ist, oder runter ein einen Knoten der von diesem abhängt. 

Wenn ein neuer Knoten im Collapser erzeugt wird, wird der Baum genutzt um alle abhängigen Knoten im Collapser zu finden.

Geschnittene Abhängigkeiten werden als Weg an Schritten gespeichert und erst gesucht, wenn deren Wert benötigt wird, 
Geschnittene Abhängigkeiten haben ein höheres Level als der Knoten selbst und existieren zur Zeit des Knoten wahrscheinlich noch nicht.


