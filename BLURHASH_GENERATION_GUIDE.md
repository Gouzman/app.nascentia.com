# Guide de génération BlurHash

## 🎨 Qu'est-ce que BlurHash ?

BlurHash est un algorithme qui encode une image en une chaîne de **20-30 caractères** représentant une version floue de l'image. Cette chaîne peut être décodée instantanément en un placeholder visuel pendant le chargement de l'image réelle.

**Avantages:**
- ⚡ Chargement instantané (<50ms)
- 🎨 Placeholder coloré (pas de zone blanche/grise)
- 📦 Ultra-compact (30 caractères vs plusieurs KB)
- 🚀 Effet "Facebook/Instagram-style"

---

## 🔧 Méthode 1: En ligne (Rapide)

### Site web: https://blurha.sh/

1. **Uploader votre image** depuis Supabase:
   - image_header-1.png
   - image_header-2.png
   - image_section1.png
   - image_section2.png

2. **Ajuster les paramètres**:
   - Components X: **4** (pour images larges)
   - Components Y: **3** (pour images hautes)
   - ✅ Plus les valeurs sont élevées, plus le hash est précis (mais plus long)

3. **Copier le hash** généré (ex: `LGF5]+Yk^6#M@-5c,1J5@[or[Q6.`)

4. **Remplacer dans le code**:
   ```dart
   // lib/config/cdn_images.dart
   static const String blurHashHeroHeader1 = 'VOTRE_NOUVEAU_HASH';
   ```

---

## 🔧 Méthode 2: Script automatique (Recommandé)

### Installation Node.js + Blurhash CLI

```bash
# Installer Node.js si nécessaire
# https://nodejs.org/

# Créer dossier temporaire
mkdir blurhash-generator
cd blurhash-generator

# Installer package
npm install blurhash sharp

# Créer script
```

### Script: `generate-blurhash.js`

```javascript
const sharp = require('sharp');
const { encode } = require('blurhash');
const fs = require('fs');
const path = require('path');

/**
 * Génère un BlurHash depuis une URL d'image
 * @param {string} imageUrl - URL de l'image (HTTP ou file://)
 * @param {string} imageName - Nom pour identifier l'image
 */
async function generateBlurHash(imageUrl, imageName) {
  try {
    console.log(`\n📸 Traitement: ${imageName}...`);

    // Télécharger ou lire l'image
    const response = await fetch(imageUrl);
    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // Redimensionner à 32x32 pour le hash (rapide)
    const image = sharp(buffer).resize(32, 32, { fit: 'inside' });
    const { data, info } = await image
      .ensureAlpha()
      .raw()
      .toBuffer({ resolveWithObject: true });

    // Générer le BlurHash (4x3 components = bon équilibre)
    const blurHash = encode(
      new Uint8ClampedArray(data),
      info.width,
      info.height,
      4, // componentsX
      3  // componentsY
    );

    console.log(`✅ ${imageName}:`);
    console.log(`   ${blurHash}`);

    return { name: imageName, hash: blurHash };
  } catch (error) {
    console.error(`❌ Erreur pour ${imageName}:`, error.message);
    return null;
  }
}

/**
 * Génère tous les BlurHash pour les images NASCENTIA
 */
async function generateAllHashes() {
  console.log('🎨 Génération des BlurHash pour NASCENTIA\n');
  console.log('=' .repeat(50));

  const images = [
    {
      url: 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_header-1.png',
      name: 'blurHashHeroHeader1'
    },
    {
      url: 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_header-2.png',
      name: 'blurHashHeroHeader2'
    },
    {
      url: 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_section1.png',
      name: 'blurHashSection1'
    },
    {
      url: 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_section2.png',
      name: 'blurHashSection2'
    },
  ];

  const results = [];

  for (const img of images) {
    const result = await generateBlurHash(img.url, img.name);
    if (result) results.push(result);
  }

  console.log('\n' + '='.repeat(50));
  console.log('\n📋 Code Dart à copier dans cdn_images.dart:\n');

  results.forEach(({ name, hash }) => {
    console.log(`  static const String ${name} = '${hash}';`);
  });

  console.log('\n✅ Terminé!\n');
}

// Exécuter
generateAllHashes();
```

### Utilisation:

```bash
# Lancer le script
node generate-blurhash.js

# Résultat:
# 📸 Traitement: blurHashHeroHeader1...
# ✅ blurHashHeroHeader1:
#    LGF5]+Yk^6#M@-5c,1J5@[or[Q6.
#
# ... (autres images)
#
# 📋 Code Dart à copier dans cdn_images.dart:
#   static const String blurHashHeroHeader1 = 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.';
#   static const String blurHashHeroHeader2 = 'LHF5]]Yk^6#M@-5c,1J5@[or[Q6.';
#   ...
```

---

## 🔧 Méthode 3: Python (Alternative)

### Installation

```bash
pip install blurhash pillow requests
```

### Script: `generate_blurhash.py`

```python
#!/usr/bin/env python3
import blurhash
from PIL import Image
import requests
from io import BytesIO

def generate_blurhash_from_url(url, name):
    """Génère un BlurHash depuis une URL"""
    print(f"\n📸 Traitement: {name}...")

    try:
        # Télécharger l'image
        response = requests.get(url)
        img = Image.open(BytesIO(response.content))

        # Redimensionner à 32x32 pour rapidité
        img = img.resize((32, 32), Image.Resampling.LANCZOS)

        # Convertir en RGB si nécessaire
        if img.mode != 'RGB':
            img = img.convert('RGB')

        # Générer le BlurHash
        hash_value = blurhash.encode(img, x_components=4, y_components=3)

        print(f"✅ {name}:")
        print(f"   {hash_value}")

        return name, hash_value
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return name, None

def main():
    print("🎨 Génération des BlurHash pour NASCENTIA\n")
    print("=" * 50)

    images = [
        {
            'url': 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_header-1.png',
            'name': 'blurHashHeroHeader1'
        },
        {
            'url': 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_header-2.png',
            'name': 'blurHashHeroHeader2'
        },
        {
            'url': 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_section1.png',
            'name': 'blurHashSection1'
        },
        {
            'url': 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/image_section2.png',
            'name': 'blurHashSection2'
        },
    ]

    results = []
    for img in images:
        name, hash_value = generate_blurhash_from_url(img['url'], img['name'])
        if hash_value:
            results.append((name, hash_value))

    print("\n" + "=" * 50)
    print("\n📋 Code Dart à copier dans cdn_images.dart:\n")

    for name, hash_value in results:
        print(f"  static const String {name} = '{hash_value}';")

    print("\n✅ Terminé!\n")

if __name__ == '__main__':
    main()
```

### Utilisation:

```bash
python generate_blurhash.py
```

---

## 📊 Comparaison des méthodes

| Méthode | Vitesse | Automatisation | Précision | Prérequis |
|---------|---------|----------------|-----------|-----------|
| **En ligne (blurha.sh)** | ⭐⭐ 5 min | ❌ Manuel | ⭐⭐⭐ Excellente | Navigateur |
| **Node.js script** | ⭐⭐⭐ 30 sec | ✅ Automatique | ⭐⭐⭐ Excellente | Node.js, npm |
| **Python script** | ⭐⭐⭐ 30 sec | ✅ Automatique | ⭐⭐⭐ Excellente | Python 3, pip |

---

## 🎯 Résultat attendu

### Avant (sans BlurHash):
```
[Zone blanche/grise] → [Image apparaît brusquement]
```

### Après (avec BlurHash):
```
[Placeholder coloré flou] → [Image fade-in smooth]
```

### Temporisation:
1. **0-50ms**: BlurHash décodé et affiché (instantané)
2. **50-500ms**: Image réelle téléchargée depuis CDN
3. **500ms**: Transition fade-in douce

---

## 🔄 Mise à jour dans le code

Après génération, remplacer dans `lib/config/cdn_images.dart`:

```dart
// AVANT (hash génériques)
static const String blurHashHeroHeader1 = 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.';

// APRÈS (hash réels générés depuis vos vraies images)
static const String blurHashHeroHeader1 = 'VOTRE_NOUVEAU_HASH_REEL';
```

Puis rebuild:

```bash
flutter clean
flutter pub get
.\build-prod.ps1
```

---

## ℹ️ Notes techniques

### Composants X/Y
- **4x3**: Bon équilibre (recommandé)
- **6x4**: Plus de détails dans le flou
- **3x2**: Hash plus court, mais moins précis

### Taille du hash
```
Components  → Hash length
3x2         → ~20 caractères
4x3         → ~27 caractères (défaut)
6x4         → ~36 caractères
```

### Performance
- Génération: ~100-300ms par image
- Décodage (runtime): <10ms
- Stockage: ~30 bytes vs plusieurs KB d'image

---

## ✅ Checklist

- [ ] Choisir une méthode (en ligne, Node.js ou Python)
- [ ] Générer les BlurHash pour les 4 images principales
- [ ] Copier les hash dans `lib/config/cdn_images.dart`
- [ ] Tester dans le navigateur (throttle "Slow 3G")
- [ ] Vérifier le placeholder flou s'affiche avant l'image
- [ ] Valider la transition smooth entre placeholder et image

Voulez-vous que je crée un des scripts automatiques maintenant ?
