# 📦 Guide Complet: Créer une GitHub Release pour NASCENTIA APK

**Temps estimé**: 5 minutes ⏱️
**Niveau**: Débutant ✅
**Coût**: GRATUIT 🎉

---

## 🎯 Objectif

Héberger votre fichier `nascentia.apk` (79 MB) gratuitement sur GitHub Releases au lieu de payer Supabase Pro 25$/mois.

---

## 📋 Prérequis

- ✅ Compte GitHub (si vous n'en avez pas: https://github.com/signup)
- ✅ Votre fichier `nascentia.apk` prêt (79 MB)
- ✅ Repository existant `app.nascentia.com` (ou créer un nouveau)

---

## 🚀 Étapes Détaillées

### **Étape 1: Accéder à votre Repository**

1. Allez sur https://github.com
2. Connectez-vous avec votre compte
3. Trouvez votre repository `app.nascentia.com`
4. Cliquez dessus pour l'ouvrir

**URL exemple**: `https://github.com/votre-username/app.nascentia.com`

---

### **Étape 2: Ouvrir la Section Releases**

Sur la page de votre repository:

1. **Regardez la colonne de droite** (sidebar)
2. Trouvez la section **"Releases"**
3. Cliquez sur **"Releases"** ou **"Create a new release"**

```
┌─────────────────────────────┐
│  About                      │
│  🌐 nascentia.com          │
├─────────────────────────────┤
│  📦 Releases                │  ← CLIQUEZ ICI
│     0 releases              │
├─────────────────────────────┤
│  📦 Packages                │
│  🚀 Deployments             │
└─────────────────────────────┘
```

---

### **Étape 3: Créer une Nouvelle Release**

Vous êtes maintenant sur la page des Releases:

1. Cliquez sur le bouton vert **"Create a new release"**
2. Vous arrivez sur le formulaire de création

---

### **Étape 4: Remplir les Informations de la Release**

#### **A) Choose a tag** (obligatoire)

Dans le premier champ en haut:

```
Choose a tag
[app-v1.0.0                    ▼]
```

1. Cliquez sur le champ
2. Tapez: `app-v1.0.0`
3. Cliquez sur **"+ Create new tag: app-v1.0.0 on publish"**

**Note**: Le préfixe `app-` permet de différencier les versions de l'application mobile des versions du site web.

---

#### **B) Release title** (obligatoire)

```
Release title (optional but recommended)
[🎉 NASCENTIA v1.0.0 - Version Initiale]
```

Copiez-collez:
```
🎉 NASCENTIA v1.0.0 - Version Initiale
```

---

#### **C) Describe this release** (recommandé)

Dans la grande zone de texte, copiez-collez ceci:

```markdown
## 📱 NASCENTIA v1.0.0

Application mobile officielle pour la planification familiale scientifique basée sur la méthode NASCENTIA.

### 📦 Téléchargement & Installation

1. **Téléchargez** le fichier `nascentia.apk` ci-dessous
2. Sur votre téléphone Android:
   - Allez dans **Paramètres** → **Sécurité**
   - Activez **Sources inconnues** ou **Installer des applications inconnues**
   - (Sur les versions récentes: autorisez votre navigateur ou gestionnaire de fichiers)
3. Ouvrez le fichier `.apk` téléchargé
4. Suivez les instructions d'installation
5. L'icône NASCENTIA apparaîtra sur votre écran d'accueil

### ✨ Fonctionnalités

- 🔬 **Planification scientifique** du sexe du bébé selon la méthode NASCENTIA
- 📅 **Calendrier de fertilité** personnalisé et précis
- 💬 **Support client intégré** pour toutes vos questions
- 📊 **Suivi de cycles** avec statistiques détaillées
- 🔔 **Notifications intelligentes** pour ne jamais manquer une date importante
- 🌍 **Interface intuitive** en français

### 📱 Compatibilité

- **Système**: Android 6.0+ (API 23+)
- **Taille**: 79 MB
- **Version**: 1.0.0 (Build 1)
- **Dernière mise à jour**: Mars 2026

### 🔒 Sécurité

✅ Application certifiée par NASCENTIA
✅ Aucune donnée sensible partagée avec des tiers
✅ Conformité RGPD européenne

### 🆘 Support & Contact

**Besoin d'aide?**
- 📧 Email: nascentia.info@gmail.com
- 🌐 Site web: https://nascentia-tech.com
- 💬 Support disponible Lun-Ven 9h-18h

**Problèmes d'installation?**
Si l'installation échoue, vérifiez que:
1. Vous avez autorisé les "Sources inconnues"
2. Votre Android est version 6.0 ou supérieure
3. Vous avez au moins 200 MB d'espace disponible

---

**© 2026 NASCENTIA-TECH. Tous droits réservés.**
```

---

#### **D) Attach binaries** (IMPORTANT!)

C'est ici que vous uploadez votre APK:

1. Faites défiler jusqu'à la section **"Attach binaries by dropping them here or selecting them"**
2. **Méthode 1**: Glissez-déposez votre fichier `nascentia.apk` dans la zone
3. **Méthode 2**: Cliquez sur **"selecting them"** et choisissez `nascentia.apk`

```
┌─────────────────────────────────────────┐
│ Attach binaries by dropping them here  │
│ or selecting them.                      │
│                                         │
│     [Glissez nascentia.apk ici]        │
│                                         │
└─────────────────────────────────────────┘
```

**Attendez que le fichier soit uploadé** (79 MB peut prendre 1-2 minutes selon votre connexion)

Vous verrez:
```
✓ nascentia.apk (79.0 MB)
```

---

#### **E) Options supplémentaires** (optionnel)

Cochez **"Set as a pre-release"** si c'est une version beta/test (sinon laissez décoché).

---

### **Étape 5: Publier la Release**

1. Vérifiez que tout est correct:
   - ✅ Tag: `app-v1.0.0`
   - ✅ Title: `🎉 NASCENTIA v1.0.0 - Version Initiale`
   - ✅ Description remplie
   - ✅ Fichier `nascentia.apk` uploadé

2. Cliquez sur le bouton vert **"Publish release"**

**C'EST FAIT! 🎉**

---

### **Étape 6: Récupérer l'URL de Téléchargement**

Après publication, vous êtes redirigé vers la page de la release.

1. Faites défiler jusqu'à la section **"Assets"**
2. Vous verrez:

```
Assets
  📦 Source code (zip)
  📦 Source code (tar.gz)
  📱 nascentia.apk    79.0 MB
```

3. **Clic droit** sur `nascentia.apk`
4. Choisissez **"Copier l'adresse du lien"** ou **"Copy link address"**

**L'URL sera au format**:
```
https://github.com/VOTRE-USERNAME/app.nascentia.com/releases/download/app-v1.0.0/nascentia.apk
```

**Exemple concret**:
```
https://github.com/nascentia-tech/app.nascentia.com/releases/download/app-v1.0.0/nascentia.apk
```

---

### **Étape 7: Mettre à Jour Votre Code Flutter**

1. Ouvrez le fichier `lib/services/supabase_config.dart`
2. Trouvez la ligne 30 environ (ou cherchez `apkDownloadUrl`)
3. Remplacez `VOTRE-USERNAME` par votre vrai username GitHub

**AVANT**:
```dart
defaultValue: 'https://github.com/VOTRE-USERNAME/app.nascentia.com/releases/download/app-v1.0.0/nascentia.apk',
```

**APRÈS** (exemple avec username `nascentia-tech`):
```dart
defaultValue: 'https://github.com/nascentia-tech/app.nascentia.com/releases/download/app-v1.0.0/nascentia.apk',
```

4. **Sauvegardez** le fichier (Ctrl+S)

---

### **Étape 8: Tester le Téléchargement**

1. Ouvrez un navigateur
2. Collez l'URL copiée à l'étape 6
3. Appuyez sur Entrée
4. **Le téléchargement de l'APK doit démarrer automatiquement** 🎉

Si ça fonctionne → **Parfait! Votre hébergement APK est opérationnel!**

---

## ✅ Vérification Complète

Checklist finale:

- [ ] Release créée avec tag `app-v1.0.0`
- [ ] Fichier `nascentia.apk` visible dans Assets
- [ ] URL de téléchargement testée et fonctionnelle
- [ ] `supabase_config.dart` mis à jour avec la bonne URL
- [ ] Bouton "Télécharger" sur votre site web fonctionne

---

## 🔄 Futures Mises à Jour (v1.1.0, v1.2.0...)

Quand vous aurez une nouvelle version de l'application:

1. Retournez sur **Releases**
2. Cliquez **"Draft a new release"**
3. Tag: `app-v1.1.0` (incrémenter la version)
4. Title: `🎉 NASCENTIA v1.1.0 - Nouvelles Fonctionnalités`
5. Uploadez le nouveau APK
6. Publiez
7. Mettez à jour l'URL dans `supabase_config.dart`

---

## 💡 Conseils Pro

### **Versioning Sémantique**

Utilisez le format `MAJOR.MINOR.PATCH`:

- **MAJOR** (1.0.0): Changements majeurs incompatibles
- **MINOR** (1.1.0): Nouvelles fonctionnalités compatibles
- **PATCH** (1.0.1): Corrections de bugs

**Exemples**:
- `app-v1.0.0` → Version initiale
- `app-v1.0.1` → Correction de bugs
- `app-v1.1.0` → Nouvelles fonctionnalités
- `app-v2.0.0` → Refonte majeure

### **Statistiques de Téléchargement**

GitHub vous donne automatiquement:
- Nombre de téléchargements par release
- Graphiques de popularité
- Historique des versions

### **Notifications Automatiques**

Les utilisateurs qui "Watch" votre repo seront notifiés automatiquement de chaque nouvelle release!

---

## ❓ Dépannage

### **Problème 1: Le fichier APK n'apparaît pas dans Assets**

**Solution**: Vérifiez que l'upload est terminé (barre de progression à 100%) avant de publier.

### **Problème 2: Erreur 404 lors du téléchargement**

**Vérifiez**:
- L'URL est exacte (copier-coller depuis GitHub)
- Votre username GitHub est correct
- Le tag est bien `app-v1.0.0` (sensible à la casse)

### **Problème 3: Repository privé → Téléchargement impossible**

**Solution**:
- Option 1: Rendez le repository public (Settings → Danger Zone → Change visibility)
- Option 2: Générez un token GitHub et ajoutez-le à l'URL (complexe, pas recommandé)

### **Problème 4: Le bouton "Create a new release" n'apparaît pas**

**Solution**: Vérifiez que vous avez les droits d'administration sur le repository.

---

## 🎉 Félicitations!

Vous avez maintenant:

✅ **Hébergement APK gratuit** (économie de 300$/an vs Supabase Pro)
✅ **CDN GitHub ultra-rapide** (téléchargements mondiaux)
✅ **Versioning professionnel** (comme Google, Microsoft, etc.)
✅ **Statistiques intégrées** (nombre de téléchargements)
✅ **Solution pérenne** (GitHub ne fermera pas demain)

---

## 📞 Besoin d'Aide?

Si vous rencontrez des difficultés:

1. Relisez les étapes ci-dessus
2. Vérifiez la section Dépannage
3. Demandez-moi de l'aide en décrivant précisément le problème

**Bon lancement de NASCENTIA! 🚀**
