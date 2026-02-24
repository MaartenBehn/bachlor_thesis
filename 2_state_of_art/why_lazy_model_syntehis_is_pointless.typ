
=== Lazy Model Systhesis 

- Meine Erste Idee 

- Man generiert ein valide Welt mit dem mit Model Systhesis 

- Nun ändern sich die Regeln 

- Man geht über alle Felder welche nicht valide Regeln haben. 

- Nun müsste man in der Idee von Model-Systhesis wieder andere Werte zu diesen Feldern hinzufügen 

- Aber welche? Alle? 

- Das Hauptproblem: Die neu Hinzugefügten Werte sind erstmal auch nicht valide. Zu den Nachbarn müssten auch Werte hinzugefügt werden, damit sie valide sind. 

- Das Problem gilt dann aber auch wieder für die Nachbarn. Und so weiter 

- Wenn man einfach für alle Nachbarn alle Werte hinzufügt, hat man wieder das Komplett unentschiedene Feld normalen Model-Systhesis Algorithmus das bietet kein Vorteil. 

- Also müsste man ein Menge an Feldern finden den man jeweils wieder Werte pro Feld hinzufügt, wo alle Regel eingehalten werden, damit mann dann wieder Model-Systhesis laufen lassen kann. 

- Diese Menge müsste möglichst minimal sein. 

- Vorallem sollte die Laufzeit-komplexität zum errechnen dieser Menge kleiner sein als Model-Systhesis selbst. 

- Die einzige Idee die mir eingefallen ist um dies zu lösen: 
  - Eine Breiten suche über ein Graph aller möglichen Werte die wir hinzufügen können. Um die erste valide Menge zu finden. 
  - Das ist schrecklich was laufzeit und auch space Komplexität angeht.

- Der Vorteil von Model-Systhesis ist das in jedem Schritt alle Kombinationen an Werten eine valide Lösung ist. 
- Aber diese Menge zu suchen ist sehr schwer. 


