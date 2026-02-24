#import "../layout/ba.typ": *

= Future Work

== Nullwerte führen zu leeren Lösungen
Da der Null Wert per definition eine valider Wert ist kann es dazu kommen, dass sich ein Abhängigkeits-Kreis zu null als Lösung entwickelt, auch wenn es theoretisch andere Lösungen gebe. 
Um dies zu lösen müsste ein anderer Ansatz zur Lösung von Abhängigkeits-Kreisen genutzt werden. 

Arbeiten in Richtung closely connected Components in Verbindung könnten hier eine Lösung sein.


== Ein system nutzen was nicht auf CSG basiert um danach nicht ein Mesh oder Voxel model errechnen zu müssen? 
