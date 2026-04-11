
== Houdini & Blender Geometry Nodes
Werkzeuge wie SideFX Houdini und Blender Geometry Nodes verfolgen einen ähnlichen Ansatz wie das in dieser Arbeit vorgestellte System: 
Generationslogik wird nicht als klassischer Programmcode, sondern als visueller Abhängigkeitsgraph definiert. 
In Houdini wird dies durch das sogenannte „Procedural Dependency Graph"-Modell realisiert, bei dem jede Operation als Knoten dargestellt wird und Änderungen an einem Knoten automatisch nur die davon abhängigen Teile des Graphen neu berechnen. 
Dieser Mechanismus kommt dem Kernziel dieser Arbeit konzeptuell sehr nahe. 
Blender Geometry Nodes verfolgt ein ähnliches Prinzip im Kontext der 3D-Modellierung. 
Beide Systeme sind jedoch primär auf die interaktive Erstellung einzelner Assets ausgelegt und nicht auf die prozedurale Generation großer zusammenhängender Welten mit tausenden von Elementen. 
Zudem sind beide Systeme geschlossene allgemeine Werkzeuge die nicht darauf ausgelegt sind in eine Spiel- oder Simulations-Engine eingebettet zu werden. 
Das in dieser Arbeit vorgestellte System hingegen zielt explizit auf diesen Kontext ab, da der Generationsalgorithmus dort iterativ weiterentwickelt wird und Änderungen schnell in einer bereits bestehenden Welt sichtbar sein sollen.
