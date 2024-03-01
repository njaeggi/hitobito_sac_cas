# Onboarding Prozess

![Ablaufdiagramm](ablaufdiagramm.svg)

In dem Ablaufdiagramm sind alle Schritte durch runde schwarze Icons und entsprechende Bezeichnungen repräsentiert. Diese Icons und Bezeichnungen stehen jeweils für einen spezifischen Schritt im Onboarding-Prozess.

### Legende
| Icon | Bedeutung |
|------|------|
|  Zahnrad  | Schritte, welche das System automatisch macht. |
|  Einzelne Person  | Schritte, welche von einem Aktör manuell durchgeführt werden. |
|  Zwei Personen  | Gruppen, in welche die neu regstrierte Person verschoben wird. |
| Häkchen | Die Bedingung wurde erfüllt. |
| Briefumschlag | Es wird eine Mail verschickt |





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
- A5: Es wird eine Rechnung in Abacus erstellt
- A6: Alle Kriterien werden im Hintergrund immer wieder überprüft, bis diese alle erfüllt sind. Sobald alle Kriterien erfüllt sind, wird die Person als Mitglied aufgenommen und der Onboarding Prozess endet hier. Genaue Angaben zu den Bedingungen findet man bei B1, B2 und B3

### Sektions-Mitgliederverwaltung-Schritte
- MV1: Person wird kotnrolliert und kann angenommen oder abgelehnt werden. Wenn abgelehnt endet der Onboarding Prozess hier.

### Zentralverband-Mitgliederverwaltung-Schritte
- ZMV1: Erkannte Duplikate werden geprüft und zusammengefügt.

### Mails
- M1: Diese Mail bittet das neue Mitglied darum die email Adresse zu bestätigen und ein Passwort für ein Login zu setzen.
- M2: Neues Mitglied erhält Mail, um mitzuteilen das es eine neue rechnung gibt, die bezahlt werdne sollte.
- M3: Diese Mail informiert das neue Mitglied, das es erfolgreich als Mitglied aufgenommen wurde.

### Bedingungen
- B1: Bei dieser Bedingung geht es darum das eine neue Person ein aktives Login besitzen muss, um als Mitglied aufgenommen werden zu können.
- B2: Eine neu registrierte Person muss den Mitgliederbeitrag bezaghlen, um als Mitglied aufgenommen zu werden.
- B3: Eine neu registrierte Person darf kein Duplikat, eine Duplikatsprüfung wird automatisch von Hitobito gemacht, um Duplikate direkt zu erkennen.

## Familien
Beim Onboarding Prozess können ebenfalls Familien direkt erfasst werden, die Berechnung des Mitgliederbeitrags passiert automatisch. Auch der Prozess läuft gleich ab, nur ist jede Person der Familie eine einzelne Person, welche danach auf Duplikate überpüft werden und in die jeweiligen Neuanmeldungsgruppen hinzugefügt werden.
