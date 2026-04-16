
== Houdini & Blender Geometry Nodes

Programme wie Houdini und Blender Geometry Nodes nutzen Abhängigkeits-Graph Systeme wie in dieser Arbeit vorgestellt.
Dabei werden auch Zwischenergebnisse gespeichert und wiederverwendet um die Laufzeit zu verbessern. 
Jedoch sind beide System auf die interaktive Erstellung einzelner Assets ausgelegt und nicht auf die prozedurale Generation großer zusammenhängender Welten mit tausenden von Elementen.  
Zudem sind dies geschlossene Programme die nicht darauf ausgelegt sind in eine Spiel- oder Simulations-Engine eingebettet zu werden. 
Das in dieser Arbeit vorgestellte System hingegen zielt explizit auf diesen Kontext ab, da der Generationsalgorithmus dort iterativ weiterentwickelt wird und Änderungen schnell in einer bereits bestehenden Welt sichtbar sein sollen.
