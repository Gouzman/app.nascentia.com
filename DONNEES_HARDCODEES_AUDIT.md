# Audit des Données En Dur - NASCENTIA

## 📋 Résumé Exécutif

Ce document répertorie **toutes les données hardcodées** dans l'application NASCENTIA qui devraient être **externalisées et rendues dynamiques** pour faciliter la maintenance et permettre la gestion via un CMS ou une base de données.

---

## 🎯 Objectif

Identifier et centraliser les données suivantes pour les gérer dynamiquement :
- ✅ Textes marketing (titres, descriptions)
- ✅ Informations de contact (email, téléphone, adresse)
- ✅ Statistiques et chiffres clés
- ✅ Contenu des sections
- ✅ Liens sociaux et externes
- ✅ Configuration des services

---

## 📍 SECTION 1 : HERO SECTION
**Fichier:** `lib/sections/hero_section.dart`

### Données en dur identifiées :
```dart
// Titre principal
'Comprendre aujourd\'hui,\npréparer demain.'

// Sous-titre
'La méthode scientifique pour planifier ou déterminer le sexe de votre futur bébé.'

// Texte du bouton CTA
'Télécharger l\'application'

// Texte compteur utilisateurs
'Merci à nos +5000 utilisateurs'

// Icônes sociales et leurs liens (actuellement vides)
- Facebook
- Instagram
- WhatsApp
```

**Proposition :** Créer un modèle `HeroContent` avec ces champs.

---

## 📍 SECTION 2 : PERSONALIZED SUPPORT
**Fichier:** `lib/sections/personalized_support_section.dart`

### Données en dur :
```dart
// Badge
'🎯 EXPERTISE SCIENTIFIQUE'

// Titre
'Un accompagnement sur mesure pour chaque famille'

// Description
'NASCENTIA combine des années de recherches scientifiques avec une technologie de pointe pour vous offrir des recommandations précises et personnalisées.'

// Liste des fonctionnalités (3 items)
1. Analyse personnalisée
2. Recommandations scientifiques
3. Suivi en temps réel

// Chemin image mockup
'assets/images/phone_1.png'
```

**Proposition :** Créer `PersonalizedSupportContent` avec liste de features.

---

## 📍 SECTION 3 : FAST ORDER
**Fichier:** `lib/sections/fast_order_section.dart`

### Données en dur :
```dart
// Badge
'⚡ RAPIDITÉ'

// Titre
'Résultats instantanés, décisions éclairées'

// Description
'Plus besoin d\'attendre : obtenez vos résultats immédiatement et planifiez en toute confiance.'

// Liste des avantages (3 items)
- Accès instantané
- Interface intuitive
- Support disponible

// Images mockup
'assets/images/phone_2.png'
```

**Proposition :** Modèle `FastOrderContent`.

---

## 📍 SECTION 4 : ABOUT (À propos)
**Fichier:** `lib/sections/about_section.dart`

### Données en dur :
```dart
// Badge
'NOTRE HISTOIRE'

// Titre
'Une expertise scientifique au service des familles'

// Description longue (histoire de NASCENTIA)
'Créée en mars 2022, NASCENTIA est une start-up spécialisée dans l\'expertise scientifique...'

// Timeline (5 étapes)
[
  {
    "year": "2009",
    "event": "Début des recherches",
    "description": "Lancement du projet..."
  },
  {
    "year": "2018",
    "event": "Validation clinique",
    "description": "Premières études..."
  },
  {
    "year": "2022",
    "event": "Lancement NASCENTIA",
    "description": "Création officielle..."
  },
  {
    "year": "2024",
    "event": "Expansion internationale",
    "description": "Ouverture..."
  },
  {
    "year": "2026",
    "event": "Innovation continue",
    "description": "Nouvelles fonctionnalités..."
  }
]

// Valeurs de l'entreprise (3 cartes)
[
  {
    "icon": "🔬",
    "title": "Rigueur Scientifique",
    "description": "Basé sur 13+ ans de recherche..."
  },
  {
    "icon": "🤝",
    "title": "Éthique & Respect",
    "description": "Respect de la vie privée..."
  },
  {
    "icon": "💡",
    "title": "Innovation",
    "description": "Toujours à la pointe..."
  }
]
```

**Proposition :** Modèles `AboutContent`, `TimelineEvent`, `CompanyValue`.

---

## 📍 SECTION 5 : CREDIBILITY (Crédibilité)
**Fichier:** `lib/sections/credibility_section.dart`

### Données en dur :
```dart
// Badge
'VALIDATION SCIENTIFIQUE'

// Titre
'Un modèle mathématique testé et validé'

// Description
'Le modèle NASCENTIA est le fruit de plusieurs années de recherches...'

// Statistiques clés (3 badges)
[
  {
    "icon": Icons.analytics_outlined,
    "value": "90 %",
    "label": "Taux de\nFiabilité"
  },
  {
    "icon": Icons.science_outlined,
    "value": "+13 ans",
    "label": "Recherche &\nDéveloppement"
  },
  {
    "icon": Icons.verified_outlined,
    "value": "Validé",
    "label": "Études\nCliniques"
  }
]

// Partenaires (logos)
- 'CHU Cocody' (assets/images/chu_cocody_logo.png)
- 'Univ. Félix' (assets/images/ufhb_logo.png)
- 'Ministère Santé' (assets/images/ministere_sante_logo.png)
```

**⚠️ IMPORTANT :** Le taux de fiabilité (90%) doit être facilement modifiable.

**Proposition :** Créer `CredibilityStats` et `Partner` models.

---

## 📍 SECTION 6 : FEATURES (Fonctionnalités)
**Fichier:** `lib/sections/features_section.dart`

### Données en dur :
```dart
// Titre
'Fonctionnalités clés'

// Sous-titre
'Tout ce dont vous avez besoin pour planifier sereinement'

// Liste des features (3 cartes)
[
  {
    "index": 0,
    "title": "Détermination du sexe",
    "description": "Identifiez le sexe du bébé dès la conception avec une méthode scientifique validée.",
    "icon": Icons.baby_changing_station,
    "color": AppColors.primary
  },
  {
    "index": 1,
    "title": "Planification du sexe",
    "description": "Utilisez un calendrier intelligent pour maximiser vos chances selon vos objectifs familiaux.",
    "icon": Icons.event_available,
    "color": AppColors.purple
  },
  {
    "index": 2,
    "title": "Suivi personnalisé",
    "description": "Recevez des recommandations adaptées basées sur vos données et votre cycle.",
    "icon": Icons.insights,
    "color": AppColors.secondary
  }
]
```

**Proposition :** Modèle `Feature` avec `title`, `description`, `iconName`, `colorHex`.

---

## 📍 SECTION 7 : HOW IT WORKS (Comment ça marche)
**Fichier:** `lib/sections/how_it_works_section.dart`

### Données en dur :
```dart
// Constante globale _steps
const List<_StepData> _steps = [
  {
    "number": "1",
    "title": "Téléchargez",
    "description": "Installez NASCENTIA gratuitement sur iOS ou Android en moins de 30 secondes.",
    "icon": Icons.download_rounded,
    "color": AppColors.primary
  },
  {
    "number": "2",
    "title": "Autorisez les sources inconnues",
    "description": "Pour installer NASCENTIA sur Android en dehors du Play Store...",
    "icon": Icons.security_rounded,
    "color": AppColors.warningOrange
  },
  {
    "number": "3",
    "title": "Créez votre profil",
    "description": "Renseignez vos informations personnelles de manière sécurisée et confidentielle.",
    "icon": Icons.person_add_rounded,
    "color": AppColors.secondary
  },
  {
    "number": "4",
    "title": "Définissez votre objectif",
    "description": "Choisissez entre détermination du sexe ou planification selon votre situation.",
    "icon": Icons.flag_rounded,
    "color": AppColors.accent
  },
  {
    "number": "5",
    "title": "Accédez aux résultats",
    "description": "Recevez vos recommandations personnalisées basées sur notre algorithme validé.",
    "icon": Icons.check_circle_rounded,
    "color": AppColors.successGreen
  }
]
```

**Proposition :** Modèle `WorkflowStep` dans la DB.

---

## 📍 SECTION 8 : CALENDAR
**Fichier:** `lib/sections/calendar_section.dart`

### Données à vérifier :
- Textes de présentation du calendrier
- Liens vers les fonctionnalités

---

## 📍 SECTION 9 : PODCAST
**Fichier:** `lib/sections/podcast_section.dart`

### Données en dur :
```dart
// Titre
'Votre santé féminine, enfin à voix haute'

// Description
'Chaque épisode, des experts bienveillants vous accompagnent sur les sujets qui vous touchent vraiment — hormones, fertilité, maternité, santé mentale, nutrition. Un espace de confiance, ancré dans la science, conçu pour toutes les femmes.'

// Liste des épisodes de podcast (à définir)
```

**Proposition :** Créer modèle `PodcastEpisode` pour gérer dynamiquement les épisodes.

---

## 📍 SECTION 10 : APP SECTION (Téléchargement)
**Fichier:** `lib/sections/app_section.dart`

### Données en dur :
```dart
// Texte du bouton Android
'Télécharger Android'

// URL de téléchargement Supabase
// Géré via DownloadService et Supabase - OK ✅
```

**État :** Partiellement dynamique (URL Supabase).

---

## 📍 SECTION 11 : CONTACT
**Fichier:** `lib/sections/contact_section.dart`

### Données en dur :
```dart
// Titre
'Contactez-nous'

// Description
// Formulaire dynamique ✅
```

**État :** OK, formulaire déjà fonctionnel via Brevo.

---

## 🦶 FOOTER
**Fichier:** `lib/widgets/app_footer.dart`

### Données en dur **CRITIQUES** :
```dart
// Slogan de marque
'NASCENTIA —\nComprendre aujourd\'hui,\npréparer demain.'

// Sous-slogan
'Une approche scientifique au service des familles.'

// Contact
{
  "email": "nascentia.info@gmail.com",
  "phone": "(+225) 07 78 68 33 53",
  "address": "Cocody, Côte d\'Ivoire"
}

// Navigation links (générés dynamiquement depuis NavigationService) ✅

// Liens sociaux
{
  "facebook": null,
  "instagram": null,
  "whatsapp": "https://wa.me/2250778683353"
}

// Copyright
'© 2026 NASCENTIA-TECH. Tous droits réservés.'
```

**⚠️ IMPORTANT :** Email, téléphone, adresse doivent être configurables.

---

## 🔧 SERVICES & CONFIGURATION

### BrevoService
**Fichier:** `lib/services/brevo_service.dart`

```dart
// Emails configurables via .env ✅
BREVO_SENDER_EMAIL=nascentia.info@gmail.com
BREVO_RECEIVER_EMAIL=nascentia.info@gmail.com

// Templates d'emails (HTML en dur)
- Template contact
- Template confirmation automatique
- Template newsletter bienvenue
```

**⚠️ À EXTERNALISER :**
- Templates d'emails (Brevo Transactional Templates)
- Liste newsletter ID (actuellement hardcodé à `[2]`)

### NavigationService
**Fichier:** `lib/services/navigation_service.dart`

```dart
// Mapping des sections de navigation
static final Map<String, GlobalKey> sections = {
  'Fonctionnalités': featuresKey,
  'Comment ça marche': howItWorksKey,
  'Contact': contactKey,
};
```

**État :** Structure OK, mais les noms affichés sont en dur.

---

## 🎨 THEME & CONSTANTES

### AppColors
**Fichier:** `lib/theme/app_colors.dart`

```dart
// Couleurs de la marque (en dur - OK)
static const Color primary = Color(0xFFE95263);
static const Color secondary = Color(0xFF582674);
// etc.
```

**État :** OK pour rester en dur (identité de marque).

### AppConstants
**Fichier:** `lib/theme/app_constants.dart`

```dart
// Breakpoints
static const double breakpointMobile = 768;
static const double breakpointDesktop = 1440;

// Espacements, radius, shadows
// (OK pour rester en dur - standards UI)
```

**État :** OK pour rester en dur.

---

## 📊 MODÈLES DE DONNÉES PROPOSÉS

### 1. ContentSection (modèle générique)
```dart
class ContentSection {
  final String id;
  final String badge;
  final String title;
  final String subtitle;
  final String? description;
  final List<ContentItem>? items;
  final String? imagePath;
  final DateTime updatedAt;

  ContentSection({...});
}
```

### 2. ContactInfo
```dart
class ContactInfo {
  final String email;
  final String phone;
  final String address;
  final Map<String, String> socialLinks; // facebook, instagram, whatsapp

  ContactInfo({...});
}
```

### 3. Statistic
```dart
class Statistic {
  final String value;
  final String label;
  final String iconName;

  Statistic({...});
}
```

### 4. Feature
```dart
class Feature {
  final String title;
  final String description;
  final String iconName;
  final String colorHex;

  Feature({...});
}
```

### 5. WorkflowStep
```dart
class WorkflowStep {
  final int order;
  final String title;
  final String description;
  final String iconName;
  final String colorHex;

  WorkflowStep({...});
}
```

### 6. TimelineEvent
```dart
class TimelineEvent {
  final String year;
  final String event;
  final String description;

  TimelineEvent({...});
}
```

### 7. Partner
```dart
class Partner {
  final String name;
  final String logoPath;
  final String? url;

  Partner({...});
}
```

---

## 🗄️ STRUCTURE DE BASE DE DONNÉES SUPABASE PROPOSÉE

### Table: `site_content`
```sql
CREATE TABLE site_content (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section_key VARCHAR(50) UNIQUE NOT NULL, -- 'hero', 'about', 'features', etc.
  title TEXT,
  subtitle TEXT,
  description TEXT,
  badge TEXT,
  data JSONB, -- Données spécifiques à chaque section
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `contact_info`
```sql
CREATE TABLE contact_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  address TEXT,
  social_links JSONB, -- {"facebook": "url", "instagram": "url", ...}
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `features`
```sql
CREATE TABLE features (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  icon_name VARCHAR(100),
  color_hex VARCHAR(7),
  order_index INTEGER,
  is_active BOOLEAN DEFAULT true,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `statistics`
```sql
CREATE TABLE statistics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  key VARCHAR(50) UNIQUE NOT NULL, -- 'reliability_rate', 'years_research', etc.
  value VARCHAR(50) NOT NULL,
  label TEXT NOT NULL,
  icon_name VARCHAR(100),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `timeline_events`
```sql
CREATE TABLE timeline_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  year VARCHAR(4) NOT NULL,
  event VARCHAR(255) NOT NULL,
  description TEXT,
  order_index INTEGER,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `workflow_steps`
```sql
CREATE TABLE workflow_steps (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_index INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  icon_name VARCHAR(100),
  color_hex VARCHAR(7),
  is_active BOOLEAN DEFAULT true,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Table: `partners`
```sql
CREATE TABLE partners (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  logo_path VARCHAR(500),
  url VARCHAR(500),
  order_index INTEGER,
  is_active BOOLEAN DEFAULT true,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 📝 PRIORITÉS D'IMPLÉMENTATION

### 🔴 PRIORITÉ 1 - Critique (à faire en premier)
1. **Informations de contact** (email, téléphone, adresse, liens sociaux)
2. **Statistiques clés** (taux de fiabilité, années de recherche)
3. **Configuration Brevo** (liste newsletter ID)

### 🟠 PRIORITÉ 2 - Important
4. **Contenu Hero Section** (titre, sous-titre, CTA)
5. **Fonctionnalités principales** (3 cartes Features)
6. **Étapes "Comment ça marche"** (5 steps)

### 🟡 PRIORITÉ 3 - Améliorations
7. **Historique de l'entreprise** (timeline)
8. **Valeurs de l'entreprise** (3 cartes About)
9. **Liste des partenaires** (logos)

### 🟢 PRIORITÉ 4 - Nice to have
10. **Templates d'emails** (migration vers Brevo Templates)
11. **Contenu podcast** (si applicable)
12. **Textes de toutes les sections**

---

## 🚀 PLAN DE MIGRATION

### Phase 1 : Configuration (Semaine 1)
- [ ] Créer les tables Supabase
- [ ] Migrer les données critiques (contact, stats)
- [ ] Créer les services Flutter pour fetching

### Phase 2 : Contenu Principal (Semaine 2)
- [ ] Migrer Hero, Features, How It Works
- [ ] Créer l'interface admin simple (optionnel)
- [ ] Mettre en cache les données côté client

### Phase 3 : Contenu Secondaire (Semaine 3)
- [ ] Migrer About, Timeline, Partners
- [ ] Optimiser les performances
- [ ] Tests complets

### Phase 4 : Polish & Deploy (Semaine 4)
- [ ] Migration templates emails vers Brevo
- [ ] Documentation technique
- [ ] Déploiement production

---

## 🛠️ EXEMPLE D'IMPLÉMENTATION

### Service ContentService
```dart
class ContentService {
  static final _supabase = Supabase.instance.client;

  /// Récupère le contenu d'une section
  static Future<Map<String, dynamic>?> getSectionContent(String sectionKey) async {
    final response = await _supabase
        .from('site_content')
        .select()
        .eq('section_key', sectionKey)
        .single();

    return response;
  }

  /// Récupère les informations de contact
  static Future<ContactInfo?> getContactInfo() async {
    final response = await _supabase
        .from('contact_info')
        .select()
        .single();

    if (response != null) {
      return ContactInfo.fromJson(response);
    }
    return null;
  }

  /// Récupère toutes les fonctionnalités actives
  static Future<List<Feature>> getFeatures() async {
    final response = await _supabase
        .from('features')
        .select()
        .eq('is_active', true)
        .order('order_index');

    return response.map((json) => Feature.fromJson(json)).toList();
  }
}
```

### Utilisation dans un Widget
```dart
class FeaturesSection extends StatefulWidget {
  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  List<Feature>? _features;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  Future<void> _loadFeatures() async {
    try {
      final features = await ContentService.getFeatures();
      setState(() {
        _features = features;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Erreur chargement features: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return CircularProgressIndicator();
    if (_features == null || _features!.isEmpty) {
      return Text('Aucune fonctionnalité disponible');
    }

    // Afficher les features dynamiquement
    return Column(
      children: _features!.map((feature) =>
        FeatureCard(feature: feature)
      ).toList(),
    );
  }
}
```

---

## 📌 NOTES IMPORTANTES

### Mise en cache
- Implémenter un système de cache local (SharedPreferences ou Hive)
- Rafraîchir le cache toutes les 24h ou au lancement
- Fallback sur données locales si pas de connexion

### Sécurité
- Les Row Level Security (RLS) de Supabase doivent permettre la lecture publique
- Seuls les admins authentifiés peuvent modifier
- Aucune donnée sensible dans ces tables

### Performance
- Précharger les données au démarrage de l'app
- Utiliser FutureBuilder ou Provider pour la gestion d'état
- Compression d'images pour les logos/photos

---

## 📞 CONTACT POUR QUESTIONS

- **Email technique:** nascentia.info@gmail.com
- **WhatsApp:** +225 07 78 68 33 53

---

**Date du rapport:** Mars 2026
**Version:** 1.0
**Auteur:** Audit Technique NASCENTIA
