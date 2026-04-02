# NASCENTIA APK Release Script
param(
    [string]$ApkPath = "C:\Users\ccsrt\Documents\Nascentia.apk",
    [string]$NewVersion = "1.0.1",
    [string]$GitHubToken = ""
)

$ErrorActionPreference = "Stop"
$Owner = "Gouzman"
$Repo = "app.nascentia.com"
$TagName = "app-v$NewVersion"
$ReleaseName = "NASCENTIA v$NewVersion - Mise a jour"

Write-Host "=== NASCENTIA - Publication Release GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Etape 1: Verification APK
Write-Host "[1/6] Verification du fichier APK..." -ForegroundColor Yellow
if (-not (Test-Path $ApkPath)) {
    Write-Host "ERREUR: Fichier APK introuvable: $ApkPath" -ForegroundColor Red
    exit 1
}

$apkFile = Get-Item $ApkPath
$apkSizeMB = [math]::Round($apkFile.Length / 1MB, 2)
Write-Host "OK - Fichier: $($apkFile.Name) ($apkSizeMB MB)" -ForegroundColor Green
Write-Host ""

# Etape 2: Token GitHub
Write-Host "[2/6] Authentification GitHub..." -ForegroundColor Yellow
if ([string]::IsNullOrWhiteSpace($GitHubToken)) {
    Write-Host "Token GitHub requis" -ForegroundColor Red
    exit 1
}

$headers = @{
    "Authorization" = "Bearer $GitHubToken"
    "Accept"        = "application/vnd.github+json"
}
Write-Host "OK - Token configure" -ForegroundColor Green
Write-Host ""

# Etape 3: Verification du tag
Write-Host "[3/6] Verification du tag $TagName..." -ForegroundColor Yellow
try {
    $existingRelease = Invoke-RestMethod `
        -Uri "https://api.github.com/repos/$Owner/$Repo/releases/tags/$TagName" `
        -Headers $headers `
        -Method Get `
        -ErrorAction SilentlyContinue

    if ($existingRelease) {
        Write-Host "ATTENTION: La release existe deja!" -ForegroundColor Yellow
        Write-Host "Suppression en cours..." -ForegroundColor Yellow
        Invoke-RestMethod `
            -Uri "https://api.github.com/repos/$Owner/$Repo/releases/$($existingRelease.id)" `
            -Headers $headers `
            -Method Delete | Out-Null
        Write-Host "OK - Ancienne release supprimee" -ForegroundColor Green
    }
    else {
        Write-Host "OK - Tag disponible" -ForegroundColor Green
    }
}
catch {
    Write-Host "OK - Tag disponible" -ForegroundColor Green
}
Write-Host ""

# Etape 4: Creation de la release# Etape 4: Creation de la release
Write-Host "[4/6] Creation de la release..." -ForegroundColor YellowoundColor Yellow

$bodyLines = @($bodyLines = @(
        "## NASCENTIA v$NewVersion",## NASCENTIA v$NewVersion",
        "",
        "Application mobile officielle NASCENTIA.",
        "",
        "### Nouveautes",
        "",
        "- Corrections de bugs", "- Corrections de bugs",
        "- Optimisations de performance", formance",
    "- Ameliorations visuelles",
    "",
    "### Telechargement", Telechargement",
        "",
        "1. Telechargez nascentia.apk ci-dessous", ci-dessous",
    "2. Activez 'Sources inconnues' sur Android",
    "3. Installez le fichier APK",K",
        "",
        "### Compatibilite",
        "",
        "- Systeme: Android 6.0+",
        "- Taille: $apkSizeMB MB", apkSizeMB MB",
    "- Version: $NewVersion",
    "",
    "### Support",Support",
        "", ",
    "- Email: nascentia.info@gmail.com",ail: nascentia.info@gmail.com",
        "- Site: https://nascentia-tech.com"
    )

    $releaseBody = $bodyLines -join "`n"$releaseBody = $bodyLines -join "`n"

    $releaseData = @{
        tag_name = $TagName    tag_name         = $TagName
        target_commitish = "main"
        name             = $ReleaseName
        body             = $releaseBody
        draft            = $false
        prerelease       = $false
    } | ConvertTo-Json -Depth 10

    try {
        $release = Invoke-RestMethod `
            -Uri "https://api.github.com/repos/$Owner/$Repo/releases" `
            -Headers $headers `
            -Method Post `
            -Body $releaseData `
            -ContentType "application/json"

        Write-Host "OK - Release creee (ID: $($release.id))" -ForegroundColor GreenegroundColor Green
        Write-Host "URL: $($release.html_url)" -ForegroundColor Grayy
    }
    catch {
        Write-Host "ERREUR lors de la creation:" -ForegroundColor Red -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor RedMessage -ForegroundColor Red
        exit 1
    }
    Write-Host ""

    # Etape 5: Upload de l'APKAPK
    Write-Host "[5/6] Upload de l'APK ($apkSizeMB MB)..." -ForegroundColor YellowMB MB)..." -ForegroundColor Yellow
Write-Host "Ceci peut prendre quelques minutes..." -ForegroundColor GrayregroundColor Gray

$uploadUrl = $release.upload_url.Replace('{?name,label}', '?name=nascentia.apk').Replace('{?name,label}', '?name=nascentia.apk')
$apkBytes = [System.IO.File]::ReadAllBytes($ApkPath)ile]::ReadAllBytes($ApkPath)

try {
    $uploadHeaders = $headers.Clone()
    $uploadHeaders["Content-Type"] = "application/vnd.android.package-archive"Headers["Content-Type"] = "application/vnd.android.package-archive"

    $asset = Invoke-RestMethod `    $asset = Invoke-RestMethod `
        -Uri $uploadUrl `oadUrl `
        -Headers $uploadHeaders ` `
        -Method Post `
        -Body $apkBytes

    Write-Host "OK - APK uploade avec succes!" -ForegroundColor Greenade avec succes!" -ForegroundColor Green
Write-Host "URL: $($asset.browser_download_url)" -ForegroundColor Gray.browser_download_url)" -ForegroundColor Gray

    $downloadUrl = $asset.browser_download_url    $downloadUrl = $asset.browser_download_url
} catch {ch {
    Write-Host "ERREUR lors de l'upload:" -ForegroundColor Redpload:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
Write-Host ""

# Etape 6: Mise a jour du codeape 6: Mise a jour du code
Write-Host "[6/6] Mise a jour du code source..." -ForegroundColor Yelloww

$configFile = "lib\services\supabase_config.dart"
$oldPattern = "https://github.com/$Owner/$Repo/releases/download/app-v[\d\.]+/nascentia\.apk"rn = "https://github.com/$Owner/$Repo/releases/download/app-v[\d\.]+/nascentia\.apk"

if (Test-Path $configFile) {
    $content = Get-Content $configFile -Rawnt = Get-Content $configFile -Raw
    $content = $content -replace $oldPattern, $downloadUrl   $content = $content -replace $oldPattern, $downloadUrl
    Set-Content $configFile -Value $content -NoNewlinent $configFile -Value $content -NoNewline
    Write-Host "OK - Fichier mis a jour" -ForegroundColor Green    Write-Host "OK - Fichier mis a jour" -ForegroundColor Green
} else {
    Write-Host "ATTENTION: Fichier config introuvable" -ForegroundColor Yellow
}}
Write-Host ""

# Git commit# Git commit
Write-Host "Commit et push..." -ForegroundColor Yellow-Host "Commit et push..." -ForegroundColor Yellow
try {
    git add $configFile 2>$null
    git commit -m "chore: update APK to v$NewVersion" 2>$nullgit commit -m "chore: update APK to v$NewVersion" 2>$null
    git push origin main 2>$null
    Write-Host "OK - Changements git pousses" -ForegroundColor GreenWrite-Host "OK - Changements git pousses" -ForegroundColor Green
} catch {
    Write-Host "ATTENTION: Push git echoue (peut etre ignore)" -ForegroundColor Yellow: Push git echoue (peut etre ignore)" -ForegroundColor Yellow
}
Write-Host ""

# Résumé finalsumé final
Write-Host "============================================" -ForegroundColor GreenColor Green
Write-Host "    MISE A JOUR TERMINEE AVEC SUCCES!" -ForegroundColor GreendColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Release: $ReleaseName" -ForegroundColor Cyane-Host "Release: $ReleaseName" -ForegroundColor Cyan
Write-Host "Tag: $TagName" -ForegroundColor Cyanan
Write-Host "APK: nascentia.apk ($apkSizeMB MB)" -ForegroundColor Cyant "APK: nascentia.apk ($apkSizeMB MB)" -ForegroundColor Cyan
Write-Host ""
Write-Host "URL de telechargement:" -ForegroundColor Cyann
Write-Host $downloadUrl -ForegroundColor White $downloadUrl -ForegroundColor White
Write-Host ""rite-Host ""
Write-Host "Page release:" -ForegroundColor Cyanage release:" -ForegroundColor Cyan
Write-Host $release.html_url -ForegroundColor WhiteWrite-Host $release.html_url -ForegroundColor White
Write-Host ""
Write-Host "Prochaines etapes:" -ForegroundColor Yellow
Write-Host "1. Testez le telechargement" -ForegroundColor GrayWrite-Host "1. Testez le telechargement" -ForegroundColor Gray
Write-Host "2. Verifiez l'installation APK" -ForegroundColor GraygroundColor Gray
Write-Host "3. Redeployez le site si necessaire" -ForegroundColor Gray
Write-Host ""
