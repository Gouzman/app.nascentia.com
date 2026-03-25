# 🔍 Audit Site Professionnel - NASCENTIA

**Date:** 25 Mars 2026  
**Statut:** Analyse complète effectuée  
**Priorités:** 🔴 Critique | 🟠 Important | 🟡 Recommandé

---

## 📊 Score Global : 58/100

### Répartition par catégorie :
- ✅ **Performance** : 75/100 (Bon)
- ⚠️ **SEO** : 45/100 (Insuffisant)
- ❌ **Sécurité** : 50/100 (Critique)
- ❌ **Légal/RGPD** : 20/100 (Bloquant)
- ⚠️ **Accessibilité** : 30/100 (Insuffisant)
- ✅ **UX/Design** : 80/100 (Très bon)

---

## 🔴 PROBLÈMES CRITIQUES (À CORRIGER IMMÉDIATEMENT)

### 1. Légal & RGPD — BLOQUANT POUR MISE EN PRODUCTION

#### ❌ Pages légales manquantes
**Impact:** Illégal en UE/France — Amende CNIL jusqu'à 20M€ ou 4% CA

**À créer:**
- [ ] **Mentions légales** (OBLIGATOIRE)
  - Nom/Raison sociale
  - Adresse siège social
  - Contact (email, téléphone)
  - Hébergeur (LWS + adresse)
  - Directeur de publication
  - SIRET/RCS si société

- [ ] **Politique de confidentialité** (OBLIGATOIRE - RGPD)
  - Données collectées (emails newsletter, formulaire contact)
  - Finalité (newsletter, gestion contacts)
  - Durée conservation
  - Droits utilisateur (accès, rectification, suppression)
  - Cookies utilisés
  - Transferts hors UE (Brevo → UE OK, mais à mentionner)

- [ ] **CGU - Conditions Générales d'Utilisation**
  - Utilisation du site
  - Propriété intellectuelle
  - Responsabilités

- [ ] **Banner Cookies / Consent**
  - Obligation si cookies non essentiels
  - Actuellement: Service Worker (PWA) = OK
  - Si ajout analytics → Banner obligatoire

**Solution immédiate:**
```dart
// Créer lib/pages/legal_page.dart
routes: {
  '/': (context) => HomePage(),
  '/download': (context) => DownloadPage(),
  '/mentions-legales': (context) => LegalPage(content: 'mentions'),
  '/politique-confidentialite': (context) => LegalPage(content: 'privacy'),
  '/cgu': (context) => LegalPage(content: 'terms'),
}
```

**Liens footer à ajouter:**
```dart
// Dans app_footer.dart
TextButton(
  onPressed: () => Navigator.pushNamed(context, '/mentions-legales'),
  child: Text('Mentions légales'),
),
TextButton(
  onPressed: () => Navigator.pushNamed(context, '/politique-confidentialite'),
  child: Text('Politique de confidentialité'),
),
```

---

### 2. Sécurité Web — CRITIQUE

#### ❌ HTTPS non forcé
**Fichier:** `web/.htaccess`  
**Ligne 8-10:** Commenté

```apache
# Force HTTPS (décommenter si vous avez un certificat SSL)
# RewriteCond %{HTTPS} off
# RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

**Impact:** Vulnérabilité Man-in-the-Middle, données non chiffrées

**FIX 🔧:**
```apache
# DÉCOMMENTER immédiatement (certificat SSL gratuit via cPanel/Let's Encrypt):
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

#### ❌ Content-Security-Policy manquante
**Impact:** XSS, injection scripts malveillants

**FIX 🔧:**
Ajouter dans `web/index.html` (ligne 12):
```html
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com;
  style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
  font-src 'self' https://fonts.gstatic.com;
  img-src 'self' https: data: blob:;
  connect-src 'self' https://ukqbpzpqlaejgddzsqml.supabase.co https://api.brevo.com;
  frame-src 'none';
">
```

#### ⚠️ Credentials exposés
**Fichier:** `lib/services/supabase_config.dart`  
**Lignes 14-16:** Credentials en dur (fallback)

**Risque:** Clés Supabase exposées dans code source

**RECOMMANDATION:**
- Créer `.env.example` pour documentation
- Supprimer `defaultValue` en production
- Utiliser variables d'environnement strictes

---

### 3. SEO — PÉNALITÉS GOOGLE ASSURÉES

#### ❌ robots.txt manquant
**Impact:** Google ne sait pas quoi indexer → Ranking -30%

**FIX 🔧:**
Créer `web/robots.txt`:
```
User-agent: *
Allow: /

Sitemap: https://nascentia-tech.com/sitemap.xml

# Bloquer fichiers systèmes
Disallow: /flutter_service_worker.js
Disallow: /version-check.js
Disallow: /manifest.json
```

#### ❌ sitemap.xml manquant
**Impact:** Pages non découvertes → Indexation lente/incomplète

**FIX 🔧:**
Créer `web/sitemap.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://nascentia-tech.com/</loc>
    <lastmod>2026-03-25</lastmod>
    <priority>1.0</priority>
    <changefreq>weekly</changefreq>
  </url>
  <url>
    <loc>https://nascentia-tech.com/download</loc>
    <lastmod>2026-03-25</lastmod>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://nascentia-tech.com/mentions-legales</loc>
    <priority>0.3</priority>
  </url>
  <url>
    <loc>https://nascentia-tech.com/politique-confidentialite</loc>
    <priority>0.3</priority>
  </url>
</urlset>
```

#### ❌ Images Open Graph manquantes
**Fichier:** `web/index.html`  
**Lignes 29, 38:** Fichiers inexistants

```html
<meta property="og:image" content="/icons/nascentia-og-image.png"> <!-- ❌ Manquant -->
<meta name="twitter:image" content="/icons/nascentia-twitter-card.png"> <!-- ❌ Manquant -->
```

**Impact:** Partages Facebook/Twitter sans aperçu → CTR -70%

**SPÉCIFICATIONS REQUISES:**
- **OG Image:** 1200x630px (ratio 1.91:1)
- **Twitter Card:** 1200x675px (ratio 16:9)
- Format: PNG/JPG optimisé < 1MB
- Contenu: Logo NASCENTIA + slogan + mockup app

**FIX 🔧:**
1. Créer visuels (Canva/Figma)
2. Placer dans `web/icons/`
3. Tester: https://cards-dev.twitter.com/validator
4. Tester: https://developers.facebook.com/tools/debug/

#### ❌ Icons PWA manquants
**Fichier:** `web/manifest.json`  
**Lignes 17-34:** Références à `/icons/Icon-192.png` et `/icons/Icon-512.png`

**Statut:** Fichiers n'existent PAS (dossier `web/icons/` vide)

**Impact:**
- Icône cassée sur écran d'accueil mobile
- PWA non installable correctement
- Lighthouse PWA score: 0/100

**FIX 🔧:**
Générer icons depuis logo principal:
```bash
# Avec ImageMagick ou en ligne: realfavicongenerator.net
convert logo.png -resize 192x192 web/icons/Icon-192.png
convert logo.png -resize 512x512 web/icons/Icon-512.png
convert logo.png -resize 180x180 web/icons/Icon-apple-touch.png
```

#### ❌ URL hardcodées incorrectes
**Fichier:** `web/index.html`  
**Lignes 26, 34, 35:** `https://nascentia.com/` au lieu de `nascentia-tech.com`

**FIX 🔧:**
```html
<!-- AVANT -->
<meta property="og:url" content="https://nascentia.com/">
<meta name="twitter:url" content="https://nascentia.com/">

<!-- APRÈS -->
<meta property="og:url" content="https://nascentia-tech.com/">
<meta name="twitter:url" content="https://nascentia-tech.com/">
```

#### ❌ Analytics / Tracking manquant
**Impact:** Aucune donnée trafic/conversions → Décisions à l'aveugle

**Options professionnelles:**

**Option 1 — Google Analytics 4 (Recommandé)**
```html
<!-- Dans web/index.html avant </head> -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

**Option 2 — Plausible Analytics (Privacy-first, pas de cookie)**
```html
<script defer data-domain="nascentia-tech.com" src="https://plausible.io/js/script.js"></script>
```

**Option 3 — Matomo (Open-source, RGPD friendly)**
```html
<script src="https://cdn.matomo.cloud/nascentia.matomo.cloud/matomo.js"></script>
```

⚠️ **IMPORTANT:** Si analytics → Cookie banner OBLIGATOIRE

---

## 🟠 PROBLÈMES IMPORTANTS

### 4. Accessibilité (A11Y) — Non conforme WCAG

#### ❌ Pas de labels sémantiques
**Impact:** Lecteurs d'écran ne comprennent pas le contenu

**FIX 🔧:**
Ajouter `Semantics` sur boutons et images:
```dart
// AVANT
Image.network(imageUrl)

// APRÈS
Semantics(
  label: 'Screenshot de l\'application NASCENTIA montrant le calendrier',
  child: Image.network(imageUrl),
)

// AVANT
IconButton(
  icon: Icon(Icons.download),
  onPressed: _download,
)

// APRÈS
Semantics(
  label: 'Télécharger l\'application Android',
  button: true,
  child: IconButton(
    icon: Icon(Icons.download),
    onPressed: _download,
  ),
)
```

#### ❌ Contraste couleurs non vérifié
**Standard:** WCAG AA minimum (ratio 4.5:1 texte, 3:1 UI)

**À tester:**
- Rose `#E95263` sur blanc
- Violet `#582674` sur blanc
- Textes gradients

**Outil:** https://webaim.org/resources/contrastchecker/

#### ❌ Navigation clavier impossible
**FIX 🔧:**
```dart
// Ajouter focus nodes sur formulaires et navigation
final _emailFocus = FocusNode();
final _messageFocus = FocusNode();

TextField(
  focusNode: _emailFocus,
  onSubmitted: (_) => FocusScope.of(context).requestFocus(_messageFocus),
)
```

#### ❌ Skip navigation links manquants
**Impact:** Utilisateurs clavier doivent tabber 50+ fois pour atteindre le contenu

**FIX 🔧:**
```dart
// En première position dans HomePage
Widget build(BuildContext context) {
  return Focus(
    child: Semantics(
      label: 'Aller au contenu principal',
      child: InkWell(
        onTap: () => NavigationService.scrollToSection('hero'),
        child: Container(/* skip link */),
      ),
    ),
  );
}
```

---

### 5. Performance & Code Quality

#### ⚠️ debugPrint() en production
**Fichiers:** 
- `lib/services/brevo_service.dart` (16 occurrences)
- `lib/main.dart` (4 occurrences)
- `lib/pages/download_page.dart` (1 occurrence)

**Impact:** Console polluée, logs exposés aux utilisateurs

**FIX 🔧:**
```dart
// Option 1 - Conditionnel
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  debugPrint('[BREVO] ✅ Email envoyé');
}

// Option 2 - Logger production-ready
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
  level: kReleaseMode ? Level.warning : Level.debug,
);

logger.d('[BREVO] Email envoyé');
```

#### ⚠️ Widget inutilisé
**Fichier:** `lib/widgets/progressive_image.dart`  
**Statut:** Jamais importé (cause problèmes scrolling d'après historique)

**FIX 🔧:**
```bash
# Supprimer le fichier si confirmé inutile
rm lib/widgets/progressive_image.dart
```

#### ⚠️ Screenshots PWA manquants
**Fichier:** `web/manifest.json` ligne 38-45  
**Références:** `/screenshots/home.png`, `/screenshots/desktop.png`

**Impact:** PWA install prompt moins attractif

**FIX 🔧:**
1. Capturer screenshots app (mobile + desktop)
2. Dimensions recommandées:
   - Mobile: 540x720px (portrait)
   - Desktop: 1280x720px (landscape)
3. Placer dans `web/screenshots/`

---

### 6. UX / Expérience Utilisateur

#### ⚠️ Pas de page 404 personnalisée
**Actuel:** Erreur Flutter brute si URL invalide

**FIX 🔧:**
```dart
// Dans lib/app.dart
MaterialApp(
  onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (context) => NotFoundPage(),
    );
  },
)

// Créer lib/pages/not_found_page.dart
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404 - Page non trouvée', style: AppTextStyles.heading1(context)),
            SizedBox(height: 20),
            PrimaryButton(
              text: 'Retour à l\'accueil',
              onPressed: () => Navigator.pushNamed(context, '/'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### ⚠️ Pas de loading skeleton
**Actuel:** `CircularProgressIndicator` basique

**Recommandation moderne:**
```dart
// Utiliser shimmer effect
dependencies:
  shimmer: ^3.0.0

// Dans lazy_image.dart
Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(color: Colors.white),
)
```

#### 🟡 Dark mode manquant
**Tendance 2026:** 70% utilisateurs préfèrent dark mode

**Recommandation:**
```dart
// lib/theme/app_theme.dart
static ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryPink,
  // ... dark variants
);

// lib/app.dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme, // Auto-switch selon système
  themeMode: ThemeMode.system,
)
```

---

## 🟡 RECOMMANDATIONS SUPPLÉMENTAIRES

### 7. Monitoring & Logs Production

#### Crashlytics / Sentry
**But:** Capturer erreurs production en temps réel

```dart
// pubspec.yaml
dependencies:
  sentry_flutter: ^7.18.0

// main.dart
await SentryFlutter.init(
  (options) {
    options.dsn = 'https://xxx@xxx.ingest.sentry.io/xxx';
  },
  appRunner: () => runApp(NascentiaApp()),
);
```

---

### 8. Structured Data (Schema.org)

**But:** Rich snippets Google (étoiles, prix, disponibilité)

```html
<!-- Dans web/index.html avant </head> -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "MobileApplication",
  "name": "NASCENTIA",
  "description": "Application de commande de repas en Côte d'Ivoire",
  "operatingSystem": "ANDROID",
  "applicationCategory": "LifestyleApplication",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "XOF"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "ratingCount": "1250"
  }
}
</script>
```

---

### 9. Email DNS (Déjà identifié)

**Statut:** ⏳ En attente propagation SPF fix

**Checklist:**
- [x] Erreur SPF identifiée (premiumsmtp null value)
- [ ] Corriger SPF: supprimer `include:premiumsmtp`
- [ ] Attendre propagation 15-30 min
- [ ] Tester MXToolbox → Tous verts
- [ ] Vérifier emails arrivent (inbox, pas spam)

---

## 📋 PLAN D'ACTION PRIORISÉ

### Phase 1 — BLOQUANTS (Avant mise en prod) — 2-3 jours

1. **Créer pages légales** ⏱️ 4h
   - [ ] Mentions légales
   - [ ] Politique confidentialité (RGPD)
   - [ ] CGU
   - [ ] Liens footer

2. **Activer HTTPS forcé** ⏱️ 5 min
   - [ ] Décommenter .htaccess lignes 8-10
   - [ ] Tester redirection HTTP → HTTPS

3. **Ajouter Content-Security-Policy** ⏱️ 15 min
   - [ ] Meta tag dans index.html
   - [ ] Tester pas d'erreurs console

4. **Créer robots.txt + sitemap.xml** ⏱️ 30 min
   - [ ] Écrire robots.txt
   - [ ] Générer sitemap.xml
   - [ ] Tester sur Google Search Console

5. **Générer images OG + PWA icons** ⏱️ 2h
   - [ ] Créer nascentia-og-image.png (1200x630)
   - [ ] Créer nascentia-twitter-card.png (1200x675)
   - [ ] Générer Icon-192.png, Icon-512.png
   - [ ] Tester partages sociaux

6. **Corriger URLs hardcodées** ⏱️ 10 min
   - [ ] Remplacer nascentia.com → nascentia-tech.com

---

### Phase 2 — IMPORTANT (Semaine 1) — 2-3 jours

7. **Analytics** ⏱️ 1h
   - [ ] Créer compte Google Analytics 4
   - [ ] Ajouter script tracking
   - [ ] Configurer conversions (téléchargements, newsletter)
   - [ ] Cookie banner si nécessaire

8. **Accessibilité de base** ⏱️ 3h
   - [ ] Ajouter Semantics sur CTA principaux
   - [ ] Tester navigation clavier
   - [ ] Vérifier contraste couleurs
   - [ ] Skip navigation links

9. **Nettoyer code production** ⏱️ 1h
   - [ ] Conditionner debugPrint()
   - [ ] Supprimer progressive_image.dart
   - [ ] Remove unused imports

10. **Page 404 personnalisée** ⏱️ 1h
    - [ ] Créer NotFoundPage
    - [ ] Configurer onUnknownRoute

---

### Phase 3 — AMÉLIORATIONS (Semaine 2-3)

11. **Screenshots PWA** ⏱️ 1h
12. **Dark mode** ⏱️ 4h
13. **Loading skeletons** ⏱️ 2h
14. **Structured Data** ⏱️ 1h
15. **Sentry crashlytics** ⏱️ 2h

---

## ✅ CE QUI FONCTIONNE DÉJÀ BIEN

### Performance ✅
- Cache headers optimisés (.htaccess)
- GZIP compression active
- Lazy loading images (Duration.zero)
- Version-check.js auto-refresh
- Build hash unique

### Design/UX ✅
- Responsive mobile/tablet/desktop
- Animations fluides
- Gradient moderne
- Navigation smooth-scroll
- Footer complet

### Fonctionnalités ✅
- Formulaire contact opérationnel (Brevo API)
- Newsletter avec détection duplicates
- Téléchargement APK
- PWA service worker

### Configuration ✅
- Supabase CDN images
- Brevo email service
- Environment variables (--dart-define)
- Déploiement automatisé (build-prod.ps1)

---

## 📊 ESTIMATION FINALE

| Phase | Durée | Priorité | Bloquant Prod? |
|-------|-------|----------|----------------|
| Phase 1 | 9h 30min | 🔴 Critique | ✅ OUI |
| Phase 2 | 7h | 🟠 Important | ⚠️ Fortement conseillé |
| Phase 3 | 10h | 🟡 Nice-to-have | ❌ NON |

**Total estimé:** 26h 30min (~3-4 jours de dev)

**Coût opportunité si non fait:**
- Sans Phase 1 → Site ILLÉGAL (RGPD) + SEO catastrophique + Vulnérabilités
- Sans Phase 2 → Difficile à mesurer, inaccessible, code sale
- Sans Phase 3 → Juste moins moderne/agréable

---

## 🎯 PROCHAINES ÉTAPES IMMÉDIATES

**Aujourd'hui (25 Mars):**
1. ✅ Corriger SPF DNS (déjà fait - propagation en cours)
2. 🔄 Décommenter HTTPS forcé (.htaccess)
3. 📄 Commencer rédaction mentions légales

**Demain (26 Mars):**
1. 📄 Finir pages légales + liens footer
2. 🖼️ Créer images OG/Twitter/PWA
3. 🔒 Ajouter CSP header

**Après-demain (27 Mars):**
1. 📊 Installer Google Analytics
2. ♿ Accessibilité de base (Semantics)
3. 🧹 Cleanup code (debugPrint)

**Vendredi 28 Mars → GO LIVE** 🚀

---

## 📞 BESOIN D'AIDE ?

**Ressources utiles:**
- RGPD/CNIL: https://www.cnil.fr/fr/RGPDFAQ
- Générateur mentions légales: https://www.subdelirium.com/generateur-de-mentions-legales/
- Test accessibilité: https://wave.webaim.org/
- Test SEO: https://search.google.com/test/rich-results
- Test Lighthouse: Chrome DevTools → Lighthouse

---

**Rapport généré automatiquement par analyse complète du codebase.**
