#import "../layout/ba.typ": *

== Implementation 

#question("Wie viel will ich überhaupt auf sowas eingehen?")

=== Stabiele Listen
Alle Graphen sind mit stabilen Listen implementiert.

Eine stabile Listen ist eine sich automatisch vergrößerndes Array. 
Wenn dass aktuelle Array voll ist wird ein größeres Array alloziert und die werte mit einer memcopy Operation rüber kopiert.
Dazu änderen sich die Indexe von Elementen in stabilen Listen nicht.
Wenn ein Element entfernt wird, werden die weiteren Elemente nicht aufgeschoben um die Lücke zu schließen sondern in der Lücke wird der Index des nächsten besetzten Element notiert. 
Dazu wird pro Element eine Versionsnummer gespeichert. 
//Die oberen 32 bit des Index entsprechend dieser Version. 
Bei einem Zugriff wird die Version des Index mit der Version des Elements an der Stelle des Index verglichen. 
So bleiben Indexe valide solange das Element in der Liste ist und es wird erkannt wenn man mit veralteten Indexen zugreift. 

Stabiele Listen erlauben Graphen effizient als Listen darzustellen, indem in den Knoten die Indexe der anderen Knoten gespeichert werden zu den Kanten existieren. Stabiele listen sind dabei wesentlich schneller als HashMaps.

#todo("Quelle")

Mit der Versionierung der Indexe können invalide Kanten sicher erkannt werden. 

=== Multi Threading

Der Collapser sowie die Sampeling Operationen werden in asynchronous Workern ausgeführt. 
Zur Kommunikation werden Channel verwendet. 
#todo("Quelle")

Der Composer läuft im Render Thread und errechnet bei jeder Änderung das aktuelle Template. 
Dieses Template wird über ein Channel zum Collapser gesendet. Wenn der Channel noch ein altes Template enthält werden die Änderungen Notizen des alten Template zum neuen hinzugefügt und das Template wird ersetzt. 

Die errechnete CSG Darstellung der Welt wird mit einem weiteren Channel an die Sampler gesendet, welche dieses in ein Voxel DAG oder Mesh umrechnet und auf die GPU gelanden. 

Wenn die neue Welt hochgenanden wurde wird der Render Thread über ein Channel über diese Änderung informiert. 

=== Small Vectors

Für die Zwischenspeicherung der Werte werden Small Vectors verwendet. 
Diese haben die Eigenschaft, dass die ersten N Elemente direkt auf dem Stack alloziert werden. 
Erst wenn diese voll sind wird ein Array auf dem Stack alloziert. 

Da alle Werte müssen als Liste behandelt werden, da ein Knoten immer von mehreren Knoten für ein Input abhängt.
Jedoch enthält diese Listen meist doch nur ein Element. 
Small Vectoren erlauben für diese Fälle die Stack allozieren zu sparen und bieten bessere Cache Lokalität. 


=== Output Datenstruktur
==== Direkt CSG Rendering 

==== Voxel sampeling 
#todo("Sollte ich auf die Implementation und Datenstruktur ein gehen? Warscheinlich nicht.")

- Minimale Änderungen im CSG führen zu nur minimaler Neuerrechnung des Voxel DAGs 

==== Meshing 

- Minimale Änderungen im CSG führen zu nur minimaler Neuerrechnung des Meshes
