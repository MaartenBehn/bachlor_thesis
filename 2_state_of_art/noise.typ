
== Noise & Zufälligkeit <noise_based_generation>

Ein sehr verbreiteter Ansatz zur prozeduralen Generierung von Welten basiert auf der Verwendung von Noise-Algorithmen. Typischerweise werden hierfür kontinuierliche Noise-Algorithmen wie Perlin-Noise oder Simplex-Noise verwendet. Daher wird die Struktur der generierten Welt nicht durch explizite Regeln beschrieben, sondern ergibt sich aus einer überlagerung meherer Noise Funktionen mit unterschiedlichen Frequenzen und Amplituden.

Noise-basierte Verfahren sind relativ leicht zu implementieren und skalieren gut auf große Welten. Aus diesem Grund werden sie häufig in Spielen und Simulationssystemen eingesetzt, insbesondere zur Generierung von Gelände, Vegetation oder anderen natürlichen Strukturen.

Ein wesentlicher Nachteil von rein zufallsbasierten Generationsverfahren besteht darin, dass komplexe strukturelle Regeln nur schwer garantiert werden können. Da die schwer vorher zu sagen ist wie die Noise Funktionen in sonder Fällen zusammen spielen, ist es schwierig sicherzustellen, dass bestimmte globale oder semantische Anforderungen immer erfüllt werden.

Dies kann dazu führen, dass in seltenen Fällen unerwünschte oder fehlerhafte Strukturen entstehen, beispielsweise unzugängliche Bereiche, unnatürliche Geländeformationen oder inkonsistente Weltstrukturen. Solche Probleme lassen sich häufig nur durch zusätzliche heuristische Korrekturen oder nachträgliche Validierungsschritte beheben.

Ein weiterer Nachteil im Kontext dieser Arbeit ist, dass die Regeln der Generierung implizit in der komposition der Noise Funktionen enthalten ist. Wenn der Algorithmus verändert wird, ist es daher schwierig zu bestimmen, welche Teile einer bereits generierten Welt noch gültig sind und welche neu berechnet werden müssen.
