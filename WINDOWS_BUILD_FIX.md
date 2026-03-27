# Fix: Erreur "Une stratégie de contrôle d'application a bloqué ce fichier"

## Problème
Windows bloque l'exécution de `impellerc.exe` (compilateur de shaders Flutter) avec l'erreur:
```
ProcessException: Une stratégie de contrôle d'application a bloqué ce fichier
Command: C:\flutter\bin\cache\artifacts\engine\windows-x64\impellerc.exe
```

## ✅ Solution 1: Exécuter PowerShell en Administrateur (RECOMMANDÉ)

**C'est la solution la plus simple et la plus sûre.**

1. **Fermez VS Code** (important!)
2. **Ouvrez le menu Démarrer** → Tapez "PowerShell"
3. **Clic droit** sur "Windows PowerShell"
4. **Sélectionnez** "Exécuter en tant qu'administrateur" 
5. **Acceptez** le contrôle de compte d'utilisateur (UAC)
6. **Naviguez** vers le projet:
   ```powershell
   cd C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com
   ```
7. **Lancez le build**:
   ```powershell
   .\build-prod.ps1
   ```

## ✅ Solution 2: Ajouter une Exception Windows Defender

**Si vous ne pouvez pas exécuter en administrateur à chaque fois.**

1. **Ouvrez PowerShell EN TANT QU'ADMINISTRATEUR** (voir étapes ci-dessus)
2. **Naviguez** vers le projet:
   ```powershell
   cd C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com
   ```
3. **Exécutez** le script de fix:
   ```powershell
   .\fix-windows-defender.ps1
   ```
4. **Une fois l'exception ajoutée**, vous pourrez builder normalement:
   ```powershell
   .\build-prod.ps1
   ```

## ✅ Solution 3: Exception Manuelle dans Windows Defender

**Si les solutions précédentes ne fonctionnent pas.**

1. **Ouvrez** Sécurité Windows → Protection contre les virus et menaces
2. **Cliquez** sur "Gérer les paramètres" sous "Paramètres de protection..."
3. **Faites défiler** jusqu'à "Exclusions"
4. **Cliquez** sur "Ajouter ou supprimer des exclusions"
5. **Ajoutez un dossier**: `C:\flutter`
6. **Confirmez** et réessayez le build

## ✅ Solution 4: Désactiver Temporairement la Protection

**⚠️ À utiliser en dernier recours uniquement!**

1. **Ouvrez** Sécurité Windows
2. **Désactivez** temporairement la protection en temps réel
3. **Lancez** le build rapidement
4. **Réactivez** immédiatement la protection après

## ❌ Ce qui NE fonctionne PAS

- ❌ `Unblock-File` sans droits administrateur
- ❌ `flutter clean` puis rebuild
- ❌ Relancer le build plusieurs fois
- ❌ Fermer/rouvrir VS Code

## 🎯 Pourquoi ce problème?

Windows 11 a renforcé ses politiques de sécurité. Le fichier `impellerc.exe` (compilateur de shaders) est considéré comme potentiellement dangereux car:
- Il est téléchargé par Flutter depuis Internet
- Il n'a pas de signature numérique Microsoft
- Il exécute du code natif (compilation de shaders GLSL)

## 📝 Note pour le futur

Une fois l'exception ajoutée via **Solution 2**, vous n'aurez plus jamais ce problème. C'est un paramétrage à faire **une seule fois** par machine.

## 🆘 Besoin d'aide?

Si aucune solution ne fonctionne:
1. Vérifiez que vous avez bien les **droits administrateur** sur votre machine
2. Contactez votre administrateur système (si machine professionnelle)
3. Vérifiez les **politiques de groupe** Windows (gpedit.msc)
