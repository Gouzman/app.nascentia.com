# Instructions GitHub Copilot — NASCENTIA Web

## Vue d'ensemble du projet

Site **Flutter web** (landing page) pour l'application mobile NASCENTIA.  
Page unique avec navigation smooth-scroll entre sections.

**Stack :** Flutter 3.x / Dart 3.x — cible `web` uniquement.

---

## Commandes essentielles

```bash
flutter pub get          # installer les dépendances
flutter run -d chrome    # lancer en développement
flutter build web        # build de production → build/web/
flutter analyze          # analyser le code
flutter test             # lancer les tests
```

---

## Structure des fichiers — où créer quoi

```
lib/
├── main.dart                     # point d'entrée (ne pas modifier)
├── app.dart                      # MaterialApp + routes nommées
├── pages/                        # ← nouvelles PAGES ici
│   ├── home_page.dart
│   └── download_page.dart
├── sections/                     # ← nouvelles SECTIONS ici
│   ├── hero_section.dart
│   ├── features_section.dart
│   └── ...
├── widgets/                      # ← nouveaux WIDGETS réutilisables ici
│   ├── primary_button.dart
│   ├── section_container.dart
│   └── ...
├── services/                     # ← nouveaux SERVICES ici
│   ├── navigation_service.dart
│   └── supabase_config.dart
└── theme/                        # design system (ne pas modifier sauf ajout)
    ├── app_colors.dart
    ├── app_text_styles.dart
    ├── app_constants.dart
    └── app_theme.dart

web/                              # fichiers HTML/PWA (manifest, index.html)
assets/images/                    # images phone mockup
```

---

## Comment ajouter une nouvelle section

1. **Créer** `lib/sections/ma_section.dart` :

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_constants.dart';
import '../widgets/section_container.dart';

class MaSection extends StatelessWidget {
  const MaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        children: [
          Text('Titre', style: AppTextStyles.sectionTitle(context)),
        ],
      ),
    );
  }
}
```

2. **Enregistrer la clé de navigation** dans `lib/services/navigation_service.dart` :

```dart
static final GlobalKey maSectionKey = GlobalKey();
// Ajouter dans la map `sections` :
'Ma Section': maSectionKey,
```

3. **Insérer la section** dans `lib/pages/home_page.dart` à l'endroit voulu dans le `SingleChildScrollView`.

---

## Comment ajouter une nouvelle page

1. **Créer** `lib/pages/ma_page.dart` avec un `Scaffold`.
2. **Enregistrer la route** dans `lib/app.dart` :

```dart
routes: {
  '/': (context) => const HomePage(),
  '/download': (context) => const DownloadPage(),
  '/ma-page': (context) => const MaPage(),   // ← ajouter ici
},
```

---

## Système de design — TOUJOURS utiliser ces classes

### Couleurs (`lib/theme/app_colors.dart`)
- Palette primaire : rose `#E95263` + violet `#582674`
- **Utiliser** `AppColors.primary`, `AppColors.primaryGradient`
- **Transparence** : `.withValues(alpha: 0.5)` — **jamais** `.withOpacity()`

### Typographie (`lib/theme/app_text_styles.dart`)
- Toutes les méthodes prennent `BuildContext` (responsive)
- **Utiliser** `AppTextStyles.sectionTitle(context)`, `.bodyLarge(context)`, etc.
- **Personnaliser** avec `.copyWith(color: ...)` uniquement
- **Jamais** `TextStyle()` brut ni `fontSize` codé en dur

### Espacement (`lib/theme/app_constants.dart`)
- Multiples de 4/8 px : `AppConstants.spacingS`, `.spacingM`, `.spacingL`, `.spacingXL`
- Rayons : `AppConstants.borderRadius`, `.borderRadiusLarge`
- Breakpoints : `.breakpointMobile` (768), `.breakpointDesktop` (1440)
- Largeur max contenu : `.maxContentWidth` (1200)

---

## Widgets réutilisables — priorité à ces composants

| Widget | Usage |
|--------|-------|
| `SectionContainer` | Wrapper obligatoire pour chaque section |
| `PrimaryButton` | Bouton gradient avec animation hover |
| `GradientBackground` | Fond dégradé pleine largeur |
| `PhoneMockup` | Cadre téléphone pour screenshots |
| `FeatureCardModern` | Carte avec fond gradient |
| `TopNavigationBar` | Navigation flottante pill-style |
| `AppFooter` | Pied de page (aussi section Contact) |

---

## Ordre des sections dans `HomePage`

```
TopNavigationBar
HeroSection
PersonalizedSupportSection
FastOrderSection
AboutSection
CredibilitySection
FeaturesSection
HowItWorksSection
CalendarSection
AppSection
AppFooter  (contact)
```

---

## Conventions clés

- Toutes les sections sont `StatelessWidget` sauf si elles ont une animation.
- Interactions hover : `MouseRegion` + `GestureDetector` (pas `InkWell`).
- Boutons : `Builder` pour accéder au `BuildContext` → `Navigator.pushNamed`.
- Responsive : utiliser `LayoutBuilder` ou `MediaQuery.of(context).size.width`.
- Imports : chemins relatifs dans `lib/`, pas de `package:nascentia/...`.
- Pas de logique métier dans les widgets → utiliser `lib/services/`.
