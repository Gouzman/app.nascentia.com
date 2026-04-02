# Script de génération des icônes NASCENTIA
# Usage: .\generate-icons.ps1

Add-Type -AssemblyName System.Drawing

$sourceLogo = "lib\assets\images\logo-nascentia.png"
$webDir = "web"

function Resize-Image {
    param([string]$InputPath, [string]$OutputPath, [int]$Width, [int]$Height)

    $img = [System.Drawing.Image]::FromFile($InputPath)
    $newImg = New-Object System.Drawing.Bitmap($Width, $Height)
    $graphics = [System.Drawing.Graphics]::FromImage($newImg)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($img, 0, 0, $Width, $Height)
    $newImg.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $graphics.Dispose()
    $newImg.Dispose()
    $img.Dispose()
}

Write-Host "🎨 Génération des icônes NASCENTIA..." -ForegroundColor Cyan

# Créer le dossier icons si nécessaire
if (-not (Test-Path "$webDir\icons")) {
    New-Item -ItemType Directory -Path "$webDir\icons" -Force | Out-Null
}

# Générer les icônes
Resize-Image -InputPath $sourceLogo -OutputPath "$webDir\favicon.png" -Width 48 -Height 48
Write-Host "✓ favicon.png - 48x48" -ForegroundColor Green

Resize-Image -InputPath $sourceLogo -OutputPath "$webDir\icons\Icon-192.png" -Width 192 -Height 192
Write-Host "✓ Icon-192.png - 192x192" -ForegroundColor Green

Resize-Image -InputPath $sourceLogo -OutputPath "$webDir\icons\Icon-512.png" -Width 512 -Height 512
Write-Host "✓ Icon-512.png - 512x512" -ForegroundColor Green

Resize-Image -InputPath $sourceLogo -OutputPath "$webDir\icons\nascentia-og-image.png" -Width 1200 -Height 630
Write-Host "✓ nascentia-og-image.png - 1200x630" -ForegroundColor Green

Resize-Image -InputPath $sourceLogo -OutputPath "$webDir\icons\nascentia-twitter-card.png" -Width 1200 -Height 630
Write-Host "✓ nascentia-twitter-card.png - 1200x630" -ForegroundColor Green

Write-Host "`n✅ Toutes les icônes ont été générées avec succès !" -ForegroundColor Green
Write-Host "📁 Emplacement: web/icons/" -ForegroundColor Cyan
Write-Host "`nProchaine étape: flutter build web" -ForegroundColor Yellow
