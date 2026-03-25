# 🖼️ Images Manquantes - À Créer Manuellement

## ⚠️ ACTION REQUISE

Les fichiers suivants sont référencés dans le code mais **n'existent pas encore**. Vous devez les créer manuellement avec un outil de design (Canva, Figma, Photoshop, etc.).

---

## 1. Images Open Graph / Twitter Cards

### 📍 Emplacement : `web/icons/`

### A. nascentia-og-image.png
- **Dimensions :** 1200 x 630 pixels (ratio 1.91:1)
- **Format :** PNG optimisé < 1 MB
- **Utilisé pour :** Partages Facebook, LinkedIn, WhatsApp
- **Contenu suggéré :**
  - Logo NASCENTIA centré
  - Slogan : "Comprendre aujourd'hui, préparer demain"
  - Screenshot de l'application (mockup phone)
  - Fond gradient (rose/violet de la marque)
  - **Exemple de disposition :**
    ```
    ┌─────────────────────────────────────┐
    │   [Logo NASCENTIA]                  │
    │                                     │
    │   Comprendre aujourd'hui,           │
    │   préparer demain                   │
    │                                     │
    │   [Phone mockup]   [Texte features] │
    │                                     │
    └─────────────────────────────────────┘
         1200 x 630 px
    ```

### B. nascentia-twitter-card.png
- **Dimensions :** 1200 x 675 pixels (ratio 16:9)
- **Format :** PNG optimisé < 1 MB
- **Utilisé pour :** Partages Twitter/X
- **Contenu suggéré :** Même design que OG mais adapté au format 16:9

### 🔧 Outils recommandés :
- **Canva** : https://www.canva.com/create/open-graph-images/ (templates gratuits OG)
- **Figma** : https://www.figma.com (design professionnel)
- **Online OG Generator** : https://www.opengraph.xyz/

### ✅ Une fois créés, placer dans :
```
web/icons/nascentia-og-image.png
web/icons/nascentia-twitter-card.png
```

### 🧪 Tester les partages :
- **Facebook Debugger** : https://developers.facebook.com/tools/debug/
- **Twitter Card Validator** : https://cards-dev.twitter.com/validator
- **LinkedIn Post Inspector** : https://www.linkedin.com/post-inspector/

---

## 2. Icons PWA (Progressive Web App)

### 📍 Emplacement : `web/icons/`

### A. Icon-192.png
- **Dimensions :** 192 x 192 pixels
- **Format :** PNG transparent
- **Usage :** Icône d'accueil écran Android
- **Contenu :** Logo NASCENTIA seul (sans texte), centré, marges 10%

### B. Icon-512.png
- **Dimensions :** 512 x 512 pixels
- **Format :** PNG transparent
- **Usage :** Icône splash screen PWA
- **Contenu :** Logo NASCENTIA seul (sans texte), centré, marges 10%

### C. Icon-apple-touch.png (optionnel mais recommandé)
- **Dimensions :** 180 x 180 pixels
- **Format :** PNG
- **Usage :** Icône d'accueil iOS Safari
- **Contenu :** Même que Icon-192 mais sans transparence (fond uni)

### 🔧 Outils pour générer automatiquement toutes les tailles :
- **PWA Asset Generator** : https://www.pwabuilder.com/imageGenerator
- **RealFaviconGenerator** : https://realfavicongenerator.net/
- **Favicon.io** : https://favicon.io/favicon-converter/ (convertir depuis logo)

### ✅ Une fois créés, placer dans :
```
web/icons/Icon-192.png
web/icons/Icon-512.png
web/icons/Icon-apple-touch.png (optionnel)
```

---

## 3. Favicon (si manquant)

### 📍 Emplacement : `web/favicon.png`

- **Dimensions :** 32 x 32 pixels OU 64 x 64 pixels
- **Format :** PNG transparent
- **Usage :** Icône onglet navigateur
- **Contenu :** Logo NASCENTIA simplifié (symbole seul)

Si déjà existant, vérifier qu'il correspond au design actuel.

---

## 📋 Checklist Complète

Une fois toutes les images créées :

- [ ] `web/icons/nascentia-og-image.png` (1200x630)
- [ ] `web/icons/nascentia-twitter-card.png` (1200x675)
- [ ] `web/icons/Icon-192.png` (192x192)
- [ ] `web/icons/Icon-512.png` (512x512)
- [ ] `web/icons/Icon-apple-touch.png` (180x180, optionnel)
- [ ] `web/favicon.png` (32x32 ou 64x64)

### Après génération :

1. **Rebuild le site :**
   ```powershell
   flutter build web
   ```

2. **Vérifier que les images sont copiées dans `build/web/icons/`**

3. **Tester le partage social :**
   - Facebook : https://developers.facebook.com/tools/debug/
   - Twitter : https://cards-dev.twitter.com/validator
   - Entrer URL : https://nascentia-tech.com/

4. **Tester PWA sur mobile Android :**
   - Ouvrir depuis Chrome mobile
   - Menu → "Ajouter à l'écran d'accueil"
   - Vérifier que l'icône s'affiche correctement

5. **Lighthouse PWA audit :**
   - Chrome DevTools → Lighthouse → PWA
   - Score devrait être > 90/100

---

## 🎨 Design Guidelines

### Palette de couleurs (à utiliser) :
- **Rose principal :** `#E95263`
- **Violet principal :** `#582674`
- **Gradient :** Rose → Violet (comme sur le site)
- **Fond :** Blanc `#FFFFFF` ou gradient subtil

### Polices (cohérence avec le site) :
- **Titres :** Inter, Poppins ou Montserrat (bold/semibold)
- **Corps :** Inter, Roboto (regular)

### Contenu des images OG/Twitter :
- **Titre :** "NASCENTIA" (logo)
- **Slogan :** "Comprendre aujourd'hui, préparer demain"
- **Call-to-action :** "Téléchargez l'application" ou "Découvrez NASCENTIA"
- **Éléments visuels :** Mockup phone avec UI de l'app

---

## 💡 Astuces Pro

### Pour créer rapidement avec Canva :

1. Créer compte gratuit sur https://www.canva.com
2. Nouveau design → Dimensions personnalisées → 1200 x 630 px
3. Utiliser template "Social Media" → "Facebook Post"
4. Importer logo NASCENTIA
5. Ajouter texte + gradient de fond
6. Télécharger en PNG

### Pour générer les icons PWA automatiquement :

1. Avoir votre logo en haute résolution (minimum 512x512, idéalement 1024x1024)
2. Aller sur https://www.pwabuilder.com/imageGenerator
3. Upload logo
4. Générer tous les formats
5. Télécharger ZIP
6. Copier dans `web/icons/`

---

## ❓ Besoin d'aide design ?

Si vous n'avez pas de designer, options :

1. **Fiverr** : Designer à partir de 5€ pour OG images
2. **99designs** : Concours design (plusieurs propositions)
3. **Claude/ChatGPT** : Demander prompt pour DALL-E/Midjourney
4. **Templates gratuits** : Canva, Figma Community (chercher "OG image template")

---

**Une fois ces images créées, votre site sera 100% conforme professionnel !** 🚀
