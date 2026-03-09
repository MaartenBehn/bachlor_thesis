#import "../layout/ba.typ": *

= Future Work

== Nullwerte führen zu leeren Lösungen
Da der Null Wert per definition eine valider Wert ist kann es dazu kommen, dass sich ein Abhängigkeits-Kreis zu null als Lösung entwickelt, auch wenn es theoretisch andere Lösungen gebe. 
Um dies zu lösen müsste ein anderer Ansatz zur Lösung von Abhängigkeits-Kreisen genutzt werden. 

Arbeiten in Richtung closely connected Components in Verbindung könnten hier eine Lösung sein.

== Andere Datenstrukturen

Wie schon in @output_datastructure beschrieben eignen sich CSGs nicht zum direkten rendering.
Die Umwandlung zu einem Mesh mit "marching cubes" ist aufwendig und mehr wesentlich mehr Leistung benötigen, als die Generation selbst.
Somit besteht weiterhin die Forschungsfrage in wie weit minimale Neuberechnung von prozeduralen Meshen möglich ist.



