# Script de nettoyage du projet NASCENTIA
# Supprime les fichiers temporaires et inutilisés

Write-Host "Nettoyage du projet NASCENTIA" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# 1. Supprimer les fichiers temporaires tmpclaude-*
Write-Host "Suppression des fichiers temporaires tmpclaude-*..." -ForegroundColor Yellow
$tmpFiles = Get-ChildItem -Path . -Filter "tmpclaude-*" -File -ErrorAction SilentlyContinue
if ($tmpFiles) {
    foreach ($file in $tmpFiles) {
        Remove-Item $file.FullName -Force
        Write-Host "  Supprime: $($file.Name)" -ForegroundColor Green
    }
    Write-Host "  Total: $($tmpFiles.Count) fichiers temporaires supprimes" -ForegroundColor Green
}
else {
    Write-Host "  Aucun fichier temporaire trouve" -ForegroundColor Gray
}
Write-Host ""

# 2. Supprimer le script obsolète run-dev-with-env.ps1
Write-Host "Suppression du script obsolete run-dev-with-env.ps1..." -ForegroundColor Yellow
if (Test-Path "run-dev-with-env.ps1") {
    Remove-Item "run-dev-with-env.ps1" -Force
    Write-Host "  Supprime: run-dev-with-env.ps1" -ForegroundColor Green
}
else {
    Write-Host "  Fichier deja supprime" -ForegroundColor Gray
}
Write-Host ""

# 3. Supprimer restore_files.py
Write-Host "Suppression de restore_files.py..." -ForegroundColor Yellow
if (Test-Path "restore_files.py") {
    Remove-Item "restore_files.py" -Force
    Write-Host "  Supprime: restore_files.py" -ForegroundColor Green
}
else {
    Write-Host "  Fichier deja supprime" -ForegroundColor Gray
}
Write-Host ""

# 4. Supprimer run-dev.ps1 si existe
Write-Host "Verification de run-dev.ps1..." -ForegroundColor Yellow
if (Test-Path "run-dev.ps1") {
    Remove-Item "run-dev.ps1" -Force
    Write-Host "  Supprime: run-dev.ps1" -ForegroundColor Green
}
else {
    Write-Host "  Fichier n'existe pas" -ForegroundColor Gray
}
Write-Host ""

Write-Host "Nettoyage termine!" -ForegroundColor Green
Write-Host ""
Write-Host "Prochaines etapes suggerees:" -ForegroundColor Cyan
Write-Host "  1. Archiver les fichiers de documentation si les phases sont terminees" -ForegroundColor White
Write-Host "  2. Executer 'flutter clean' si necessaire" -ForegroundColor White
Write-Host "  3. Commiter les changements avec git" -ForegroundColor White
Write-Host ""
