# 🚀 Guide de Déploiement NASCENTIA vers cPanel

Ce guide vous explique comment configurer et utiliser le script de déploiement automatique vers votre hébergement cPanel.

---

## 📋 Prérequis

- ✅ Accès FTP à votre hébergement cPanel
- ✅ PowerShell installé (Windows)
- ⚠️ **Recommandé:** [WinSCP](https://winscp.net/download/WinSCP-5.21-Setup.exe) pour des uploads plus rapides

---

## 🔧 Configuration Initiale

### Étape 1 : Créer le fichier de configuration

1. Copiez le fichier exemple:
```powershell
Copy-Item .deploy.env.exemple .deploy.env
```

2. Ouvrez `.deploy.env` et renseignez vos informations cPanel:

```env
# Méthode de connexion
DEPLOY_METHOD=FTP

# Informations FTP de votre hébergement cPanel
FTP_HOST=ftp.nascentia-tech.com
FTP_PORT=21
FTP_USERNAME=votre_username_cpanel
FTP_PASSWORD=votre_mot_de_passe

# Chemin distant (celui où se trouve votre site)
# Souvent: /public_html ou /public_html/votre-dossier
FTP_REMOTE_PATH=/public_html

# Sauvegarde automatique (recommandé)
BACKUP_BEFORE_DEPLOY=true
```

### Étape 2 : Obtenir vos identifiants cPanel

Dans votre **cPanel**, allez dans:
1. **Comptes FTP** → Vos identifiants FTP
2. **Gestionnaire de fichiers** → Vérifier le chemin de votre site (généralement `/public_html`)

#### Exemple de configuration type:
```env
FTP_HOST=ftp.votre-domaine.com
FTP_PORT=21
FTP_USERNAME=cpanel_user@votre-domaine.com
FTP_PASSWORD=VotreMotDePasse123
FTP_REMOTE_PATH=/public_html
```

---

## 🚀 Utilisation

### Déploiement complet (Build + Upload)
```powershell
.\deploy-cpanel.ps1
```

Cette commande va:
1. ✅ Charger la configuration depuis `.deploy.env`
2. ✅ Builder le projet Flutter avec les variables d'environnement
3. ✅ Créer une sauvegarde de l'ancienne version sur le serveur
4. ✅ Uploader tous les fichiers vers cPanel
5. ✅ Afficher l'URL de votre site

### Options avancées

#### Déployer sans rebuild (si déjà buildé)
```powershell
.\deploy-cpanel.ps1 -SkipBuild
```

#### Build uniquement (sans déployer)
```powershell
.\deploy-cpanel.ps1 -BuildOnly
```

#### Déployer sans faire de backup
```powershell
.\deploy-cpanel.ps1 -NoBackup
```

---

## 🎯 Workflow Recommandé

### 1. Développement local
```powershell
# Tester en local
.\run-dev.ps1
```

### 2. Build de production
```powershell
# Build avec vérifications
.\build-prod.ps1
```

### 3. Test du build local (optionnel)
```powershell
cd build\web
python -m http.server 8000
# Ouvrir http://localhost:8000
```

### 4. Déploiement en production
```powershell
# Déployer vers cPanel
.\deploy-cpanel.ps1
```

---

## 🔒 Sécurité

### ⚠️ IMPORTANT

Le fichier `.deploy.env` contient vos identifiants FTP. **NE JAMAIS LE COMMITTER SUR GIT !**

Vérifiez que `.deploy.env` est bien dans `.gitignore`:
```bash
# Variables d'environnement - NE JAMAIS COMMIT !
.env
.deploy.env
```

### Bonnes pratiques

1. ✅ Utilisez un **mot de passe fort** pour votre compte FTP
2. ✅ Créez un **compte FTP dédié** pour le déploiement (pas le compte principal)
3. ✅ Limitez les **permissions** de ce compte au dossier `/public_html` uniquement
4. ✅ Activez **SFTP** (port 22) si disponible dans votre hébergement (plus sécurisé que FTP)

### Configuration SFTP (si disponible)
```env
DEPLOY_METHOD=SFTP
FTP_HOST=votre-domaine.com
FTP_PORT=22
FTP_USERNAME=votre_username
FTP_PASSWORD=votre_mot_de_passe
```

---

## 🛠️ Installation de WinSCP (Recommandé)

WinSCP accélère considérablement les uploads (jusqu'à 10x plus rapide).

### Installation automatique
```powershell
# Télécharger et installer
winget install WinSCP.WinSCP
```

### Installation manuelle
1. Téléchargez: [WinSCP Setup](https://winscp.net/download/WinSCP-5.21-Setup.exe)
2. Installez avec les options par défaut
3. Le script détectera automatiquement WinSCP

---

## 📂 Structure du Déploiement

### Ce qui est uploadé
```
build/web/
├── index.html          → Page principale
├── flutter.js          → Runtime Flutter
├── flutter_service_worker.js
├── manifest.json       → PWA Manifest
├── version.json
├── assets/            → Images, fonts
├── canvaskit/         → Moteur de rendu
└── icons/             → Icônes de l'app
```

### Ce qui se passe sur le serveur
```
/public_html/
├── backup_2026-03-22_14-30-00/  ← Sauvegarde auto (si activée)
│   └── [anciens fichiers]
├── index.html          ← Nouveaux fichiers
├── flutter.js
├── assets/
└── ...
```

---

## ❌ Résolution de Problèmes

### Erreur: "Fichier .deploy.env introuvable"
**Solution:** Créez le fichier de configuration
```powershell
Copy-Item .deploy.env.exemple .deploy.env
# Puis éditez .deploy.env avec vos identifiants
```

### Erreur: "Échec de connexion FTP"
**Causes possibles:**
1. ❌ Identifiants incorrects → Vérifiez votre username/password
2. ❌ Host incorrect → Vérifiez l'adresse dans cPanel
3. ❌ Port bloqué → Essayez le port 21 (FTP) ou 22 (SFTP)
4. ❌ Firewall → Autorisez PowerShell dans Windows Defender

**Solution:** Testez manuellement avec FileZilla:
```
Host: ftp.votre-domaine.com
Port: 21
User: votre_username
Pass: votre_password
```

### Erreur: "Échec du build Flutter"
**Solution:** Vérifiez votre fichier `.env`
```powershell
# Vérifier que .env existe
Test-Path .env

# Vérifier les variables
Get-Content .env
```

### Upload très lent
**Solution:** Installez WinSCP
```powershell
winget install WinSCP.WinSCP
```

### Erreur 550: Permission denied
**Solution:** Vérifiez les permissions du dossier distant
- Dans cPanel → Gestionnaire de fichiers
- Dossier `/public_html` doit avoir les permissions `755`

---

## 📞 Support

En cas de problème:
1. Vérifiez les logs du script (affichés dans la console)
2. Testez votre connexion FTP avec FileZilla
3. Contactez votre hébergeur si problème de connexion
4. Email: nascentia.info@gmail.com

---

## 🎉 Déploiement Réussi!

Après un déploiement réussi, votre site est accessible à:
- 🌐 **https://nascentia-tech.com**

Vérifiez que:
- ✅ La page d'accueil charge correctement
- ✅ Les images s'affichent
- ✅ Les animations fonctionnent
- ✅ Le formulaire de contact fonctionne

---

## 📚 Références

- [Documentation Flutter Web](https://docs.flutter.dev/deployment/web)
- [Guide cPanel FTP](https://docs.cpanel.net/cpanel/files/ftp-accounts/)
- [WinSCP Documentation](https://winscp.net/eng/docs/)

---

**Dernière mise à jour:** Mars 2026
**Version du script:** 1.0
