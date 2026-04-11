#import "../layout/ba.typ": *

== KI basierte prozedurale Generation
Neuronale Netzwerke können genutzt werden um ähnliche Inhalte zu einem Trainings Datensatz zu erzeugen. 
In Arbeiten wie @evolvingmariolevels @Level_Generation_with_Constrained_Expressive_Range und @Compressing_and_Comparing_the_Generative_Spaces_of_Procedural_Content_Generators werden Neuronale Modelle genutzt um Levels aus bekannten 2D Spielen zu reproduzieren. 
Dabei wird in @evolvingmariolevels wird ein Level generations Model gegen ein Spieler Argent Modell trainiert, welches bewertet ob ein Level spielbar ist. 
Der Ansatz ist meistens fähig spielbare Levels zu generieren, wobei es vereinzelt zu generation Artefakten kommen kann.
Jedoch behandelt die Ansätze simple 2D Spiele, für die es viel vorhandene Level zu trainieren gibt. 

=== Terrain Diffusion
Im Ansatz „Terrain Diffusion“ werden Neuronale-Diffusion-Modelle verwendet. Diffusion-Modelle erzeugen Daten, indem sie iterativ aus zufälligem Rauschen eine strukturierte Lösung rekonstruieren. Dieses Verfahren wird ursprünglich für Bildgenerierung eingesetzt, kann jedoch auch zur Erzeugung von Höhenkarten verwendet werden.

Hier wird ein neuronales Modell auf reale Geländedaten trainiert, sodass es realistische Terrainstrukturen erzeugen kann. Um weiterhin unendliche Welten generieren zu können, wird das Gelände in Kacheln erzeugt, die deterministisch aus einem Seed generiert werden. Dadurch können neue Bereiche der Welt bei Bedarf berechnet werden, ähnlich wie bei klassischen Noise-basierten Verfahren.

Der Vorteil dieses Ansatzes liegt darin, dass größere geographische Strukturen realistischer modelliert werden können als mit klassischen Noise-Funktionen.

Ein Nachteil ist jedoch, dass das Verhalten des Systems stark vom Trainingsdatensatz abhängt und Generationsregeln nicht explizit definiert sind. Dadurch ist es schwierig sicherzustellen, dass bestimmte strukturelle Anforderungen immer erfüllt werden.
@terraindiffusion

=== Minimale Neuberechnung
KI-basierte Ansätze teilen ein grundlegendes Problem: 
Die internen Repräsentationen neuronaler Modelle sind nicht interpretierbar. 
Es ist daher nicht nachvollziehbar, welche Teile der Eingabe oder welche Gewichte des Modells zu welchen Teilen des generierten Ergebnisses beitragen. 
Ändert sich ein Parameter oder eine Eingabe, gibt es keine Möglichkeit, daraus abzuleiten, welche Teile einer bereits generierten Welt noch gültig sind. 
Eine minimale Neuberechnung setzt jedoch genau dieses Wissen voraus. 
Aus diesem Grund werden KI-basierte Ansätze in dieser Arbeit nicht weiter betrachtet.

