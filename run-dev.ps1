# Script de developpement local - NASCENTIA Web
# Lance un serveur HTTP local avec le build existant

Write-Host ""
Write-Host "Lancement du serveur de developpement NASCENTIA" -ForegroundColor Cyan
Write-Host ""

# Verifier que Python est disponible
$pythonCmd = $null
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonCmd = "python"
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    $pythonCmd = "python3"
}
else {
    Write-Host "Erreur: Python non installe" -ForegroundColor Red
    pause
    exit 1
}

# Verifier que le build existe
if (-not (Test-Path "build\web\index.html")) {
    Write-Host "Erreur: Aucun build web trouve" -ForegroundColor Red
    Write-Host "Lancez: flutter build web --release" -ForegroundColor Yellow
    pause
    exit 1
}

# Nettoyer les anciens serveurs Python sur port 8080
Write-Host "Nettoyage des anciens serveurs..." -ForegroundColor Gray
Get-Process python -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -eq "" } | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Milliseconds 500

# Verifier si serve-web.py existe
if (Test-Path "serve-web.py") {
    Write-Host "Serveur optimise avec support fonts" -ForegroundColor Green
    Write-Host "URL: http://localhost:8080" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Ouverture du navigateur dans 2 secondes..." -ForegroundColor Yellow
    Write-Host "Appuyez sur Ctrl+C pour arreter" -ForegroundColor Gray
    Write-Host ""

    # Lancer l'ouverture du navigateur en arriere-plan apres 2 secondes
    Start-Job -ScriptBlock {
        Start-Sleep -Seconds 2
        Start-Process "http://localhost:8080"
    } | Out-Null

    & $pythonCmd serve-web.py
}
else {
    Write-Host "Serveur HTTP simple" -ForegroundColor Green
    Write-Host "URL: http://localhost:8080" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Ouverture du navigateur dans 2 secondes..." -ForegroundColor Yellow
    Write-Host "Appuyez sur Ctrl+C pour arreter" -ForegroundColor Gray
    Write-Host ""

    # Lancer l'ouverture du navigateur en arriere-plan apres 2 secondes
    Start-Job -ScriptBlock {
        Start-Sleep -Seconds 2
        Start-Process "http://localhost:8080"
    } | Out-Null

    Push-Location "build\web"
    try {
        & $pythonCmd -m http.server 8080
    }
    finally {
        Pop-Location
    }
}
