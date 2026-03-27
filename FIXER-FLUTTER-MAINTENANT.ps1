# Script de correction automatique Smart App Control + Flutter
# DOIT être exécuté en ADMINISTRATEUR
# Auteur: Claude - 2026-03-26

$Host.UI.RawUI.WindowTitle = "Fix Flutter - Smart App Control"
Clear-Host

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CORRECTION FLUTTER - SMART APP CONTROL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERREUR: Script non exécuté en administrateur !" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solution:" -ForegroundColor Yellow
    Write-Host "1. Appuyez sur Win + X" -ForegroundColor White
    Write-Host "2. Cliquez sur 'Terminal (Admin)' ou 'PowerShell (Admin)'" -ForegroundColor White
    Write-Host "3. Relancez ce script" -ForegroundColor White
    Write-Host ""
    pause
    exit 1
}

Write-Host "[1/5] Vérification Smart App Control..." -ForegroundColor Yellow
$sacState = (Get-MpComputerStatus).SmartAppControlState
$regValue = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -ErrorAction SilentlyContinue).VerifiedAndReputablePolicyState

Write-Host "      État actuel: $sacState (registre: $regValue)" -ForegroundColor Gray

if ($sacState -eq "On" -or $regValue -eq 1) {
    Write-Host "      >> Smart App Control est ACTIF - Désactivation..." -ForegroundColor Red

    try {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -Name "VerifiedAndReputablePolicyState" -Value 0 -ErrorAction Stop
        Write-Host "      >> Registre modifié avec succès !" -ForegroundColor Green
        $needsReboot = $true
    } catch {
        Write-Host "      >> ERREUR: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Désactivation manuelle requise:" -ForegroundColor Yellow
        Write-Host "Paramètres > Sécurité Windows > Contrôle d'application > Désactivé" -ForegroundColor White
        pause
        exit 1
    }
} else {
    Write-Host "      >> Smart App Control est déjà désactivé" -ForegroundColor Green
    $needsReboot = $false
}

Write-Host ""
Write-Host "[2/5] Ajout exclusion Defender pour Flutter..." -ForegroundColor Yellow
try {
    Add-MpPreference -ExclusionPath "C:\flutter" -ErrorAction SilentlyContinue
    Write-Host "      >> Exclusion ajoutée: C:\flutter" -ForegroundColor Green
} catch {
    Write-Host "      >> Avertissement: Impossible d'ajouter l'exclusion" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[3/5] Vérification des binaires Flutter..." -ForegroundColor Yellow
$binaries = @(
    "C:\flutter\bin\cache\artifacts\engine\windows-x64\impellerc.exe",
    "C:\flutter\bin\cache\artifacts\engine\windows-x64\font-subset.exe"
)

foreach ($bin in $binaries) {
    if (Test-Path $bin) {
        $sig = Get-AuthenticodeSignature $bin
        $status = if ($sig.Status -eq "NotSigned") { "Non signé" } else { $sig.Status }
        Write-Host "      >> $(Split-Path $bin -Leaf): $status" -ForegroundColor Gray
    } else {
        Write-Host "      >> $(Split-Path $bin -Leaf): Non trouvé (sera téléchargé)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[4/5] Nettoyage cache Flutter..." -ForegroundColor Yellow
Push-Location "C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com"
try {
    flutter clean 2>&1 | Out-Null
    Write-Host "      >> Cache nettoyé" -ForegroundColor Green
} catch {
    Write-Host "      >> Impossible de nettoyer (pas critique)" -ForegroundColor Yellow
}
Pop-Location

Write-Host ""
Write-Host "[5/5] Décision finale..." -ForegroundColor Yellow

if ($needsReboot) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  REDÉMARRAGE WINDOWS OBLIGATOIRE" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Smart App Control a été désactivé, mais Windows" -ForegroundColor White
    Write-Host "DOIT être redémarré pour que le changement prenne effet." -ForegroundColor White
    Write-Host ""
    Write-Host "Après le redémarrage:" -ForegroundColor Cyan
    Write-Host "  cd C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com" -ForegroundColor White
    Write-Host "  flutter run -d chrome" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "Redémarrer maintenant ? (O/N)"

    if ($choice.ToUpper() -eq "O") {
        Write-Host ""
        Write-Host "Redémarrage dans 10 secondes..." -ForegroundColor Yellow
        Write-Host "Fermez vos applications et sauvegardez vos fichiers !" -ForegroundColor Red
        Start-Sleep -Seconds 3
        shutdown /r /t 10 /c "Redémarrage pour désactiver Smart App Control - Flutter"
        exit 0
    } else {
        Write-Host ""
        Write-Host "IMPORTANT: Redémarrez manuellement avant d'utiliser Flutter !" -ForegroundColor Red
        Write-Host ""
        pause
        exit 0
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  CORRECTION TERMINÉE !" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Smart App Control était déjà désactivé." -ForegroundColor White
    Write-Host ""
    Write-Host "Test de Flutter..." -ForegroundColor Yellow

    Push-Location "C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com"
    Write-Host ""

    $testResult = flutter doctor 2>&1 | Out-String

    if ($testResult -match "ProcessException.*4551") {
        Write-Host ""
        Write-Host "PROBLÈME: Flutter est toujours bloqué !" -ForegroundColor Red
        Write-Host ""
        Write-Host "Vérifiez que Smart App Control est bien désactivé:" -ForegroundColor Yellow
        Write-Host "Paramètres > Sécurité Windows > Contrôle d'application" -ForegroundColor White
        Write-Host ""
        Write-Host "Si désactivé, REDÉMARREZ Windows manuellement." -ForegroundColor Red
    } else {
        Write-Host ""
        Write-Host "Flutter fonctionne correctement !" -ForegroundColor Green
        Write-Host ""
        Write-Host "Vous pouvez maintenant lancer:" -ForegroundColor Cyan
        Write-Host "  flutter run -d chrome" -ForegroundColor White
        Write-Host ""
    }

    Pop-Location
    Write-Host ""
    pause
}
