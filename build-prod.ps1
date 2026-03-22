# Script de build production - NASCENTIA
# Build le projet web avec les credentials Supabase

Write-Host "[BUILD PROD] Build de production - NASCENTIA" -ForegroundColor Cyan

# Verifier que .env existe
if (-Not (Test-Path ".env")) {
    Write-Host "[ERREUR] Fichier .env introuvable!" -ForegroundColor Red
    exit 1
}

# Lire le fichier .env
$envContent = Get-Content ".env" -Raw
$supabaseUrl = ""
$supabaseKey = ""

$envContent -split "`n" | ForEach-Object {
    if ($_ -match "^SUPABASE_URL=(.+)$") {
        $supabaseUrl = $matches[1].Trim()
    }
    if ($_ -match "^SUPABASE_ANON_KEY=(.+)$") {
        $supabaseKey = $matches[1].Trim()
    }
}

if ([string]::IsNullOrEmpty($supabaseUrl) -or [string]::IsNullOrEmpty($supabaseKey)) {
    Write-Host "[ERREUR] Configuration Supabase manquante" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Configuration chargee" -ForegroundColor Green
Write-Host ""

# Build web
Write-Host "[FLUTTER] Build du projet web..." -ForegroundColor Cyan
flutter build web `
    --dart-define=SUPABASE_URL=$supabaseUrl `
    --dart-define=SUPABASE_ANON_KEY=$supabaseKey `
    --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "[OK] Build reussi!" -ForegroundColor Green
    Write-Host "[INFO] Fichiers dans: build\web" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Pour tester localement:" -ForegroundColor Yellow
    Write-Host "  cd build\web" -ForegroundColor Gray
    Write-Host "  python -m http.server 8000" -ForegroundColor Gray
    Write-Host "  # Ouvrir http://localhost:8000" -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "[ERREUR] Echec du build" -ForegroundColor Red
}
