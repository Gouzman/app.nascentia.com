# Script de diagnostic et correction Smart App Control pour Flutter
# Auteur: Claude
# Date: 2026-03-26

Write-Host "=== Diagnostic Smart App Control pour Flutter ===" -ForegroundColor Cyan
Write-Host ""

# Vérifier les privilèges administrateur
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ATTENTION: Ce script doit être exécuté en tant qu'administrateur." -ForegroundColor Red
    Write-Host "Clic droit sur PowerShell > Exécuter en tant qu'administrateur" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Appuyez sur Entrée pour quitter"
    exit 1
}

# Vérifier l'état de Smart App Control
Write-Host "1. Vérification de Smart App Control..." -ForegroundColor Yellow
$sacState = (Get-MpComputerStatus).SmartAppControlState
$regValue = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -ErrorAction SilentlyContinue).VerifiedAndReputablePolicyState

Write-Host "   État Smart App Control: $sacState" -ForegroundColor White
Write-Host "   Valeur registre (VerifiedAndReputablePolicyState): $regValue" -ForegroundColor White
Write-Host ""

if ($sacState -eq "On" -or $regValue -eq 1) {
    Write-Host "Smart App Control est ACTIF - c'est lui qui bloque Flutter." -ForegroundColor Red
    Write-Host ""

    Write-Host "SOLUTIONS DISPONIBLES:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "A) Désactivation via interface graphique (RECOMMANDÉ)" -ForegroundColor Green
    Write-Host "   1. Paramètres > Confidentialité et sécurité" -ForegroundColor White
    Write-Host "   2. Sécurité Windows > Contrôle d'application" -ForegroundColor White
    Write-Host "   3. Mettre sur 'Désactivé'" -ForegroundColor White
    Write-Host "   4. REDÉMARRER Windows" -ForegroundColor White
    Write-Host ""
    Write-Host "B) Désactivation via registre (RISQUÉ)" -ForegroundColor Yellow
    Write-Host "   Modification directe du registre Windows" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "Choisissez (A/B/Q pour quitter)"

    switch ($choice.ToUpper()) {
        "A" {
            Write-Host ""
            Write-Host "Ouverture des paramètres Sécurité Windows..." -ForegroundColor Yellow
            Start-Process "ms-settings:windowsdefender"
            Write-Host ""
            Write-Host "Suivez les étapes ci-dessus, puis:" -ForegroundColor Green
            Write-Host "1. Désactivez Smart App Control" -ForegroundColor White
            Write-Host "2. Redémarrez Windows" -ForegroundColor White
            Write-Host "3. Relancez ce script pour vérifier" -ForegroundColor White
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour quitter"
            exit 0
        }
        "B" {
            Write-Host ""
            Write-Host "AVERTISSEMENT: Modification du registre Windows" -ForegroundColor Red
            Write-Host "Êtes-vous sûr ? Cette action modifie directement le registre." -ForegroundColor Yellow
            $confirm = Read-Host "Tapez OUI en majuscules pour confirmer"

            if ($confirm -eq "OUI") {
                try {
                    Write-Host "Désactivation de Smart App Control via registre..." -ForegroundColor Yellow
                    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -Name "VerifiedAndReputablePolicyState" -Value 0
                    Write-Host "✓ Registre modifié avec succès" -ForegroundColor Green
                    Write-Host ""
                    Write-Host "IMPORTANT: Vous DEVEZ redémarrer Windows maintenant." -ForegroundColor Red
                    Write-Host ""
                    $restart = Read-Host "Redémarrer maintenant ? (O/N)"

                    if ($restart.ToUpper() -eq "O") {
                        Write-Host "Redémarrage dans 10 secondes..." -ForegroundColor Yellow
                        shutdown /r /t 10 /c "Redémarrage pour désactiver Smart App Control"
                    }
                    else {
                        Write-Host "N'oubliez pas de redémarrer manuellement !" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Host "✗ Erreur lors de la modification: $_" -ForegroundColor Red
                }
            }
            else {
                Write-Host "Opération annulée." -ForegroundColor Yellow
            }
            exit 0
        }
        default {
            Write-Host "Annulation." -ForegroundColor Yellow
            exit 0
        }
    }
}
else {
    Write-Host "✓ Smart App Control est désactivé ou en mode évaluation." -ForegroundColor Green
    Write-Host ""
}

# Vérifier les binaires Flutter
Write-Host "2. Vérification des binaires Flutter bloqués..." -ForegroundColor Yellow
$impellercPath = "C:\flutter\bin\cache\artifacts\engine\windows-x64\impellerc.exe"
$fontSubsetPath = "C:\flutter\bin\cache\artifacts\engine\windows-x64\font-subset.exe"

if (Test-Path $impellercPath) {
    $sig = Get-AuthenticodeSignature $impellercPath
    Write-Host "   impellerc.exe: $($sig.Status)" -ForegroundColor $(if ($sig.Status -eq "NotSigned") { "Yellow" } else { "Green" })
}
else {
    Write-Host "   impellerc.exe: Non trouvé" -ForegroundColor Red
}

if (Test-Path $fontSubsetPath) {
    $sig = Get-AuthenticodeSignature $fontSubsetPath
    Write-Host "   font-subset.exe: $($sig.Status)" -ForegroundColor $(if ($sig.Status -eq "NotSigned") { "Yellow" } else { "Green" })
}
else {
    Write-Host "   font-subset.exe: Non trouvé" -ForegroundColor Red
}
Write-Host ""

# Vérifier les événements de blocage récents
Write-Host "3. Vérification des blocages récents (Code Integrity)..." -ForegroundColor Yellow
$recentBlocks = Get-WinEvent -LogName "Microsoft-Windows-CodeIntegrity/Operational" -MaxEvents 5 -ErrorAction SilentlyContinue |
Where-Object { $_.Message -like "*impellerc*" -or $_.Message -like "*font-subset*" } |
Select-Object -First 3

if ($recentBlocks) {
    Write-Host "   ✗ Blocages détectés dans les dernières 5 entrées:" -ForegroundColor Red
    foreach ($block in $recentBlocks) {
        Write-Host "     - $($block.TimeCreated): ID $($block.Id)" -ForegroundColor White
    }
}
else {
    Write-Host "   ✓ Aucun blocage récent détecté" -ForegroundColor Green
}
Write-Host ""

# Test Flutter
Write-Host "4. Test de Flutter..." -ForegroundColor Yellow
Write-Host "   Tentative: flutter doctor -v" -ForegroundColor White
Write-Host ""

Push-Location "C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com"
try {
    $flutterTest = flutter doctor -v 2>&1 | Out-String
    if ($flutterTest -match "ProcessException.*contrôle.*application") {
        Write-Host "✗ Flutter est toujours bloqué par Smart App Control" -ForegroundColor Red
        Write-Host "  Vous devez désactiver SAC et redémarrer Windows." -ForegroundColor Yellow
    }
    elseif ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Flutter fonctionne correctement !" -ForegroundColor Green
        Write-Host ""
        Write-Host "Vous pouvez maintenant lancer:" -ForegroundColor Cyan
        Write-Host "  flutter run -d chrome" -ForegroundColor White
    }
    else {
        Write-Host "? Flutter a renvoyé un code d'erreur, mais pas de blocage SAC détecté." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "✗ Erreur lors du test Flutter: $_" -ForegroundColor Red
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "=== Diagnostic terminé ===" -ForegroundColor Cyan
Write-Host ""
Read-Host "Appuyez sur Entrée pour quitter"
