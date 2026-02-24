#import "../layout/ba.typ": *

=== Example based Model Synthesis 

Eine spannende Arbeit im Bereich "constraint based generation" ist Paul Merrels "Example-based Model Synthesis".
@model_synthesis

Die Idee des Algorithmus ist aus einem kleinen Input-Datensatz eine größere Struktur zu erzeugen die lokal den gleichen Regeln folgt. 

Dabei besteht der Input-Datensatz aus einer Gitter Struktur, wo jede Celle im Gitter ein Wert zu geordnet wird. 
Nun wird eine Liste aller Nachbar Kombinationen erstellt die im Input Input-Datensatz vorkommen. 
Diese Liste beschreibt die Regeln nachdem ein neues Modell erzeugt wird. 

Generations Algorithmus:
1. Dabei dem Gitter des neuen Modells in jeder Zelle alle Werte zugeordnet. 
2. Wähle die Zelle mit den wenigsten Werten aus und entferne alle bis auf einen. 
3. Entferne alle Werte aus den Nachbar Zellen für die eine Regel nicht mehr erfüllt ist.
4. Wiederhole 3. für jede Nachbar Zelle bei der Werte entfernt wurden. 
5. Wiederhole 2. bis alle Zellen nur noch einen Wert enthalten.


