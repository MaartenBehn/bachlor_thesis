#import "../layout/ba.typ": *

== Kern Idee

Die Idee ist das die gesamte zu generierende Welt als Graph an Operationen definiert. 
Operationen errechnen aus eine Menge an Input Werten in eine Menge an Output Werten. 

Beispiel für Operationen sind: 
- Addition
- Erzeugung einer Kugel aus Position und Größe
- Union zweier Volumen
- etc

Operationen nutzen die Ergebnisse von anderen Operationen und bilden so ein Graph an Abhängigkeiten.

Bei der Errechnung werden die Ergebnisse der Operations Knoten zwischen gespeichert. 

Wenn sich nun der Abhängigkeits-Graph minimal ändert entspricht das vorherige Ergebnis potenziell nicht mehr dem Abhängigkeits-Graph.
Dies verstehe ich in dem Rest der Arbeit als eine invalide Lösung/Ergebnis. 

Jedoch muss durch die zwischen Speicherung nicht den ganze Graph neu errechnet werden, sondern nur den Teil der nicht mehr valide ist. 

Die Kern Leistung meiner Arbeit ist die Entwicklung einer effizienten Implementierung für dieses Modell.

