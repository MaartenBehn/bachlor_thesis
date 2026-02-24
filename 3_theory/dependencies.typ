#import "../layout/ba.typ": *

== Abhängigkeiten

=== Prozedurale Generation aus der Design Sicht 
- Rekursiv 
- Abhängigkeiten werden schnell komplex 
- Dependency Injektion 

Die Entscheidung ob in einer prozeduralen Welt ein Objekt existiert, bzw wo es plaziert werden soll, 
hängt davon ab wie der Rest der Welt generiert wird.

Zum Beispiel wenn man einen Wald mit einem Netz an Wegen generieren möchte, könnte es mehrere Abhängigkeiten geben. 
- Ein Baum sollte in Mindestabstand zu jedem anderem Baum haben. 
- Ein Baum sollte ein Mindestabstand zu jedem Weg haben. 
- Zwei Wege sollten nicht direkt nebeneinander laufen. 

Nun stellt sich die Frage wie man dies effizient generieren kann. 

Der üblichste Weg ist einen Algorithmus zu finden der iterativ die Bestandteile entscheidet. 
Der Algorithmus ist dabei so gewählt das er für jedes Bestandteil nur Ergebnisse erzeugt, die alle Abhängigkeiten einhalten. 


An dem Beispiel würde als ersten Schritt ein Netz an Wegen generiert werden. 
Hierbei würde ein Algorithmus gewählt werden der intrinsisch alle benötigten Beschränkung einhält. 

Dafür würde sich z.B. Passions Disk Sampling für die Position der Knoten anbieten, um einen Mindestabstand zwischen den Knoten sicherzustellen. 

Nun könnten alle Knoten mit einem Abstand in einem bestimmten Bereich mit einem Weg verbunden werden. 
So könnten unrealistisch kurzen oder langen Wegen vorgebeugt werden.  

Jedoch kann es Beschränkungen geben, die nicht intrinsisch von einem generations System eingehalten werden. 

z.B. um Vorzubeugen, dass zwei Wege direkt nebeneinander parallel laufen, müssten im nach hinein unerwünschte Wege raus gefiltert werden. 

Wurde nun so ein valides Weg Netz gefunden, kann dieses genutzt werden um Bäume nur an Stellen zu plazieren, wo kein Weg ist. 

Dieses System zu generation von Welten ist sehr weit verbreitet. 
Dabei werden die Algorithmen und parameter so gewählt, das meist ein realistisches Ergebnisse erzeugt wird. 

Jedoch da die Kern-Beschränkungen meist nur indirekt zugesichert werden, kann es zu Fehlerhaften Welten kommen. 

#todo("Beispiel broken Minecraft Seeds")
#todo("Doppelung mit state of art")

== Systeme, die alle Abhängigkeiten sicherstellen. 

#note("Das ist sehr wichtig")

=== Linear Programming 

#todo("Erklärung")

=== Model Synthesis

#todo("Erklärung")

=== Problem 

- Zu schlechte Laufzeit Komplexität 
- Zu schlechte Speicher Komplexität
- Können nur auch endlichen Mengen an Parametern arbeiten
  - Bei Model Synthesis wird diese durch Das Gitter und die Endliche Menge an Werten sichergestellt.









Man könnte jeden möglichen Zustand von jedem möglichen Objekt als ein Knoten in einem Graph modellieren. 
Wenn man nun eine Kante für jede Abhängigkeit zwischen zwei möglichen Zuständen definiert


