#import "../layout/ba.typ": *

== Implementation 

Für die Beispiel Implementation habe ich Rust als Sprache gewählt, 
da sie erlaubt speichersicheren low level code zu schreiben um die Laufzeit von Algorithm effektiv zu verbessern 
und ein in Gegensatz zu C++ ein umfassenden leicht zu nutzenden Package-Manager hat.  

=== Stabiele Listen
Alle Graphen sind mit stabilen Listen implementiert.

Eine stabile Listen ist eine sich automatisch vergrößerndes Array. 
Wenn dass aktuelle Array voll ist wird ein größeres Array alloziert und die werte mit einer memcopy Operation rüber kopiert.
Dazu änderen sich die Indexe von Elementen in stabilen Listen nicht.
Wenn ein Element entfernt wird, werden die weiteren Elemente nicht aufgeschoben um die Lücke zu schließen, stattdessen wird der Index des nächsten freien Element gespeichert.
Dazu speichert die List speichert den Index des ersten freien Element, welches genutzt wird wenn ein neues Element eingefügt wird. 
Der dort gespeicherte nächste freie Index wird dann als erster freier Index gespeichert.
Dies erlaubt Einfüge-, Entfernungs- und Zugriffslaufzeit von $O(1)$. 

Dazu wird pro Element eine Versionsnummer gespeichert. 
Bei einem Zugriff wird die Version des Index mit der Version des Elements an der Stelle des Index verglichen. 
So bleiben Indexe valide solange das Element in der Liste ist und es wird erkannt wenn man mit veralteten Index zugreift. 

Die oberen 32Bit des Indexes werden genutzt um Versionsnummer zu speichern.
Somit können in einer stabilen List $2^32$ Elemente gespeichert werden.

Stabiele Listen erlauben Graphen effizient als Listen darzustellen, indem in den Knoten die Indexe der anderen Knoten gespeichert werden zu den Kanten existieren. Stabiele listen sind dabei wesentlich schneller als HashMaps.
@slotmap_crate


=== Multi Threading

Der Collapser sowie die Sampeling Operationen werden in asynchronous Workern ausgeführt. 
Zur Kommunikation werden Channel verwendet. @channels_theory & @async_channel

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
@smallvec_crate

=== Output Datenstruktur <output_datastructure>

Das Kernconzept, einen sehr großen Graphen der eine prozeduralen Algorithmus darstellt, zu bearbeiten, indem man die Abhängigkeiten in einem vergleichbar kleinen Template nutzt, enthält keine konkreten Anahmen über die Art der Geometrie. 
In meiner Implementation habe ich CSG genutzt, da es einer sehr allgemeine Form ist, Volumen darzustellen und diese leicht zu bearbeiten sind.

Gerade CSGs mit vielen Knoten sind jedoch nicht performant zu rendern. 
Deshalb können die CSGs in meiner Implementation entweder als Sparse Voxel DAGs oder mit marching cubes gesampled werden.

Voxel Datenstrukturen können relativ effizient mit ray marching geraytraced werden. 
@dda @nvidia_octree

Mit Hilfe von marching cubes kann ein CSG als Mesh approximiert werden. 
@marching_cubes



