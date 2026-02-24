
= Lazy Generation

Ich habe mich basierend auf Paul Merrell's Arbeit der Frage gestellt ob es möglich ist 
ein Model-Synthesis artigen Regelsatz "lazy" zu regenerieren.

Angenommen eine Model-Synthesis artiges Gengenerations System wird in einer Game Engine genutzt um die Welt von einem Spiel zu erzeugen.
Der Spielentwickler entwirft oder passt die Regeln selber an. 

Wenn der Spielentwickler eine Regel ändert kann es sein das Bestandteile der Welt nicht mehr den Regeln entsprechen. 

Nun müsste er eine neue Welt generieren lassen um zu sehen was die angepassten Regeln bewirken. 
Dies ist gerade nachteilhaft, wenn die Regeln viele Zufall erlauben und zwei generierte Welten sehr verschieden aussehen können.

Daher ist meine Forschungsfrage: 
Ist es möglich ein Generations-System wie Model-Synthesis zu entwerfen,
welches die Welt nur so viel wie nötig ändert um die Regeln wieder zu erfüllen.


