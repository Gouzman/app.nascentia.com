# 🚀 Guide de déploiement cPanel - NASCENTIA

Ce guide explique comment déployer efficacement le site NASCENTIA sur cPanel et garantir que les utilisateurs voient toujours la dernière version sans vider leur cache.

---

## 📋 Table des matières

1. [Système de cache intelligent](#système-de-cache-intelligent)
2. [Processus de déploiement](#processus-de-déploiement)
3. [Vérification post-déploiement](#vérification-post-déploiement)
4. [Résolution de problèmes](#résolution-de-problèmes)

---

## 🎯 Système de cache intelligent

### Comment ça fonctionne ?

Le système comporte **3 couches de protection** contre les problèmes de cache :

#### 1. **Headers HTTP (`.htaccess`)**
```apache
# HTML/JSON : Jamais en cache
Cache-Control: no-cache, no-store, must-revalidate

# JS/CSS : Cache court (1h) avec revalidation
Cache-Control: public, max-age=3600, must-revalidate

# Images : Cache long (1 semaine)
Cache-Control: public, max-age=604800, immutable
```

#### 2. **Hash de version unique**
À chaque build, un hash Unix timestamp est ajouté au `version.json` :
```json
{
  "app_name": "nascentia",
  "version": "1.0.0",
  "build_number": "1",
  "build_hash": "1743078000",
  "build_date": "2026-03-24 14:30:00"
}
```

#### 3. **Détection automatique côté client** (`version-check.js`)
- Vérifie toutes les **5 minutes** si une nouvelle version existe
- Vérifie aussi quand l'utilisateur revient sur l'onglet
- Affiche une **notification élégante** avec bouton "Mettre à jour"
- Auto-refresh après **30 secondes** si aucune action

---

## 🔨 Processus de déploiement

### Étape 1 : Build de production

```powershell
# Depuis le répertoire du projet
.\build-prod.ps1
```

**Ce script fait automatiquement :**
- ✅ Charge les variables Supabase depuis `.env`
- ✅ Build Flutter en mode `--release`
- ✅ Génère un hash de build unique
- ✅ Met à jour `build\web\version.json`

**Sortie attendue :**
```
[BUILD PROD] Build de production - NASCENTIA
[OK] Configuration chargee
[FLUTTER] Build du projet web...
[OK] Build reussi!
[CACHE] Mise a jour du hash de version...
[OK] Hash de build: 1743078000
[OK] Date de build: 2026-03-24 14:30:00
[INFO] Fichiers dans: build\web
```

---

### Étape 2 : Vérification locale (optionnelle mais recommandée)

```powershell
cd build\web
python -m http.server 8080
```

Ouvrir : `http://localhost:8080`

**Points à vérifier :**
- ✅ Le site se charge en 2-5 secondes
- ✅ Toutes les images s'affichent
- ✅ Les formulaires fonctionnent
- ✅ Le scroll est fluide

---

### Étape 3 : Téléchargement vers cPanel

#### Option A : Gestionnaire de fichiers cPanel (Recommandé)

1. **Connexion à cPanel**
   - Aller sur : `https://votre-domaine.com/cpanel`
   - Se connecter avec vos identifiants

2. **Accéder au gestionnaire de fichiers**
   - Cliquer sur "Gestionnaire de fichiers"
   - Naviguer vers `public_html` (ou le dossier de votre domaine)

3. **Nettoyer les anciens fichiers**
   ```
   IMPORTANT : Ne pas supprimer .htaccess initial si vous en avez un !
   ```
   - Sélectionner tous les fichiers **SAUF** `.htaccess` (si présent)
   - Cliquer sur "Supprimer"

4. **Télécharger les nouveaux fichiers**
   - Cliquer sur "Télécharger" ou "Upload"
   - **Sélectionner TOUT le contenu de `build\web\`** :
     ```
     ✅ .htaccess (nouveau fichier de cache)
     ✅ index.html
     ✅ version.json
     ✅ version-check.js
     ✅ manifest.json
     ✅ flutter_bootstrap.js
     ✅ flutter_service_worker.js
     ✅ main.dart.js
     ✅ Dossier assets/
     ✅ Dossier canvaskit/
     ✅ Dossier icons/
     ✅ Dossier downloads/ (si présent)
     ✅ Tous les autres fichiers
     ```
   - Attendre la fin du téléchargement (barre de progression 100%)

#### Option B : FTP (FileZilla, WinSCP, etc.)

```
Hôte : ftp.votre-domaine.com
Utilisateur : votre-username
Mot de passe : votre-password
Port : 21 (ou 22 pour SFTP)
```

**Étapes :**
1. Connecter via FTP
2. Aller dans `public_html/`
3. Supprimer les anciens fichiers (sauf `.htaccess` initial)
4. Télécharger tout le contenu de `build\web\`
5. Vérifier que le transfert est complet

---

### Étape 4 : Vérification du `.htaccess`

**Vérifier que le fichier `.htaccess` a bien été téléchargé :**

1. Dans le gestionnaire de fichiers cPanel
2. Activer "Afficher les fichiers cachés" (icône ⚙️ en haut à droite)
3. Vérifier la présence de `.htaccess` à la racine
4. Ouvrir et vérifier qu'il contient bien les headers Cache-Control

**Si le `.htaccess` n'apparaît pas :**
- Les fichiers commençant par `.` sont cachés sur Windows
- Soit activer l'affichage dans l'Explorateur Windows
- Soit créer manuellement dans cPanel : "Nouveau fichier" → `.htaccess`
- Copier le contenu depuis `web\.htaccess`

---

## ✅ Vérification post-déploiement

### 1. Tests immédiats

**Ouvrir le site en navigation privée :**
```
https://www.nascentia-tech.com
```

**Points à vérifier :**
- ✅ Le site se charge en 2-5 secondes (pas 25s)
- ✅ Les images CDN s'affichent immédiatement
- ✅ Le scroll est fluide
- ✅ Les formulaires fonctionnent
- ✅ Pas d'erreurs dans la console (F12)

### 2. Vérifier le version.json

**Ouvrir dans le navigateur :**
```
https://www.nascentia-tech.com/version.json
```

**Doit contenir :**
```json
{
  "app_name": "nascentia",
  "version": "1.0.0",
  "build_number": "1",
  "build_hash": "1743078000",
  "build_date": "2026-03-24 14:30:00"
}
```

### 3. Vérifier les headers HTTP

**Utiliser l'outil de développement (F12) :**
1. Onglet **Network**
2. Recharger la page (Ctrl+R)
3. Cliquer sur `index.html`
4. Vérifier les headers `Response Headers` :

```http
Cache-Control: no-cache, no-store, must-revalidate
Pragma: no-cache
Expires: 0
```

### 4. Tester la détection de version

**Console JavaScript (F12) :**
```javascript
// Doit afficher :
✅ Version actuelle: {version: "1.0.0", buildNumber: "1", hash: "1743078000"}
✅ Version checker initialisé (intervalle: 5 min)
```

---

## 🔧 Résolution de problèmes

### Problème 1 : Les utilisateurs voient encore l'ancienne version

**Causes possibles :**
1. ❌ Le `.htaccess` n'a pas été téléchargé
2. ❌ Le serveur ne supporte pas `mod_headers` ou `mod_rewrite`
3. ❌ Le build n'a pas été fait correctement

**Solutions :**
```powershell
# 1. Vérifier le build
Get-Content "build\web\version.json" | ConvertFrom-Json

# 2. Rebuilder avec le nouveau script
.\build-prod.ps1

# 3. Vérifier que .htaccess existe bien sur le serveur
# 4. Contacter l'hébergeur si mod_headers n'est pas activé
```

---

### Problème 2 : Le site charge lentement (>10 secondes)

**Causes :**
- Mode développement au lieu de production
- Images non optimisées
- CDN Supabase lent

**Solutions :**
```powershell
# Toujours utiliser build-prod.ps1, JAMAIS run-dev.ps1 pour déployer
.\build-prod.ps1

# Vérifier la taille du bundle
Get-ChildItem "build\web\main.dart.js" | Select-Object Name, Length
# Doit être ~2-3 MB
```

---

### Problème 3 : La notification de mise à jour ne s'affiche pas

**Causes :**
- `version-check.js` manquant
- Erreurs JavaScript

**Solutions :**
1. Vérifier que `version-check.js` existe sur le serveur
2. Ouvrir la console (F12) et chercher les erreurs
3. Vérifier que le script est bien inclus dans `index.html` :
   ```html
   <script src="version-check.js"></script>
   ```

---

### Problème 4 : Erreur 500 après le déploiement

**Causes :**
- Erreur de syntaxe dans `.htaccess`
- Modules Apache non supportés

**Solutions :**
1. **Désactiver temporairement** les sections du `.htaccess` :
   ```apache
   # Commenter avec # pour tester
   # <IfModule mod_headers.c>
   #   ...
   # </IfModule>
   ```

2. **Version minimale du `.htaccess`** :
   ```apache
   # Redirection SPA
   <IfModule mod_rewrite.c>
     RewriteEngine On
     RewriteCond %{REQUEST_FILENAME} !-f
     RewriteCond %{REQUEST_FILENAME} !-d
     RewriteRule ^(.*)$ index.html [L]
   </IfModule>
   ```

3. Contacter le support de l'hébergeur pour activer les modules

---

## 📊 Monitoring post-déploiement

### Dashboard utilisateur

**Vérifier via Google Analytics ou similaire :**
- Temps de chargement moyen : **<5 secondes**
- Taux de rebond : **<40%**
- Pages vues par session : **>3**

### Tests réguliers

**Après chaque déploiement :**
1. Tester en navigation privée
2. Tester sur mobile (Chrome DevTools → Device Mode)
3. Vérifier les images CDN
4. Tester un formulaire de contact
5. Vérifier que la notification de version fonctionne

---

## 🎓 Bonnes pratiques

### ✅ À FAIRE

- ✅ Toujours utiliser `.\build-prod.ps1` avant de déployer
- ✅ Tester en local sur `http://localhost:8080` avant de télécharger
- ✅ Vérifier `version.json` après chaque build
- ✅ Garder une copie de sauvegarde avant de supprimer les anciens fichiers
- ✅ Télécharger le `.htaccess` à chaque déploiement
- ✅ Tester en navigation privée après déploiement

### ❌ À ÉVITER

- ❌ Ne JAMAIS déployer depuis `run-dev.ps1` ou un serveur de développement
- ❌ Ne pas oublier le `.htaccess` (fichier caché sous Windows)
- ❌ Ne pas modifier manuellement `version.json`
- ❌ Ne pas supprimer `version-check.js`
- ❌ Ne pas garder d'anciens fichiers mélangés avec les nouveaux

---

## 📞 Support

**En cas de problème persistant :**

1. **Journaux d'erreur cPanel**
   - cPanel → Métriques → Erreurs
   - Consulter les dernières erreurs Apache

2. **Console navigateur (F12)**
   - Onglet Console : erreurs JavaScript
   - Onglet Network : erreurs de chargement

3. **Contact hébergeur**
   - Demander l'activation de `mod_headers` et `mod_rewrite`
   - Vérifier les permissions du dossier
   - Vérifier les quotas PHP/Apache

---

## 🚀 Checklist de déploiement rapide

```
☐ 1. Lancer .\build-prod.ps1
☐ 2. Vérifier build\web\version.json contient un nouveau hash
☐ 3. (Optionnel) Tester en local : python -m http.server 8080
☐ 4. Connexion cPanel
☐ 5. Supprimer anciens fichiers (sauf .htaccess initial si important)
☐ 6. Télécharger TOUT le contenu de build\web\
☐ 7. Vérifier .htaccess est présent sur le serveur
☐ 8. Tester le site en navigation privée
☐ 9. Vérifier /version.json dans le navigateur
☐ 10. Vérifier la console (F12) : pas d'erreurs
```

---

## 📅 Fréquence de déploiement recommandée

- **Correctifs urgents** : Immédiat
- **Nouvelles fonctionnalités** : Hebdomadaire
- **Mise à jour de contenu** : Quotidien

**Avec ce système :**
- Les utilisateurs voient la nouvelle version en **maximum 5 minutes**
- Pas besoin de vider le cache manuellement
- Notification élégante et automatique

---

**🎉 Votre site est maintenant optimisé pour les déploiements sans friction !**
