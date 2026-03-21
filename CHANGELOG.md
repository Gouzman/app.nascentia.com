# CHANGELOG – Optimisations NASCENTIA

## Version actuelle — Branche `copilot/analyse-performance-securite-site`

Ce fichier documente toutes les modifications apportées au projet dans cette branche PR.

---

## 📥 Comment appliquer ces modifications dans VS Code

Ces modifications sont sur une branche Pull Request GitHub. Pour les avoir dans votre projet VS Code :

### Option 1 — Fusionner le PR sur GitHub puis tirer (recommandé)
```bash
# Dans le terminal VS Code (Ctrl+` pour ouvrir)
git fetch origin
git pull origin main
```

### Option 2 — Basculer sur la branche PR directement
```bash
# Dans le terminal VS Code (Ctrl+` pour ouvrir)
git fetch origin
git checkout copilot/analyse-performance-securite-site
```

### Option 3 — Via l'interface VS Code
1. Ouvrir la palette de commandes : `Ctrl+Shift+P`
2. Taper `Git: Fetch`
3. Puis `Git: Checkout to...`
4. Sélectionner `origin/copilot/analyse-performance-securite-site`

---

## 🔧 Liste des fichiers modifiés

### Nouveaux fichiers
| Fichier | Description |
|---------|-------------|
| `web/index.html` | Page HTML principale avec SEO complet, viewport mobile, écran de chargement animé |
| `web/manifest.json` | Manifest PWA (Progressive Web App) |

### Fichiers modifiés
| Fichier | Modification |
|---------|--------------|
| `.gitignore` | Correction : `web/` est un dossier source Flutter (pas de build) ; ajout de `tmpclaude-*` et `lib/downloads/*.apk` |
| `lib/services/supabase_config.dart` | Ajout de `apkDownloadUrl` pointant vers Supabase Storage |
| `lib/services/download_service.dart` | Ajout de `try/catch` sur toutes les méthodes réseau ; `print()` → `debugPrint()` |
| `lib/sections/app_section.dart` | Téléchargement APK via `SupabaseConfig.apkDownloadUrl` ; `debugPrint()` |
| `lib/pages/download_page.dart` | Idem APK URL + `cacheWidth: 800` sur les screenshots + `debugPrint()` |
| `lib/sections/fast_order_section.dart` | `cacheWidth: 900` sur `image_section2.png` (2,4 MB) |
| `lib/sections/personalized_support_section.dart` | `cacheWidth: 800` sur `image_section1.png` (944 KB) |
| `lib/sections/hero_section.dart` | `cacheWidth: 600` sur les images du mockup héro |
| `lib/sections/credibility_section.dart` | `cacheWidth: 200` sur les logos partenaires |
| `lib/widgets/phone_mockup.dart` | `cacheWidth: 600` sur les captures d'écran |
| `lib/widgets/top_navigation_bar.dart` | `cacheWidth: 124` sur le logo |

### Fichiers supprimés du dépôt
| Fichier | Raison |
|---------|--------|
| `lib/downloads/nascentia.apk` | Binaire de 79 MB — à héberger sur Supabase Storage |
| `tmpclaude-*` (17 fichiers) | Fichiers temporaires des agents IA |

---

## 🎯 Détail des changements

### 1. SEO & Affichage Web (`web/index.html`)
- Meta description, mots-clés, auteur
- Open Graph (partage Facebook/LinkedIn)
- Twitter Card
- Viewport mobile : `width=device-width, initial-scale=1.0, maximum-scale=5.0`
- `preconnect` vers Google Fonts et Supabase (réduit la latence)
- Écran de chargement animé avec branding NASCENTIA (gradient rose/violet)
- Masquage fluide au 1er frame Flutter (`flutter-first-frame` event)

### 2. PWA (`web/manifest.json`)
- Catégorie : `health`, `medical`, `lifestyle`
- Couleur de thème : `#E95263` (rose NASCENTIA)
- Icônes maskable (192×192 et 512×512)

### 3. Téléchargement APK ⚠️ Action requise
L'URL locale `/downloads/nascentia.apk` ne fonctionnait pas en production.
Remplacé par une URL configurable vers **Supabase Storage** :

```dart
// lib/services/supabase_config.dart
static const String apkDownloadUrl =
    '$url/storage/v1/object/public/uploads/nascentia.apk';
```

**Action à faire** :
1. Aller sur [Supabase Dashboard](https://supabase.com/dashboard)
2. Storage → Créer un bucket public `uploads`
3. Uploader `nascentia.apk`
4. Vérifier que l'URL correspond bien à celle dans `supabase_config.dart`

### 4. Performance images
`cacheWidth` ajouté pour plafonner la mémoire GPU :
- `image_section2.png` (2,4 MB) → `cacheWidth: 900`
- `image_section1.png` (944 KB) → `cacheWidth: 800`
- Phone mockups / screenshots → `cacheWidth: 600–800`
- Logo → `cacheWidth: 124`

### 5. Qualité & robustesse
- `print()` → `debugPrint()` (silencieux en release)
- `DownloadService` : `try/catch` ajoutés pour éviter les crashs réseau

---

*Généré le 2026-03-20*
