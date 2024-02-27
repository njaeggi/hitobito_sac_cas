# Onboarding

![Ablaufdiagramm]("ablaufdiagramm.drawio.svg")

In dem Ablaufdiagramm sind alle Schritte durch runde schwarze Icons und entsprechende Bezeichnungen repräsentiert. Diese Icons und Bezeichnungen stehen jeweils für einen spezifischen Schritt im Onboarding-Prozess.

### User-Schritte
- U1: Ich wähle auf sac-cas.ch meine gewünschte Sektion aus.
- U2: Ich fülle das Selbstregistrierungsformular auf z.B. db.sac-cas.ch/de/groups/942/self_registration aus und schicke dieses ab.
- U3: Ich bestätige meine Email und setze ein Passwort um ein gültiges Login zu erstellen.
- U4: Ich bezahle die erhaltene Rechnung für den Mitgliederbeitrag

### Automatische-Schritte
- A1: Die neue Person wird auf ein bereits vorhandenes Duplikat überprüft. Falls kein Duplikat existiert, hat die Person das Kriterium erfüllt.
- A2: Das System überprüft ob die gewünschte Sektion eine manuelle Freigabe von Personen verlangt.
- A3 (Wird ggf. übersprungen): Die Person wurde in die Gruppe **Neuanmeldungen (zur Freigabe)** hinzugefügt
- A4: Person wird in Gruppe **Neuanmeldungen** verschoben, diese Gruppe dient als Pufferliste
- A5: Es wird in ERD eine Rechnung erstellt
- A6: Alle Kriterien werden im Hintergrund immer wieder überprüft, bis diese alle erfüllt sind. Sobald alle Kriterien erfüllt sind, wird die Person als Mitglied aufgenommen und der Onboarding Prozess endet hier.

### Sektions-Mitgliederverwaltung-Schritte
- MV1: Person wird kotnrolliert und kann angenommen oder abgelehnt werden. Wenn abgelehnt endet der Onboarding Prozess hier.

### Zentralverband-Mitgliederverwaltung-Schritte
- ZMV1: Erkannte Duplikate werden geprüft und zusammengefügt.


## Familien
Beim Onboarding Prozess können ebenfalls Familien direkt erfasst werden, die Berechnung des Mitgliederbeitrags passiert automatisch. Auch der Prozess läuft gleich ab, nur ist jede Person der Familie eine einzelne Person, welche danach auf Duplikate überpüft werden und in die jeweiligen Neuanmeldungsgruppen hinzugefügt werden.