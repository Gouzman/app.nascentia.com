# 📱 Analyse Affichage Mobile & Optimisation Images - NASCENTIA

## 🔍 État Actuel

### ✅ Ce qui fonctionne bien

1. **Images optimisées** :
   - Toutes les images ont `cacheWidth` pour réduire l'utilisation RAM de ~60-70%
   - Breakpoints responsive correctement appliqués (768px mobile)
   - Padding adaptatif pour éviter les débordements

2. **Corrections responsive déjà en place** :
   - Images ne dépassent pas l'écran (max 70-75% largeur)
   - Espacement adaptatif selon taille d'écran
   - Font sizes respectent WCAG (minimum 12px)

### ⚠️ Éléments cachés sur mobile

#### Hero Section (Section principale)
**Fichier**: `lib/sections/hero_section.dart` (ligne 92-95)

```dart
if (!isMobile)
  Positioned.fill(
    child: _buildPhoneMockups(context, isDesktop),
  ),
```

**Problème**: Les maquettes de téléphones ne s'affichent **PAS sur mobile** pour économiser l'espace.

**Impact**: Sur téléphone, seul le texte et le bouton sont visibles dans la section hero.

---

## 🚀 Optimisations Recommandées pour Accélérer l'Affichage

### 1️⃣ **Lazy Loading des Images**

Actuellement toutes les images se chargent au démarrage. Recommandation: charger uniquement les images visibles.

**Solution**: Ajouter un widget `ScrollReveal` ou utiliser `addPostFrameCallback`

```dart
// À ajouter dans chaque section avec images
class PersonalizedSupportSection extends StatefulWidget {
  @override
  State<PersonalizedSupportSection> createState() => _PersonalizedSupportSectionState();
}

class _PersonalizedSupportSectionState extends State<PersonalizedSupportSection> {
  bool _imageVisible = false;

  @override
  void initState() {
    super.initState();
    // Charger l'image après 100ms (priorité au texte)
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _imageVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Texte affiché immédiatement
        Text('...'),

        // Image chargée après
        if (_imageVisible)
          Image.asset('...', cacheWidth: 800)
        else
          SizedBox(height: 200), // Placeholder
      ],
    );
  }
}
```

**Gain estimé**: -300ms temps de chargement initial

---

### 2️⃣ **Utiliser `precacheImage` pour les images critiques**

**Fichier à modifier**: `lib/main.dart`

```dart
Future<void> precacheAppImages(BuildContext context) async {
  final imagesToPrecache = [
    // ✅ Déjà configuré - Logo principal
    'lib/assets/images/logo-nascentia.png',

    // ✅ Déjà configuré - Images hero section
    'lib/assets/images/image_header-1.png',
    'lib/assets/images/image_header-2.png',

    // 🆕 À AJOUTER - Images critiques chargées après le premier frame
    'lib/assets/images/image_section1.png', // 944 KB
    'lib/assets/images/image_section2.png', // 2.4 MB
  ];

  try {
    // Charger en parallèle avec limite
    for (var i = 0; i < imagesToPrecache.length; i += 2) {
      await Future.wait(
        imagesToPrecache
            .skip(i)
            .take(2)
            .map((path) => precacheImage(AssetImage(path), context)),
      );
    }
    debugPrint('✅ Images précachées avec succès');
  } catch (e) {
    debugPrint('⚠️ Erreur lors du précache des images: $e');
  }
}
```

**Gain estimé**: Images prêtes immédiatement au scroll, pas de flash blanc

---

### 3️⃣ **Compression des images lourdes**

| Fichier | Taille Actuelle | Taille Optimale | Outil |
|---------|----------------|-----------------|-------|
| `image_section2.png` | **2.4 MB** | ~600 KB | TinyPNG/ImageOptim |
| `image_section1.png` | **944 KB** | ~300 KB | TinyPNG/ImageOptim |
| `Download_ScrenShot-*.jpg` | 800KB-1.4MB | ~200 KB | JPEGmini |

**Action**:
```powershell
# Compresser avec TinyPNG CLI
npx tinypng-cli lib/assets/images/*.png -o lib/assets/images/
```

**Gain estimé**: -70% taille fichiers = chargement 3x plus rapide

---

### 4️⃣ **WebP pour le Web**

Flutter Web ne charge pas les images aussi efficacement que les binaires mobile.

**Solution**: Ajouter un helper qui détecte la plateforme

```dart
// lib/utils/image_helper.dart
import 'package:flutter/foundation.dart';

String getOptimizedImagePath(String basePath) {
  if (kIsWeb) {
    // Remplacer .png par .webp pour le web
    return basePath.replaceAll('.png', '.webp').replaceAll('.jpg', '.webp');
  }
  return basePath;
}

// Utilisation
Image.asset(
  getOptimizedImagePath('lib/assets/images/image_section1.png'),
  cacheWidth: 800,
)
```

**Gain estimé**: -60% taille pour le Web

---

### 5️⃣ **cacheHeight en plus de cacheWidth**

**Actuellement**: Seul `cacheWidth` est défini
**Recommandation**: Ajouter `cacheHeight` pour ratio d'aspect exact

```dart
// hero_section.dart - ligne 393
Image.asset(
  widget.imagePath,
  fit: BoxFit.cover,
  cacheWidth: 600,
  cacheHeight: 1200, // 🆕 Ratio 1:2 pour mockup phone
)

// fast_order_section.dart - ligne 116
Image.asset(
  'lib/assets/images/image_section2.png',
  fit: BoxFit.cover,
  cacheWidth: 900,
  cacheHeight: 600, // 🆕 Ratio 3:2
)
```

**Gain estimé**: -15% utilisation mémoire supplémentaire

---

### 6️⃣ **Afficher une version simplifiée sur mobile**

Pour la Hero Section, afficher un mockup plus petit sur mobile au lieu de rien.

```dart
// hero_section.dart - ligne 92-95 (ACTUEL)
if (!isMobile)
  Positioned.fill(
    child: _buildPhoneMockups(context, isDesktop),
  ),

// PROPOSÉ:
if (!isMobile)
  Positioned.fill(
    child: _buildPhoneMockups(context, isDesktop),
  )
else
  // Mockup simplifié sur mobile (sous le bouton CTA)
  Padding(
    padding: const EdgeInsets.only(top: 24),
    child: _buildSingleMockup(context), // 1 seul téléphone au lieu de 2
  ),
```

---

## 📊 Résumé des Gains Potentiels

| Optimisation | Difficulté | Gain Temps | Gain RAM | Priorité |
|--------------|------------|------------|----------|----------|
| Lazy Loading images | Moyenne | **-300ms** | -20% | 🔥 Haute |
| Compression images | Facile | **-500ms** | -10% | 🔥 Haute |
| cacheHeight | Facile | 0ms | **-15%** | ⚡ Moyenne |
| WebP pour Web | Moyenne | **-400ms** (web) | 0% | ⚡ Moyenne |
| Precache amélioré | Facile | **-200ms** | 0% | ✅ Basse |
| Mockup mobile | Facile | 0ms | 0% | ✅ Basse |

**GAIN TOTAL ESTIMÉ**:
- ⏱️ **-1 seconde** de temps de chargement initial
- 💾 **-45% RAM** utilisée par les images
- 📱 **Meilleure expérience mobile** avec contenu adapté

---

## 🛠️ Plan d'Action Recommandé

### Phase 1 : Quick Wins (30 min) ✅
1. Compresser `image_section1.png` et `image_section2.png` avec TinyPNG
2. Ajouter `cacheHeight` à tous les `Image.asset`
3. Mettre à jour `precacheAppImages` dans `main.dart`

### Phase 2 : Lazy Loading (1h) ⚡
1. Créer `lib/widgets/lazy_image.dart` widget réutilisable
2. Remplacer Image.asset dans les sections non-critiques
3. Tester sur Chrome DevTools (Network throttling)

### Phase 3 : WebP & Optimisations avancées (2h) 🚀
1. Convertir toutes les images en WebP
2. Créer helper `getOptimizedImagePath`
3. Ajouter mockup simplifié sur mobile dans Hero Section

---

## 🧪 Test de Performance

### Commandes Flutter DevTools

```powershell
# Analyser la performance
flutter run --profile -d chrome

# Dans DevTools:
# 1. Onglet "Performance" → Record
# 2. Scroll sur toutes les sections
# 3. Stop → Analyser les "Build" times
```

### Métriques Cibles

| Métrique | Actuel | Cible | Status |
|----------|--------|-------|--------|
| First Contentful Paint (FCP) | ? | < 1.5s | ⏳ À mesurer |
| Largest Contentful Paint (LCP) | ? | < 2.5s | ⏳ À mesurer |
| Time to Interactive (TTI) | ? | < 3.5s | ⏳ À mesurer |
| Cumulative Layout Shift (CLS) | ? | < 0.1 | ⏳ À mesurer |

---

## 📝 Notes Importantes

1. **Ne pas supprimer `cacheWidth`** : Cette optimisation est cruciale et déjà en place
2. **Tester sur vrais devices** : Le simulateur ne reflète pas les vraies performances réseau
3. **Build en mode --release** : Toujours tester avec `flutter build web --release` avant déploiement

---

## ✨ Résultat Attendu

Après toutes les optimisations :
- ✅ Site charge en **< 2 secondes** sur 3G
- ✅ Images apparaissent **instantanément** au scroll
- ✅ **Aucun flash** ou placeholder blanc
- ✅ Utilisation RAM réduite de **50%** sur mobile
- ✅ Contenu **adapté** selon la taille d'écran

**Voulez-vous que j'implémente les Quick Wins (Phase 1) maintenant ?** 🚀
