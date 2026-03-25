# Script de deploiement automatique vers cPanel - NASCENTIA
# Build + Upload FTP/SFTP vers votre hebergement

param(
    [switch]$SkipBuild,      # Sauter l'etape de build
    [switch]$BuildOnly,      # Build uniquement sans deployer
    [switch]$NoBackup        # Ne pas faire de sauvegarde
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NASCENTIA - Deploiement Production   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ============================================
# 1. VERIFIER LA CONFIGURATION
# ============================================

if (-Not (Test-Path ".deploy.env")) {
    Write-Host "[ERREUR] Fichier .deploy.env introuvable!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Creez le fichier .deploy.env avec vos informations:" -ForegroundColor Yellow
    Write-Host "  1. Copiez .deploy.env.exemple vers .deploy.env" -ForegroundColor Gray
    Write-Host "  2. Renseignez vos identifiants cPanel/FTP" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

# Lire la configuration de deploiement
Write-Host "[CONFIG] Chargement de la configuration..." -ForegroundColor Cyan
$deployConfig = Get-Content ".deploy.env" -Raw
$ftpHost = ""
$ftpPort = "21"
$ftpUser = ""
$ftpPass = ""
$ftpPath = "/public_html"
$deployMethod = "FTP"
$backupEnabled = $true

$deployConfig -split "`n" | ForEach-Object {
    if ($_ -match "^DEPLOY_METHOD=(.+)$") { $deployMethod = $matches[1].Trim() }
    if ($_ -match "^FTP_HOST=(.+)$") { $ftpHost = $matches[1].Trim() }
    if ($_ -match "^FTP_PORT=(.+)$") { $ftpPort = $matches[1].Trim() }
    if ($_ -match "^FTP_USERNAME=(.+)$") { $ftpUser = $matches[1].Trim() }
    if ($_ -match "^FTP_PASSWORD=(.+)$") { $ftpPass = $matches[1].Trim() }
    if ($_ -match "^FTP_REMOTE_PATH=(.+)$") { $ftpPath = $matches[1].Trim() }
    if ($_ -match "^BACKUP_BEFORE_DEPLOY=(.+)$") {
        $backupEnabled = $matches[1].Trim() -eq "true"
    }
}

# Verifier que les variables sont renseignees
if ([string]::IsNullOrEmpty($ftpHost) -or [string]::IsNullOrEmpty($ftpUser) -or [string]::IsNullOrEmpty($ftpPass)) {
    Write-Host "[ERREUR] Configuration FTP incomplete dans .deploy.env" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Configuration chargee" -ForegroundColor Green
Write-Host "   Serveur: $ftpHost`:$ftpPort" -ForegroundColor Gray
Write-Host "   Utilisateur: $ftpUser" -ForegroundColor Gray
Write-Host "   Repertoire distant: $ftpPath" -ForegroundColor Gray
Write-Host "   Methode: $deployMethod" -ForegroundColor Gray
Write-Host ""

# ============================================
# 2. BUILD DU PROJET
# ============================================

if (-Not $SkipBuild) {
    Write-Host "[BUILD] Lancement du build de production..." -ForegroundColor Cyan

    # Verifier .env pour Supabase
    if (-Not (Test-Path ".env")) {
        Write-Host "[ERREUR] Fichier .env introuvable!" -ForegroundColor Red
        exit 1
    }

    $envContent = Get-Content ".env" -Raw
    $supabaseUrl = ""
    $supabaseKey = ""
    $brevoApiKey = ""

    $envContent -split "`n" | ForEach-Object {
        if ($_ -match "^SUPABASE_URL=(.+)$") { $supabaseUrl = $matches[1].Trim() }
        if ($_ -match "^SUPABASE_ANON_KEY=(.+)$") { $supabaseKey = $matches[1].Trim() }
        if ($_ -match "^BREVO_API_KEY=(.+)$") { $brevoApiKey = $matches[1].Trim() }
    }

    if ([string]::IsNullOrEmpty($supabaseUrl) -or [string]::IsNullOrEmpty($supabaseKey)) {
        Write-Host "[ERREUR] Configuration Supabase manquante dans .env" -ForegroundColor Red
        exit 1
    }

    # Build Flutter Web
    Write-Host "[FLUTTER] Build du projet Flutter Web..." -ForegroundColor Yellow

    if (-Not [string]::IsNullOrEmpty($brevoApiKey)) {
        flutter build web `
            --dart-define=SUPABASE_URL=$supabaseUrl `
            --dart-define=SUPABASE_ANON_KEY=$supabaseKey `
            --dart-define=BREVO_API_KEY=$brevoApiKey `
            --release
    } else {
        flutter build web `
            --dart-define=SUPABASE_URL=$supabaseUrl `
            --dart-define=SUPABASE_ANON_KEY=$supabaseKey `
            --release
    }

    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "[ERREUR] Echec du build Flutter" -ForegroundColor Red
        exit 1
    }

    Write-Host ""
    Write-Host "[OK] Build reussi!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "[INFO] Build ignore (flag --SkipBuild)" -ForegroundColor Yellow
    Write-Host ""
}

# Si BuildOnly, on s'arrete ici
if ($BuildOnly) {
    Write-Host "[INFO] Mode BuildOnly - Deploiement ignore" -ForegroundColor Yellow
    Write-Host "[INFO] Fichiers dans: build\web" -ForegroundColor Gray
    exit 0
}

# Verifier que le dossier build/web existe
if (-Not (Test-Path "build\web")) {
    Write-Host "[ERREUR] Le dossier build\web n'existe pas!" -ForegroundColor Red
    Write-Host "[INFO] Lancez d'abord: .\build-prod.ps1" -ForegroundColor Yellow
    exit 1
}

# ============================================
# 3. DEPLOIEMENT FTP
# ============================================

Write-Host "[DEPLOY] Preparation du deploiement..." -ForegroundColor Cyan
Write-Host ""

# Methode PowerShell natif (compatible partout)
Write-Host "[INFO] Utilisation de PowerShell natif pour FTP..." -ForegroundColor Yellow
Write-Host ""

try {
    # Script PowerShell pour FTP
    $ftpFullPath = "ftp://$ftpHost`:$ftpPort$ftpPath"

    # Creer les credentials
    $securePassword = ConvertTo-SecureString $ftpPass -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($ftpUser, $securePassword)

    # Lister les fichiers a uploader
    $files = Get-ChildItem -Path "build\web" -Recurse -File
    $totalFiles = $files.Count
    $currentFile = 0

    Write-Host "[UPLOAD] Upload de $totalFiles fichiers..." -ForegroundColor Cyan

    foreach ($file in $files) {
        $currentFile++
        $relativePath = $file.FullName.Substring((Get-Item "build\web").FullName.Length + 1)
        $remotePath = "$ftpFullPath/$($relativePath.Replace('\', '/'))"

        # Upload le fichier
        Write-Progress -Activity "Deploiement" -Status "[$currentFile/$totalFiles] $relativePath" -PercentComplete (($currentFile / $totalFiles) * 100)

        try {
            $webclient = New-Object System.Net.WebClient
            $webclient.Credentials = $credential
            $webclient.UploadFile($remotePath, $file.FullName)
            $webclient.Dispose()
        } catch {
            Write-Host "   Erreur upload: $relativePath" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "[SUCCES] Deploiement termine!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Votre site est maintenant en ligne:" -ForegroundColor Cyan
    Write-Host "   https://nascentia-tech.com" -ForegroundColor White
    Write-Host ""

} catch {
    Write-Host ""
    Write-Host "[ERREUR] Echec du deploiement: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solutions:" -ForegroundColor Yellow
    Write-Host "   1. Verifiez vos identifiants FTP dans .deploy.env" -ForegroundColor Gray
    Write-Host "   2. Testez avec FileZilla pour confirmer la connexion" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Deploiement termine                   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
