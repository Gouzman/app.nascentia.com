# Script de préparation pour cPanel - NASCENTIA
# Crée un ZIP prêt à télécharger avec tous les fichiers nécessaires

Write-Host "`n[CPANEL PREP] Préparation du déploiement cPanel" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Gray

# Vérifier que le build existe
if (-Not (Test-Path "build\web\index.html")) {
    Write-Host "[ERREUR] Build introuvable ! Lancez d'abord:" -ForegroundColor Red
    Write-Host "  .\build-prod.ps1" -ForegroundColor Yellow
    exit 1
}

# Nom du fichier ZIP avec timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$zipName = "nascentia-web-$timestamp.zip"
$zipPath = Join-Path $PSScriptRoot $zipName

Write-Host "[INFO] Création de l'archive..." -ForegroundColor Cyan

# Supprimer l'ancien ZIP s'il existe
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

# Créer le ZIP depuis build\web
try {
    Compress-Archive -Path "build\web\*" -DestinationPath $zipPath -CompressionLevel Optimal

    # Obtenir la taille du fichier
    $zipSize = [math]::Round((Get-Item $zipPath).Length / 1MB, 2)

    Write-Host ""
    Write-Host "[OK] Archive créée avec succès !" -ForegroundColor Green
    Write-Host "[INFO] Fichier: $zipName" -ForegroundColor Gray
    Write-Host "[INFO] Taille: $zipSize MB" -ForegroundColor Gray
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Gray
    Write-Host "[DÉPLOIEMENT CPANEL]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Connexion à cPanel:" -ForegroundColor White
    Write-Host "   https://votre-domaine.com/cpanel" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. Gestionnaire de fichiers:" -ForegroundColor White
    Write-Host "   → Aller dans public_html/" -ForegroundColor Gray
    Write-Host "   → Activer 'Afficher les fichiers cachés' (⚙️)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. Nettoyer les anciens fichiers:" -ForegroundColor White
    Write-Host "   → Sélectionner tous les fichiers" -ForegroundColor Gray
    Write-Host "   → Supprimer (sauf .htaccess initial si important)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "4. Télécharger la nouvelle archive:" -ForegroundColor White
    Write-Host "   → Cliquer sur 'Télécharger'" -ForegroundColor Gray
    Write-Host "   → Sélectionner: $zipName" -ForegroundColor Cyan
    Write-Host "   → Attendre la fin du téléchargement" -ForegroundColor Gray
    Write-Host ""
    Write-Host "5. Extraire l'archive:" -ForegroundColor White
    Write-Host "   → Clic droit sur $zipName" -ForegroundColor Cyan
    Write-Host "   → Extraire" -ForegroundColor Gray
    Write-Host "   → Supprimer le ZIP après extraction" -ForegroundColor Gray
    Write-Host ""
    Write-Host "6. VÉRIFIER que .htaccess est présent !" -ForegroundColor Yellow
    Write-Host "   (Fichier caché, activer l'affichage dans cPanel)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "7. Tester le site:" -ForegroundColor White
    Write-Host "   → Navigation privée" -ForegroundColor Gray
    Write-Host "   → Vérifier: https://votre-site.com/version.json" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Gray
    Write-Host ""
    Write-Host "📖 Guide complet: CPANEL_DEPLOYMENT_GUIDE.md" -ForegroundColor Cyan
    Write-Host ""

    # Ouvrir l'explorateur au dossier contenant le ZIP
    Start-Process explorer.exe -ArgumentList "/select,`"$zipPath`""

} catch {
    Write-Host ""
    Write-Host "[ERREUR] Impossible de créer l'archive" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
