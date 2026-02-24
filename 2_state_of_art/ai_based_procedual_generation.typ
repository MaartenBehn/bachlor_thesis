#import "../layout/ba.typ": *

=== KI basierte prozedurale Generation
Neuronale Netzwerke können genutzt werden um ähnliche Inhalte zu einem Trainings Datensatz zu erzeugen. 
In Arbeiten wie @evolvingmariolevels @Level_Generation_with_Constrained_Expressive_Range und @Compressing_and_Comparing_the_Generative_Spaces_of_Procedural_Content_Generators werden Neuronale Modelle genutzt um Levels aus bekannten 2D Spielen zu reproduzieren. 
Dabei wird in @evolvingmariolevels wird ein Level generations Model gegen ein Spieler Argent Modell trainiert, welches bewertet ob ein Level spielbar ist. 
Der Ansatz ist meistens fähig spielbare Levels zu generieren, wobei es vereinzelt zu generation Artefakten kommen kann.
@evolvingmariolevels[S. 7]

Jedoch behandelt die Ansätze simple 2D Spiele, für die es viel vorhandene Level zu trainieren gibt. @evolvingmariolevels[S. 2]  
#todo("Ist simple das richtige Wort?")

In dem Ansatz wir außerdem gezeigt, dass Messbare Level Eigenschaften, wie die Menge der benötigten Sprünge genutzt werden können um "spannendere" Level zu generieren. @evolvingmariolevels[S. 7]


@Level_Generation_with_Constrained_Expressive_Range
- Analyse von der Möglichen validen Level eines 2D Mario spiels um unterschiedliche spannende Level zu erzeugen.

==== Terrain Diffusion
@terraindiffusion

- Weiter Entwicklung von Noise Funktionen für Gelände generation.  
- Es KI Modelle sind teilweise schneller als komplexe Noise Layer Systeme.
- Haben Geografische Erddaten als Input Datensatz verwendet.

==== Mit LLM Reden 
@Conversational_Interactions_with_Procedural_Generators

- Aktuelle LLMs können sind fähig text basierte Darstellungen von Spiel Welten zu generieren und verstehen.
- Jedoch können sie nicht direkt mit Level Daten oder Tile Maps umgehen. Bzw dann generieren sie keine validen Ergebnisse

==== Umsetzung von generations Regeln in KI basierten Ansätzen

Bei der prozeduralen generation mit KI Systemen werden generations Regeln meist nicht explizit definiert. 
Sie ergeben sich aus dem Trainings-Datensatz und den Bewertungs Methoden der Modells in "Adversarialen" Ansätzen. 
#todo("Sollte ich KI sagen oder genauer sein?")
Nachhaltig sicherzustellen, dass alle erwünschten Generationsregeln eingehalten werden, bleibt ein Bereich in dem Aktiv geforscht wird.  

==== Bewertung

KI basierte Ansätze zur prozeduralen Generation sind ein sich aktiv entwickelnder Bereich indem 

- Kann nur reproduzieren was schon vorhanden ist bzw benötigt größere Mengen an Input Daten. 
-> Schränk Kreativität ein, obwohl man auch argumentieren kann, dass meist wiedererkennbare Strukturen generiert werden sollen, 
sodass die nicht wirklich ein Problem ist. 
Und durch geschickte Kombination bekannter Erdstrukturen kann viel neues erzeugt werden.

- Schwer weitere Regeln direkt einzubauen.

- Grundsätzlich ist es schwer dafür zu sorgen das Neuronale-Netzwerke nur valide Lösungen erzeugen, gerade wenn die Regeln komplex werden. 

