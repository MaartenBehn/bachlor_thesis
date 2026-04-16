
== Noise & Zufälligkeit <noise_based_generation>

Viele prozedurale Generatoren nutzen Noise-Algorithmen um Welten zu erzeugen. 
Die Grundidee ist, mehrere Noise-Funktionen wie Perlin-Noise oder Simplex-Noise mit unterschiedlichen Frequenzen und Amplituden zu überlagern. 
Ein Berg entsteht zum Beispiel durch eine Noise-Funktion mit niedriger Frequenz und hoher Amplitude, während kleinere Details wie Steine durch eine Funktion mit hoher Frequenz und niedriger Amplitude hinzugefügt werden. 
Die Struktur der Welt ergibt sich also nicht aus expliziten Regeln, sondern aus dem Zusammenspiel dieser Funktionen.

Der praktische Vorteil ist, dass sich dieser Ansatz leicht implementieren lässt und gut auf große Welten skaliert. 
Minecraft nutzt zum Beispiel Perlin-Noise um sein Gelände und Höhlen effizient zu generieren.

Das Problem ist, dass sich mit Noise-Funktionen nur schwer globale Bedingungen garantieren lassen. 
Ob ein generiertes Gelände zum Beispiel immer einen zugänglichen Weg zwischen zwei Punkten hat, lässt sich aus den Noise-Funktionen allein nicht bestimmen. 
Solche Regeln müssen im im späteren Generations Schritten überprüft und die Welt gegeben Falls angepasst werden. 
Jedoch werden in vielen Generations Systemen diese Fehler einfach akzeptiert wenn sie nur selten auftauchen.

Für minimale Neuberechnung sind Noise-basierte Verfahren besonders ungeeignet, da theoretische jede Noise Ebene einfluss auf jedes Ergebniss hat. Die Generierungslogik steckt implizit in der Komposition der Funktionen. Ändert man eine Funktion oder ihre Parameter, kann dies eine Komplett andere Welt bedeuten.
