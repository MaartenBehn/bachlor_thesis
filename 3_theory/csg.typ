#import "../layout/ba.typ": *

== Constructive Solid Geometry (CSG)

Constructive Solid Geometry (CSG) ist eine Methode zur Darstellung von Volumen, bei der komplexe Geometrien durch die Kombination primitiver Geometry (Box, Kugel, etc) dargestellt wird.

Diese Kombination sind standartmäßig Vereinigung, Schnittmenge und Differenz, wurden jedoch in späteren Arbeiten mit komplexeren Operationen,
wie Verformung, Duplikation, etc erweitert.

CSGs werden als directed acyclic graph (DAG) gespeichert. 
Jede Knoten is eine implizierte Operation auf den Volumen der Kinder. 
Die Blätter sind dahingegen durch Parameter definierte primitive Geometrien.

Der Vorteil dieser Darstellung ist, dass Geometrie über Parameter und Operationen beschrieben wird. Änderungen an Position, Größe oder anderen Parametern wirken sich direkt auf das resultierende Volumen aus, ohne dass die gesamte Geometrie neu definiert werden muss.

Jedoch eignen sich CSGs selten zum direkten rendering mit raytracing, da die Operationen zu leistungsaufwendig sind um mit jeden Ray den DAG 
zu rekursiv zu iterieren. Dazu steigt die Größe des DAGs schnell mit der Komplexität des CSGs. 
@csg_original @csg_advanced

