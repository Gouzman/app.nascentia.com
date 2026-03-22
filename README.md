# NASCENTIA - Site Web Officiel

Site web Flutter de l'application mobile NASCENTIA - Comprendre, déterminer et planifier le sexe de votre bébé.

## 🚀 Installation

1. Vérifier que Flutter est installé :
```bash
flutter --version
```

2. Installer les dépendances :
```bash
flutter pub get
```

## 📱 Lancement en mode développement

### Web
```bash
flutter run -d chrome
```

### Build pour production
```bash
flutter build web
```

Le site sera généré dans le dossier `build/web/`

## 📁 Structure du projet

```
lib/
 ├── main.dart                 # Point d'entrée de l'application
 ├── app.dart                  # Configuration de l'application
 ├── theme/                    # Thème et styles
 │    ├── app_colors.dart      # Couleurs de l'application
 │    ├── app_text_styles.dart # Styles de texte
 │    └── app_theme.dart       # Thème général
 ├── pages/
 │    └── home_page.dart       # Page d'accueil principale
 ├── sections/                 # Sections de la landing page
 │    ├── hero_section.dart           # Section hero (plein écran)
 │    ├── about_section.dart          # À propos de NASCENTIA
 │    ├── credibility_section.dart    # Crédibilité scientifique
 │    ├── features_section.dart       # Fonctionnalités clés
 │    ├── how_it_works_section.dart   # Comment ça marche
 │    ├── calendar_section.dart       # Calendrier intelligent
 │    ├── app_section.dart            # Application mobile
 │    └── contact_section.dart        # Contact
 └── widgets/                  # Widgets réutilisables
      ├── gradient_background.dart # Fond dégradé
      ├── primary_button.dart      # Bouton principal
      ├── phone_mockup.dart        # Mockup de téléphone
      └── section_container.dart   # Container de section
```

## 🎨 Design System

### Couleurs
- **Violet principal** : `#6A4CFF`
- **Bleu** : `#4DA3FF`
- **Blanc** : `#FFFFFF`
- **Texte sombre** : `#1E1E1E`
- **Texte gris** : `#666666`

### Dégradé principal
LinearGradient violet → bleu

### Typography
Police : Poppins (via Google Fonts)

## 📸 Assets

Placer les mockups de téléphone dans :
- `assets/images/phone_1.png`
- `assets/images/phone_2.png`

## 🌐 Déploiement

### Firebase Hosting
```bash
firebase init hosting
firebase deploy
```

### Netlify
Glisser-déposer le dossier `build/web/` sur netlify.com

### Vercel
```bash
vercel --prod
```

## ⚙️ Configuration

Le site est configuré pour être :
- ✅ Responsive (Desktop, Tablette, Mobile)
- ✅ Optimisé pour le SEO
- ✅ Animations fluides
- ✅ Performance optimale

## 📧 Contact

**NASCENTIA**
- Fondateur : Doumbia Hugues
- Email : doumbiabonmanin@gmail.com
- Téléphone : (+225) 07 78 68 33 53
- Localisation : Cocody, Côte d'Ivoire

---

© 2026 NASCENTIA-TECH. Tous droits réservés.
