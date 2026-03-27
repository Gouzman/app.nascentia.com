# ATTENTION: Ce script doit etre execute EN TANT QU'ADMINISTRATEUR
# Clic droit sur PowerShell -> Executer en tant qu'administrateur

Write-Host "[FIX] Ajout d'exception Windows Defender pour Flutter" -ForegroundColor Cyan

$flutterPath = "C:\flutter"

if (-Not (Test-Path $flutterPath)) {
    Write-Host "[ERREUR] Flutter non trouve a $flutterPath" -ForegroundColor Red
    exit 1
}

try {
    # Ajouter une exception pour tout le dossier Flutter
    Add-MpPreference -ExclusionPath $flutterPath -ErrorAction Stop
    Write-Host "[OK] Exception ajoutee pour: $flutterPath" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[INFO] Vous pouvez maintenant relancer le build:" -ForegroundColor Yellow
    Write-Host "  .\build-prod.ps1" -ForegroundColor Gray
    
} catch {
    Write-Host ""
    Write-Host "[ERREUR] ECHEC - PowerShell n'est PAS execute en administrateur!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Pour resoudre:" -ForegroundColor Yellow
    Write-Host "  1. Fermez cette fenetre PowerShell" -ForegroundColor Gray
    Write-Host "  2. Menu Demarrer -> Recherchez 'PowerShell'" -ForegroundColor Gray
    Write-Host "  3. CLIC DROIT sur 'Windows PowerShell'" -ForegroundColor Gray
    Write-Host "  4. Selectionnez 'Executer en tant qu'administrateur'" -ForegroundColor Gray
    Write-Host "  5. Acceptez le controle de compte utilisateur (UAC)" -ForegroundColor Gray
    Write-Host "  6. cd C:\Users\ccsrt\Documents\DEV\Projets\app.nascentia.com" -ForegroundColor Gray
    Write-Host "  7. .\fix-windows-defender.ps1" -ForegroundColor Gray
    Write-Host ""
    exit 1
}
