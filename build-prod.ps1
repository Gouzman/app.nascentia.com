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
$brevoApiKey = ""
$brevoSenderEmail = ""
$brevoReceiverEmail = ""

$envContent -split "`n" | ForEach-Object {
    if ($_ -match "^SUPABASE_URL=(.+)$") {
        $supabaseUrl = $matches[1].Trim()
    }
    if ($_ -match "^SUPABASE_ANON_KEY=(.+)$") {
        $supabaseKey = $matches[1].Trim()
    }
    if ($_ -match "^BREVO_API_KEY=(.+)$") {
        $brevoApiKey = $matches[1].Trim()
    }
    if ($_ -match "^BREVO_SENDER_EMAIL=(.+)$") {
        $brevoSenderEmail = $matches[1].Trim()
    }
    if ($_ -match "^BREVO_RECEIVER_EMAIL=(.+)$") {
        $brevoReceiverEmail = $matches[1].Trim()
    }
}

if ([string]::IsNullOrEmpty($supabaseUrl) -or [string]::IsNullOrEmpty($supabaseKey)) {
    Write-Host "[ERREUR] Configuration Supabase manquante" -ForegroundColor Red
    exit 1
}

if ([string]::IsNullOrEmpty($brevoApiKey) -or [string]::IsNullOrEmpty($brevoSenderEmail) -or [string]::IsNullOrEmpty($brevoReceiverEmail)) {
    Write-Host "[ERREUR] Configuration Brevo manquante" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Configuration chargee" -ForegroundColor Green
Write-Host ""

# Build web
Write-Host "[FLUTTER] Build du projet web..." -ForegroundColor Cyan
flutter build web `
    --dart-define=SUPABASE_URL=$supabaseUrl `
    --dart-define=SUPABASE_ANON_KEY=$supabaseKey `
    --dart-define=BREVO_API_KEY=$brevoApiKey `
    --dart-define=BREVO_SENDER_EMAIL=$brevoSenderEmail `
    --dart-define=BREVO_RECEIVER_EMAIL=$brevoReceiverEmail `
    --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "[OK] Build reussi!" -ForegroundColor Green

    # Ajouter un hash de build unique au version.json pour le cache-busting
    Write-Host "[CACHE] Mise a jour du hash de version..." -ForegroundColor Cyan

    $versionFile = "build\web\version.json"
    if (Test-Path $versionFile) {
        $versionData = Get-Content $versionFile -Raw | ConvertFrom-Json

        # Générer un hash unique basé sur la date et l'heure
        $buildHash = [System.DateTimeOffset]::UtcNow.ToUnixTimeSeconds().ToString()
        $buildDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # Ajouter les nouvelles propriétés
        $versionData | Add-Member -NotePropertyName "build_hash" -NotePropertyValue $buildHash -Force
        $versionData | Add-Member -NotePropertyName "build_date" -NotePropertyValue $buildDate -Force

        # Sauvegarder
        $versionData | ConvertTo-Json | Set-Content $versionFile -Encoding UTF8

        Write-Host "[OK] Hash de build: $buildHash" -ForegroundColor Green
        Write-Host "[OK] Date de build: $buildDate" -ForegroundColor Green
    }

    Write-Host ""
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
