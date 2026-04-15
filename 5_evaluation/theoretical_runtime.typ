
== Theoretische Laufzeit

Die Kern Idee des System ist das der Generationsalgorithmus der Welt als Abhängigkeits-Graph definiert ist. 
Angenommen der Abhängigkeits-Graph hat $a$ Knoten. 
Die errechneten Ergebnisse von manchen Knoten im Abängigkeits-Graph werden zwischen gespeichert dies ist durch den Cache-Graph definiert. 
Angenommen dieser hat $c$ Knoten wobei $c <= a$ ist.
Wir definieren einen Cache-Faktor als $c_f := c / a$.
Ein Knoten im Abhängigkeits-Graph kann mehrere Knoten im Generator haben und jeder dieser Knoten kann wieder mehrere Kinder Knoten für ein Kind im Abhängigkeits-Graph haben. Daher definieren wir einen Branche-Faktor $b_f$ der die durchschnittliche Menge an Kindern pro Abhängigkeits-Knoten definiert. Zu letzt müssen bei einer Änderung des Abhängigkeits-Graph nur manche Knoten neu errechnet werden.
Den Faktor der zu neu errechnen Knoten im Generator nennen wir $g_f$.

Somit ist die Laufzeitcomplexit einer Errechnung nach Template-Änderung oder Änderung einer externen Variabel: 
$ O(((a c_f)^(b_f)) / g_f) = O(a^(b_f)) $

Dagegen ist die Laufzeit ein Template zu errechnen $O(a^2)$. 
Die quadratische Laufzeit entsteht da pro Cache-Knoten die relativen Pfade errechnet werden müssen. 
Bei großen Welten mit vielen Details kann $b_f$ wesentlich größer als 2 sein und Faktoren im Bereich von $10-100$ sind nicht unrealistisch.

