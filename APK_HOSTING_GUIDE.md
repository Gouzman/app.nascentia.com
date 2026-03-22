# 📦 Guide Hébergement APK - NASCENTIA (79 MB)

**Problème**: Supabase Storage gratuit limite les fichiers à 50 MB maximum.
**Fichier**: `nascentia.apk` (79 MB)
**Question**: Faut-il payer Supabase Pro (25$/mois)?

## ❌ NON - Voici les alternatives GRATUITES

---

## 🏆 Option 1: GitHub Releases (RECOMMANDÉ)

### ✅ Avantages
- **Totalement gratuit** (pas de limite)
- **Pas de limite de taille** de fichier
- **CDN ultra-rapide** (Microsoft/GitHub)
- **Versioning automatique** (v1.0.0, v1.1.0, v1.2.0...)
- **Statistiques de téléchargement** intégrées
- **Professionnellement accepté** (Google, Microsoft, Meta l'utilisent)
- **Changelog inclus** pour chaque version

### 📝 Installation (5 minutes)

#### Étape 1: Créer le repository

1. Allez sur https://github.com/new
2. **Repository name**: `nascentia-app`
3. **Description**: `📱 Application mobile NASCENTIA - Planification familiale scientifique`
4. **Visibility**: Public (ou Private, les deux fonctionnent)
5. Cliquez **Create repository**

#### Étape 2: Créer la première release

1. Sur votre nouveau repo → Cliquez **Releases** (colonne droite)
2. Cliquez **Create a new release**
3. Remplissez:

```
Tag: v1.0.0
Release title: 🎉 NASCENTIA v1.0.0 - Version Initiale

Description:
## 📱 NASCENTIA v1.0.0

Application mobile officielle pour la planification familiale scientifique basée sur la méthode NASCENTIA.

### 📦 Téléchargement & Installation

1. **Téléchargez** `nascentia.apk` ci-dessous
2. Sur votre téléphone Android:
   - Allez dans **Paramètres** → **Sécurité**
   - Activez **Sources inconnues** ou **Installer des applications inconnues**
3. Ouvrez le fichier `.apk` téléchargé
4. Suivez les instructions d'installation

### ✨ Fonctionnalités

- 🔬 Planification scientifique du sexe du bébé
- 📅 Calendrier de fertilité personnalisé
- 💬 Support client intégré
- 📊 Statistiques de cycles
- 🔔 Notifications intelligentes

### 📱 Compatibilité

- **Android**: 6.0+ (API 23+)
- **Taille**: 79 MB
- **Version**: 1.0.0 (Build 1)

### 🆘 Support

Pour toute question: contact@nascentia-tech.com

---

© 2026 NASCENTIA-TECH. Tous droits réservés.
```

4. **Attach binaries**: Glissez-déposez votre fichier `nascentia.apk`
5. Cliquez **Publish release** 🎉

#### Étape 3: Récupérer l'URL

Après publication, l'URL sera:

```
https://github.com/VOTRE-USERNAME/nascentia-app/releases/download/v1.0.0/nascentia.apk
```

**Exemple**:
```
https://github.com/nascentia-tech/nascentia-app/releases/download/v1.0.0/nascentia.apk
```

#### Étape 4: Mettre à jour votre code

Le fichier `lib/services/supabase_config.dart` a déjà été mis à jour!

Remplacez juste `VOTRE-USERNAME` par votre nom d'utilisateur GitHub:

```dart
// Ligne 30 de supabase_config.dart
defaultValue: 'https://github.com/nascentia-tech/nascentia-app/releases/download/v1.0.0/nascentia.apk',
```

### 🔄 Mise à jour Future

Quand vous aurez une nouvelle version (v1.1.0):

1. Releases → **Draft a new release**
2. Tag : `v1.1.0`
3. Upload le nouveau APK
4. Mettez à jour l'URL dans le code avec `v1.1.0`

---

## 🌐 Option 2: Cloudflare R2 (Gratuit 10GB/mois)

### ✅ Avantages
- **10 GB gratuits** par mois
- **Pas de frais de sortie** (bandwidth gratuit)
- **CDN mondial Cloudflare**
- **URLs personnalisées** possibles

### 📝 Installation (10 minutes)

1. Créez un compte sur https://dash.cloudflare.com/sign-up
2. Allez dans **R2** (menu gauche)
3. Cliquez **Create bucket**
   - Name: `nascentia-apk`
   - Location: Automatic
4. Uploadez `nascentia.apk`
5. Cliquez sur le fichier → **Get Public URL**
6. Copiez l'URL et mettez-la dans `supabase_config.dart`

**URL exemple**:
```
https://pub-abc123.r2.dev/nascentia.apk
```

### 💰 Tarifs
- **Gratuit**: 10 GB stockage/mois
- **Dépassement**: 0.015$/GB (très peu cher)
- **Bandwidth**: GRATUIT (contrairement à AWS S3)

---

## 📦 Option 3: Bunny.net Edge Storage (Gratuit 25GB)

### ✅ Avantages
- **25 GB gratuits** par mois
- **CDN ultra-rapide** (200+ POPs)
- **Prix bas** après quota gratuit
- **Interface simple**

### 📝 Installation (5 minutes)

1. Inscrivez-vous sur https://bunny.net
2. Storage → **Add Storage Zone**
   - Name: `nascentia`
   - Region: Africa / Europe (le plus proche)
3. Upload `nascentia.apk`
4. Enable **CDN**
5. Copiez l'URL CDN

**URL exemple**:
```
https://nascentia.b-cdn.net/nascentia.apk
```

### 💰 Tarifs
- **Gratuit**: 25 GB trafic/mois
- **Stockage**: 0.01$/GB/mois (très peu cher)
- **Bandwidth après quota**: 0.01$/GB

---

## 🔥 Option 4: Firebase Storage (Blaze Plan)

### ⚠️ Limitation
- **Spark (gratuit)**: Max 10 MB par fichier ❌
- **Blaze (pay-as-you-go)**: Pas de limite, mais **BESOIN CARTE BANCAIRE**

### 💰 Tarifs Blaze
- **Stockage**: 0.026$/GB/mois (2$ pour 79MB)
- **Download**: 0.12$/GB (9.5$ pour 100 téléchargements)
- **Quota gratuit**: 5 GB stockage + 1 GB download/jour

**Verdict**: Plus cher que les autres options ❌

---

## ❌ Option 5: Supabase Pro (PAS RECOMMANDÉ)

### 💸 Tarifs
- **25$/mois** (~30,000 FCFA/mois)
- Limite: 5 GB stockage
- Download: 200 GB/mois

**Verdict**: **TROP CHER** juste pour héberger un APK! Utilisez Supabase uniquement pour votre base de données (gratuit).

---

## 📊 Comparaison Complète

| Service | Prix | Limite Fichier | Bandwidth | CDN | Versioning |
|---------|------|----------------|-----------|-----|------------|
| **GitHub Releases** ⭐ | **GRATUIT** | **Illimité** | Illimité | ✅ Mondial | ✅ Auto |
| Cloudflare R2 | Gratuit 10GB | Illimité | **GRATUIT** | ✅ 200+ POPs | ❌ |
| Bunny.net | Gratuit 25GB | Illimité | 25GB gratuit | ✅ 200+ POPs | ❌ |
| Firebase Blaze | ~11$/mois | Illimité | ~9.5$/100 DL | ✅ Google | ❌ |
| Supabase Pro | **25$/mois** | 5GB max | 200GB | ✅ | ❌ |

**Verdict Final**: **GitHub Releases** est le meilleur choix! 🏆

---

## 🎯 Recommandation Finale

### Pour NASCENTIA, utilisez:

1. **GitHub Releases** pour l'APK (gratuit, illimité, professionnel)
2. **Supabase gratuit** pour votre base de données (reviews, stats)
3. **Brevo** pour les emails professionnels (gratuit 300 emails/jour)

### Économies réalisées

Au lieu de payer **25$/mois × 12 = 300$/an** pour Supabase Pro, vous économisez **300$/an** en utilisant GitHub Releases! 💰

---

## 🚀 Action Immédiate

**Créez votre GitHub Release maintenant** (5 minutes):

1. https://github.com/new → `nascentia-app`
2. Releases → Create new release → Tag `v1.0.0`
3. Upload `nascentia.apk`
4. Publiez!
5. Copiez l'URL
6. Mettez à jour `supabase_config.dart` ligne 30

✅ **C'est fait!** Vous avez maintenant un hébergement APK professionnel et gratuit.

---

**Besoin d'aide?** Demandez-moi de vous guider étape par étape! 😊
