# Solution urgente : Désactiver Smart App Control

## Le problème
Smart App Control bloque `impellerc.exe` et empêche Flutter de fonctionner.
Code erreur : 4551 (stratégie de contrôle d'application)

## Solution EXPRESS (5 minutes)

### Étape 1 : Ouvrir PowerShell en administrateur
1. Appuyez sur **Windows + X**
2. Cliquez sur **Terminal (Admin)** ou **PowerShell (Admin)**
3. Cliquez sur **Oui** pour autoriser

### Étape 2 : Désactiver via registre
Copiez-collez cette commande dans PowerShell admin :

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -Name "VerifiedAndReputablePolicyState" -Value 0; Write-Host "Smart App Control désactivé - REDÉMARRAGE OBLIGATOIRE" -ForegroundColor Green
```

### Étape 3 : Redémarrer Windows
```powershell
shutdown /r /t 60 /c "Redémarrage pour désactiver Smart App Control"
```

*(Redémarre dans 60 secondes - vous pouvez annuler avec: `shutdown /a`)*

---

## Après le redémarrage

Lancez simplement :
```powershell
flutter run -d chrome
```

Flutter fonctionnera normalement.

---

## Alternative : Via interface graphique

Si la méthode registre ne fonctionne pas :

1. **Windows + I** → Paramètres
2. **Confidentialité et sécurité** → **Sécurité Windows**
3. **Contrôle d'application et du navigateur**
4. Sous **Contrôle d'application intelligent**, cliquez sur **Paramètres**
5. Sélectionnez **Désactivé**
6. **Redémarrez Windows**

---

## Vérification après redémarrage

Pour confirmer que Smart App Control est bien désactivé :

```powershell
(Get-MpComputerStatus).SmartAppControlState
```

Doit afficher : **Off** ou **Eval**

---

## Note importante

**Smart App Control ne peut PAS être réactivé une fois désactivé** (sauf réinstallation de Windows).
C'est une limitation Windows, pas un problème du script.
