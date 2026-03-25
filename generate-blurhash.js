const sharp = require('sharp');
const { encode } = require('blurhash');

/**
 * Génère un BlurHash depuis une URL d'image
 * @param {string} imageUrl - URL de l'image (HTTP ou HTTPS)
 * @param {string} imageName - Nom pour identifier l'image
 */
async function generateBlurHash(imageUrl, imageName) {
    try {
        console.log(`\n📸 Traitement: ${imageName}...`);

        // Télécharger l'image
        const response = await fetch(imageUrl);
        const arrayBuffer = await response.arrayBuffer();
        const buffer = Buffer.from(arrayBuffer);

        // Redimensionner à 32x32 pour le hash (optimisation vitesse)
        const image = sharp(buffer).resize(32, 32, { fit: 'inside' });
        const { data, info } = await image
            .ensureAlpha()
            .raw()
            .toBuffer({ resolveWithObject: true });

        // Générer le BlurHash (4x3 components = bon équilibre détail/taille)
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
    console.log('='.repeat(50));

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
        {
            url: 'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images/Download_ScrenShot-1.jpg',
            name: 'blurHashScreenshot1'
        },
    ];

    const results = [];

    for (const img of images) {
        const result = await generateBlurHash(img.url, img.name);
        if (result) results.push(result);
    }

    console.log('\n' + '='.repeat(50));
    console.log('\n📋 Code Dart à copier dans lib/config/cdn_images.dart:\n');

    results.forEach(({ name, hash }) => {
        console.log(`  static const String ${name} = '${hash}';`);
    });

    console.log('\n✅ Terminé! Copiez les lignes ci-dessus dans cdn_images.dart\n');
}

// Exécuter
generateAllHashes();
