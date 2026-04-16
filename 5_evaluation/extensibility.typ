
== Erweiterbarkeit

Um das System um weitere Operationen oder oder Datentype zu erweitern ist ein gutes Verständnis der Codestruktur benötigt.
Jedoch sind keine grundlegenden Änderungen nötigt. 
Der Editor, das Template und der Generator stellen keine Erwartungen an die Art der Datentypen oder Operationen im Abhängigkeits Graph. 
Die Datentypen und Operationen sind mit Typed Unions implement daher können diese einfach erweitert werden.
Jedoch muss die neue Variation an jeder Stelle wo ein Datentyp oder Operation allgemein verwendet wird implementiert werden
um sie in das bestehende Netz an möglichen Abhängigkeiten zu intrigieren.


