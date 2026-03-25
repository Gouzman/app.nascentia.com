# 🔄 Système de gestion du cache - NASCENTIA

## 🎯 Problème résolu

**Avant :** Les utilisateurs devaient vider leur cache ou actualiser plusieurs fois pour voir les mises à jour.

**Maintenant :** Les utilisateurs voient automatiquement la nouvelle version en **maximum 5 minutes** sans aucune action manuelle.

---

## 🚀 Comment ça fonctionne ?

### 1. **Headers HTTP optimisés** (`.htaccess`)
- HTML/JSON : **Jamais en cache** → Toujours à jour
- JS/CSS : Cache court (1h) avec revalidation
- Images : Cache long (1 semaine) car immuables
- Compression GZIP automatique

### 2. **Hash de build unique**
Chaque build génère un timestamp Unix unique :
```json
{
  "build_hash": "1774353223",
  "build_date": "2026-03-24 12:53:43"
}
```

### 3. **Détection automatique** (`version-check.js`)
- ⏱️ Vérifie toutes les 5 minutes
- 👁️ Vérifie quand l'utilisateur revient sur l'onglet
- 🔔 Affiche une belle notification
- 🔄 Auto-refresh après 30s si aucune action

---

## 📋 Utilisation

### Build de production
```powershell
.\build-prod.ps1
```

**Ce que ça fait automatiquement :**
- ✅ Build Flutter en mode release
- ✅ Génère un hash unique
- ✅ Met à jour version.json
- ✅ Copie .htaccess et version-check.js

### Déploiement sur cPanel

1. **Télécharger TOUT le contenu de `build\web\` vers `public_html`**
   ```
   ✅ .htaccess
   ✅ version.json
   ✅ version-check.js
   ✅ index.html
   ✅ Tous les autres fichiers
   ```

2. **Vérifier le déploiement**
   - Ouvrir : `https://votre-site.com/version.json`
   - Devrait afficher le nouveau `build_hash`

3. **Tester**
   - Navigation privée
   - Console (F12) devrait afficher : `✅ Version actuelle: {hash: "..."}`

---

## 🎨 Notification utilisateur

Quand une nouvelle version est détectée :

```
┌─────────────────────────────────────┐
│ 🚀 Nouvelle version disponible !   │
│                                     │
│ Une mise à jour est disponible.    │
│ Rafraîchissez la page pour         │
│ profiter des dernières              │
│ améliorations.                      │
│                                     │
│ [ Mettre à jour maintenant ]       │
│ [       Plus tard        ]         │
└─────────────────────────────────────┘
```

- Auto-refresh après **30 secondes** si aucune action
- Élégante avec votre gradient de marque

---

## ⏱️ Timeline de mise à jour

```
[00:00] Vous déployez sur cPanel
[00:01] Nouveaux fichiers en ligne
[00:05] Utilisateur A visite le site → ✅ Nouvelle version immédiate
[02:30] Utilisateur B (déjà sur le site) → 🔔 Notification
[02:31] Utilisateur B clique "Mettre à jour" → ✅ Nouvelle version
[05:00] Utilisateur C (inactif) → 🔄 Vérification auto → 🔔 Notification
```

**Résultat :** Tous les utilisateurs sur la nouvelle version en **5 minutes maximum**.

---

## 📁 Fichiers du système

| Fichier | Rôle |
|---------|------|
| `web/.htaccess` | Headers HTTP de cache |
| `web/version-check.js` | Détection de version |
| `web/index.html` | Inclut version-check.js |
| `build-prod.ps1` | Génère le hash unique |
| `build/web/version.json` | Contient hash + date |

---

## ✅ Checklist déploiement

```
☐ Lancer .\build-prod.ps1
☐ Vérifier build_hash dans build\web\version.json
☐ Télécharger TOUT build\web\ vers cPanel
☐ Vérifier .htaccess sur le serveur
☐ Tester en navigation privée
☐ Vérifier console : "Version checker initialisé"
```

---

## 🔧 Dépannage

### Les utilisateurs ne voient pas la nouvelle version

**1. Vérifier le hash de version en ligne :**
```
https://votre-site.com/version.json
```

**2. Vérifier que .htaccess existe sur le serveur**
- Activer "Afficher les fichiers cachés" dans cPanel
- Le fichier commence par un point : `.htaccess`

**3. Vérifier la console navigateur (F12) :**
```javascript
// Devrait afficher :
✅ Version actuelle: {version: "1.0.0", buildNumber: "1", hash: "1774353223"}
✅ Version checker initialisé (intervalle: 5 min)
```

---

## 📖 Documentation complète

Voir **CPANEL_DEPLOYMENT_GUIDE.md** pour :
- Guide détaillé de déploiement
- Résolution de problèmes avancés
- Configuration serveur
- Tests et monitoring

---

## 🎉 Avantages

- ✅ **Utilisateurs toujours à jour** sans action manuelle
- ✅ **Pas de cache ancien** qui traîne pendant des jours
- ✅ **Expérience professionnelle** avec notification élégante
- ✅ **SEO optimisé** avec headers appropriés
- ✅ **Performance maximale** avec compression GZIP
- ✅ **Compatible tous navigateurs** (Chrome, Firefox, Safari, Edge)

---

**🚀 Votre site est maintenant au niveau des grandes applications professionnelles !**
