#import "../layout/ba.typ": *

== Beispiele 

Im Folgenden werden mehrere Beispiele vorgestellt, die die Funktionen des Systems demonstrieren. 
Dabei wird zuerst in minimalen Beispielen gezeigt wie das System teile der Generierten Welt wiederverwenden kann 
und danach eine komplexe Welt vorgestellt, welche den Umfang des Systems darstellt.

=== Nur finales Volumen neu errechnen

Das erste Beispiel generiert eine große Anzahl von Bäumen, die auf einem Gitter verteilt sind. Jeder Baum besteht aus einem Stamm (Zylinder) und einer Baumkrone (Kugel). Die Positionen aller Bäume werden aus einer Gitter-Operation berechnet und im Cache gespeichert. Die Form der Baumkrone wird als separate Operation im Abhängigkeitsgraphen modelliert.

Wenn nun die Form oder Größe der Baumkrone geändert wird betrifft diese Änderung nur den Teilgraphen, der die Krone berechnet. Dabei können die Positionen der Bäume wiederverwenden. Der Generator erkennt, dass nur die CSG-Volumen der Kronen ungültig sind, und berechnet ausschließlich diese neu.

#figure(
  image("../assets/trees.png", width: 80%),
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
