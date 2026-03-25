# Configuration Google Analytics 4

## 🎯 Objectif

Ce guide explique comment configurer Google Analytics 4 (GA4) pour le site NASCENTIA afin de suivre le trafic, les conversions et le comportement des utilisateurs.

---

## 📋 **Étapes de configuration**

### 1. Créer une propriété Google Analytics 4

1. Se connecter à [Google Analytics](https://analytics.google.com/)
2. Cliquer sur **Admin** (roue dentée en bas à gauche)
3. Dans la colonne "Compte", sélectionner votre compte ou créer un nouveau compte
4. Dans la colonne "Propriété", cliquer sur **Créer une propriété**
5. Remplir les informations :
   - **Nom de la propriété** : `NASCENTIA Web`
   - **Fuseau horaire** : `(GMT+00:00) Afrique/Abidjan` (ou votre fuseau)
   - **Devise** : `Franc CFA (XOF)` ou `Euro (EUR)`
6. Cliquer sur **Suivant**
7. Décrire l'entreprise et cliquer sur **Créer**
8. Accepter les conditions d'utilisation

### 2. Configurer le flux de données Web

1. Dans l'assistant de configuration, sélectionner **Web**
2. Remplir :
   - **URL du site Web** : `https://nascentia-tech.com`
   - **Nom du flux** : `NASCENTIA Web - Production`
3. Cocher **Mesure avancée** (recommandé) :
   - ✅ Pages vues
   - ✅ Défilements
   - ✅ Clics sortants
   - ✅ Recherche sur site
   - ✅ Engagement vidéo
   - ✅ Téléchargements de fichiers
4. Cliquer sur **Créer un flux**

### 3. Récupérer l'ID de mesure

Après création du flux, vous obtiendrez un **ID de mesure** au format :

```
G-XXXXXXXXXX
```

⚠️ **Notez cet ID** — vous en aurez besoin pour l'intégration.

---

## 🔧 **Intégration dans le site Flutter Web**

### Option 1 : gtag.js (Recommandé pour Flutter Web)

Ajouter le script Google Analytics dans `web/index.html`, juste avant la fermeture de `</head>` :

```html
<!-- Google Analytics 4 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX', {
    'cookie_flags': 'SameSite=None;Secure',
    'anonymize_ip': true  // Conformité RGPD
  });
</script>
```

**Remplacer `G-XXXXXXXXXX` par votre ID de mesure réel.**

### Option 2 : Package Flutter (Alternative)

Si vous préférez une intégration native :

```bash
flutter pub add firebase_analytics
```

Puis configurer Firebase et GA4 via Firebase Console (plus complexe).

---

## 📊 **Événements à suivre (recommandations)**

### Événements GA4 automatiques (avec mesure avancée activée)

- ✅ `page_view` — Pages visitées
- ✅ `scroll` — Défilement à 90%
- ✅ `click` — Clics sur liens sortants
- ✅ `file_download` — Téléchargements d'APK

### Événements personnalisés à ajouter (Phase 3)

Pour un suivi plus précis, créer des événements personnalisés :

```javascript
// Téléchargement APK
gtag('event', 'apk_download', {
  'event_category': 'engagement',
  'event_label': 'Android APK',
  'value': 1
});

// Soumission formulaire contact
gtag('event', 'contact_submission', {
  'event_category': 'conversion',
  'event_label': 'Contact Form',
  'value': 1
});

// Inscription newsletter
gtag('event', 'newsletter_signup', {
  'event_category': 'conversion',
  'event_label': 'Newsletter',
  'value': 1
});

// Clic bouton Télécharger (hero)
gtag('event', 'cta_click', {
  'event_category': 'engagement',
  'event_label': 'Hero Download Button',
  'value': 1
});
```

Pour les intégrer dans Flutter Web, appeler ces fonctions via `dart:js` :

```dart
import 'dart:js' as js;

void trackEvent(String eventName, Map<String, dynamic> params) {
  if (kReleaseMode) {
    js.context.callMethod('gtag', ['event', eventName, js.JsObject.jsify(params)]);
  }
}

// Exemple d'utilisation
trackEvent('apk_download', {
  'event_category': 'engagement',
  'event_label': 'Android APK',
  'value': 1,
});
```

---

## 🔒 **Conformité RGPD**

### 1. Anonymisation IP

✅ **Déjà activée** dans le script ci-dessus :

```javascript
gtag('config', 'G-XXXXXXXXXX', {
  'anonymize_ip': true
});
```

### 2. Bannière de consentement aux cookies (Obligatoire en Europe)

**⚠️ IMPORTANT** : Si vous activez Google Analytics, vous DEVEZ implémenter une bannière de consentement aux cookies conforme RGPD.

#### Options de bannière de cookies

**Option A : Service externe (simple)**
- [Axeptio](https://www.axeptio.eu/) — Service français, interface moderne
- [Cookiebot](https://www.cookiebot.com/) — Très utilisé, conforme RGPD
- [OneTrust](https://www.onetrust.com/) — Solution enterprise

**Option B : Package Flutter (dev requis)**
- `flutter_cookie_consent` — Widget personnalisable
- Implémenter manuellement avec `SharedPreferences` pour stocker le consentement

#### Exemple de bannière simple (HTML/CSS)

Ajouter dans `web/index.html` avant `</body>` :

```html
<div id="cookie-banner" style="display:none; position:fixed; bottom:0; left:0; right:0; background:#2C2C2C; color:white; padding:20px; text-align:center; z-index:9999;">
  <p>
    Nous utilisons des cookies pour analyser le trafic de notre site.
    <a href="/politique-confidentialite" style="color:#E95263;">En savoir plus</a>
  </p>
  <button onclick="acceptCookies()" style="background:#E95263; color:white; padding:10px 20px; border:none; border-radius:20px; margin-left:10px; cursor:pointer;">
    J'accepte
  </button>
  <button onclick="refuseCookies()" style="background:transparent; color:white; padding:10px 20px; border:1px solid white; border-radius:20px; margin-left:10px; cursor:pointer;">
    Refuser
  </button>
</div>

<script>
  // Vérifier le consentement
  if (!localStorage.getItem('cookieConsent')) {
    document.getElementById('cookie-banner').style.display = 'block';
  }

  function acceptCookies() {
    localStorage.setItem('cookieConsent', 'accepted');
    document.getElementById('cookie-banner').style.display = 'none';
    // Charger GA4 uniquement si accepté
    loadGA4();
  }

  function refuseCookies() {
    localStorage.setItem('cookieConsent', 'refused');
    document.getElementById('cookie-banner').style.display = 'none';
  }

  function loadGA4() {
    // Déplacer le script GA4 dans cette fonction
    var script = document.createElement('script');
    script.src = 'https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX';
    script.async = true;
    document.head.appendChild(script);

    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-XXXXXXXXXX', {
      'cookie_flags': 'SameSite=None;Secure',
      'anonymize_ip': true
    });
  }

  // Si déjà accepté, charger GA4 immédiatement
  if (localStorage.getItem('cookieConsent') === 'accepted') {
    loadGA4();
  }
</script>
```

#### Mentions obligatoires dans la Politique de confidentialité

Mettre à jour `lib/content/legal_content.dart` pour mentionner Google Analytics :

```dart
<h3>4. Cookies et technologies similaires</h3>
<p>Nous utilisons Google Analytics pour analyser l'utilisation de notre site. Google Analytics collecte des informations anonymisées sur votre navigation (pages visitées, durée, appareil utilisé).</p>
<p>Vous pouvez refuser l'utilisation de cookies via la bannière de consentement ou les paramètres de votre navigateur.</p>
<p>Pour plus d'informations sur Google Analytics : <a href="https://policies.google.com/privacy">Politique de confidentialité de Google</a>.</p>
```

---

## 📈 **Rapports utiles dans GA4**

Après déploiement, consulter ces rapports dans Google Analytics :

### Rapports en temps réel
- **Temps réel > Vue d'ensemble** : Utilisateurs actifs en ce moment

### Rapports d'acquisition
- **Acquisition > Vue d'ensemble** : Sources de trafic (direct, organique, social, référent)
- **Acquisition > Acquisition de trafic** : Performance par canal

### Rapports d'engagement
- **Engagement > Pages et écrans** : Pages les plus visitées
- **Engagement > Événements** : Événements déclenchés (téléchargements APK, formulaires)

### Rapports de conversion
- **Monétisation > Conversions** : Événements de conversion (ex: `contact_submission`)

---

## ✅ **Validation de l'installation**

### 1. Test en temps réel

1. Déployer le site avec le script GA4
2. Ouvrir Google Analytics
3. Aller dans **Temps réel > Vue d'ensemble**
4. Ouvrir votre site dans un autre onglet
5. Vérifier qu'un utilisateur actif apparaît dans GA4 (délai : ~10-30 secondes)

### 2. Extension Chrome "Google Analytics Debugger"

Installer l'extension [GA Debugger](https://chrome.google.com/webstore/detail/google-analytics-debugger/jnkmfdileelhofjcijamephohjechhna) pour voir les événements envoyés en temps réel dans la console.

### 3. Google Tag Assistant

Utiliser [Tag Assistant](https://tagassistant.google.com/) pour vérifier la configuration.

---

## 📝 **Checklist de déploiement**

Avant de déployer Google Analytics en production :

- [ ] Créer une propriété GA4 et récupérer l'ID de mesure (`G-XXXXXXXXXX`)
- [ ] Ajouter le script gtag.js dans `web/index.html`
- [ ] Activer l'anonymisation IP (`anonymize_ip: true`)
- [ ] Implémenter une bannière de consentement aux cookies (RGPD)
- [ ] Mettre à jour la Politique de confidentialité avec la mention Google Analytics
- [ ] Tester en temps réel dans GA4
- [ ] Vérifier avec GA Debugger ou Tag Assistant
- [ ] (Optionnel) Configurer des événements personnalisés pour les conversions

---

## 🔗 **Ressources utiles**

- [Documentation GA4](https://support.google.com/analytics/answer/10089681)
- [Guide RGPD Google Analytics](https://support.google.com/analytics/answer/9019185)
- [Événements recommandés GA4](https://support.google.com/analytics/answer/9267735)
- [Intégration Flutter Web](https://stackoverflow.com/questions/tagged/google-analytics+flutter-web)

---

## 📌 **Notes importantes**

- **Ne pas activer GA4 sans bannière de cookies** — Risque de non-conformité RGPD
- **Tester d'abord sur un environnement de staging** avec un flux de données séparé
- **Conserver l'ID de mesure sécurisé** — Ne pas le partager publiquement (mais pas de danger si exposé côté client)
- **Vérifier régulièrement les rapports** pour identifier les pages à optimiser

---

**Prêt pour Phase 3** 🚀

Ce document est un guide de préparation. L'implémentation réelle (ajout du script + bannière) sera réalisée en Phase 3 après validation du client.
