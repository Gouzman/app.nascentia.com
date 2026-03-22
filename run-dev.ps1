# Script de lancement developpement - NASCENTIA
# Lance Flutter avec les credentials Supabase depuis .env

Write-Host "[NASCENTIA] Lancement en mode developpement..." -ForegroundColor Cyan

# Verifier que .env existe
if (-Not (Test-Path ".env")) {
    Write-Host "[ERREUR] Fichier .env introuvable!" -ForegroundColor Red
    Write-Host "Copiez .env.example vers .env et ajoutez vos cles Supabase" -ForegroundColor Yellow
    exit 1
}

# Lire le fichier .env
$envContent = Get-Content ".env" -Raw
$supabaseUrl = ""
$supabaseKey = ""
$brevoApiKey = ""
$brevoSenderEmail = ""
$brevoReceiverEmail = ""

# Parser les variables
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

# Verifier que les variables sont definies
if ([string]::IsNullOrEmpty($supabaseUrl) -or [string]::IsNullOrEmpty($supabaseKey)) {
    Write-Host "[ERREUR] SUPABASE_URL ou SUPABASE_ANON_KEY manquant dans .env" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Configuration chargee depuis .env" -ForegroundColor Green
Write-Host "   Supabase URL: $supabaseUrl" -ForegroundColor Gray
Write-Host "   Supabase Key: $($supabaseKey.Substring(0, 20))..." -ForegroundColor Gray
if (-Not [string]::IsNullOrEmpty($brevoApiKey)) {
    Write-Host "   Brevo API Key: $($brevoApiKey.Substring(0, 20))..." -ForegroundColor Gray
    Write-Host "   Brevo Sender: $brevoSenderEmail" -ForegroundColor Gray
    Write-Host "   Brevo Receiver: $brevoReceiverEmail" -ForegroundColor Gray
}
Write-Host ""

# Lancer Flutter
Write-Host "[FLUTTER] Demarrage de l'application..." -ForegroundColor Cyan

if (-Not [string]::IsNullOrEmpty($brevoApiKey)) {
    # Avec Brevo
    flutter run -d chrome `
        --dart-define=SUPABASE_URL=$supabaseUrl `
        --dart-define=SUPABASE_ANON_KEY=$supabaseKey `
        --dart-define=BREVO_API_KEY=$brevoApiKey `
        --dart-define=BREVO_SENDER_EMAIL=$brevoSenderEmail `
        --dart-define=BREVO_RECEIVER_EMAIL=$brevoReceiverEmail
} else {
    # Sans Brevo
    flutter run -d chrome `
        --dart-define=SUPABASE_URL=$supabaseUrl `
        --dart-define=SUPABASE_ANON_KEY=$supabaseKey
}

Write-Host ""
Write-Host "[FIN] Application fermee" -ForegroundColor Yellow

Write-Host ""
Write-Host "[FIN] Application fermee" -ForegroundColor Yellow
