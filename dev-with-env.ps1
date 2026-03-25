# Script pour lancer Flutter avec variables d'environnement depuis .env
Write-Host "Chargement Flutter Web avec variables d'environnement..." -ForegroundColor Cyan

# Charger les variables depuis le fichier .env
if (Test-Path ".env") {
    Get-Content .env | ForEach-Object {
        if ($_ -match '^([^=]+)=(.*)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            Set-Item -Path "env:$name" -Value $value
        }
    }
    Write-Host "Variables chargees depuis .env!" -ForegroundColor Green
} else {
    Write-Host "ERREUR: Fichier .env introuvable!" -ForegroundColor Red
    Write-Host "Creez un fichier .env a partir de .env.exemple" -ForegroundColor Yellow
    exit 1
}

Write-Host "Lancement de Flutter..." -ForegroundColor Cyan
Write-Host ""

flutter run -d chrome --dart-define=BREVO_API_KEY="$env:BREVO_API_KEY" --dart-define=BREVO_SENDER_EMAIL="$env:BREVO_SENDER_EMAIL" --dart-define=BREVO_RECEIVER_EMAIL="$env:BREVO_RECEIVER_EMAIL" --dart-define=SUPABASE_URL="$env:SUPABASE_URL" --dart-define=SUPABASE_ANON_KEY="$env:SUPABASE_ANON_KEY"
