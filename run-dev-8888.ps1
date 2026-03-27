# Lancement serveur sur port 8888 (nouveau port pour éviter cache)
$port = 8888

# Stopper ancien serveur si existant
Get-Process -Name python -ErrorAction SilentlyContinue |
    Where-Object {
        (Get-NetTCPConnection -OwningProcess $_.Id -ErrorAction SilentlyContinue).LocalPort -eq $port
    } | Stop-Process -Force -ErrorAction SilentlyContinue

Start-Sleep -Milliseconds 500

Write-Host "`n=== SERVEUR PORT $port (NOUVEAU PORT = PAS DE CACHE) ===" -ForegroundColor Green
Write-Host "URL: http://localhost:$port`n" -ForegroundColor Cyan

# Lancer serveur Python
if (Test-Path "serve-web.py") {
    python serve-web.py $port
} else {
    python -m http.server $port --directory build/web
}
