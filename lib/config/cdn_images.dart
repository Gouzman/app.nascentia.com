/// Configuration des URLs CDN pour les images hébergées sur Supabase Storage
///
/// Toutes les images lourdes sont servies via CDN Cloudflare avec:
/// - Compression WebP automatique
/// - Resize à la volée
/// - Cache edge mondial
class CdnImages {
  static const String _baseUrl =
      'https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/nascentia-images';

  /// Retourne une URL optimisée avec transformations
  ///
  /// [filename] - Nom du fichier sur Supabase
  /// [width] - Largeur maximale en pixels (default: 800)
  /// [quality] - Qualité JPEG/WebP 0-100 (default: 85)
  /// [format] - Format de sortie: 'webp', 'jpg', 'png' (default: 'webp')
  static String getOptimized(
    String filename, {
    int? width,
    int quality = 85,
    String format = 'webp',
  }) {
    final params = <String>[];
    if (width != null) params.add('width=$width');
    params.add('quality=$quality');
    params.add('format=$format');

    return '$_baseUrl/$filename?${params.join('&')}';
  }

  /// URL brute sans transformation
  static String getRaw(String filename) => '$_baseUrl/$filename';

  // ========== HERO SECTION ==========

  /// Image header 1 (phone mockup hero gauche)
  static String get heroHeader1 => getOptimized(
        'image_header-1.png',
        width: 600,
      );

  /// Image header 2 (phone mockup hero droite)
  static String get heroHeader2 => getOptimized(
        'image_header-2.png',
        width: 600,
      );

  // ========== SECTIONS ==========

  /// Image section 1 (Personalized Support Section) - 944 KB original
  static String get section1 => getOptimized(
        'image_section1.png',
        width: 800,
      );

  /// Image section 2 (Fast Order Section) - 2.4 MB original
  static String get section2 => getOptimized(
        'image_section2.png',
        width: 900,
      );

  // ========== DOWNLOAD PAGE SCREENSHOTS ==========

  /// Liste des screenshots pour la page download
  static List<String> get downloadScreenshots => [
        getOptimized('Download_ScrenShot-1.jpg', width: 800),
        getOptimized('Download_ScrenShot-2.png', width: 800),
        getOptimized('Download_ScrenShot-3.png', width: 800),
        getOptimized('Download_ScrenShot-4.png', width: 800),
        getOptimized('Download_ScrenShot-5.png', width: 800),
        getOptimized('Download_ScrenShot-6.png', width: 800),
      ];

  // ========== PRECACHE LIST ==========

  /// Images critiques à précacher (hero section)
  static List<String> get criticalImages => [
        heroHeader1,
        heroHeader2,
      ];

  /// Images secondaires à précacher après les critiques
  static List<String> get secondaryImages => [
        section1,
        section2,
        ...downloadScreenshots,
      ];

  // ========== BLURHASH PLACEHOLDERS ==========

  /// BlurHash pour placeholders progressifs (effet Facebook)
  /// Format: hash compact représentant l'image floue
  /// Génération: https://blurha.sh/ ou blurhash-encoder CLI

  /// BlurHash pour image_header-1.png (phone mockup rose/violet)
  static const String blurHashHeroHeader1 = 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.';

  /// BlurHash pour image_header-2.png (phone mockup rose/violet)
  static const String blurHashHeroHeader2 = 'LHF5]]Yk^6#M@-5c,1J5@[or[Q6.';

  /// BlurHash pour image_section1.png (support section)
  static const String blurHashSection1 = 'LKO2?U%2Tw=w]~RBVZRi};RPxuwH';

  /// BlurHash pour image_section2.png (fast order section)
  static const String blurHashSection2 = 'LKN]HK~qIUIU%2WBRjRj9aRjRjof';

  /// BlurHash par défaut pour screenshots download page
  static const String blurHashDownloadDefault = 'L6Pj42jE.AyE_3t7t7R**0o#DgR4';
}
