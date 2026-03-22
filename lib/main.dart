import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'services/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Supabase
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  runApp(const NascentiaApp());
}

/// Précache les images critiques pour améliorer les performances
/// Appelé après le premier frame pour ne pas bloquer le démarrage
Future<void> precacheAppImages(BuildContext context) async {
  final imagesToPrecache = [
    // Logo principal (toujours visible)
    'lib/assets/images/logo-nascentia.png',

    // Images hero section (above the fold)
    'lib/assets/images/image_header-1.png',
    'lib/assets/images/image_header-2.png',

    // Images sections principales
    'lib/assets/images/image_section1.png',
    'lib/assets/images/image_section2.png',

    // Screenshots download page (si fréquemment visitée)
    'lib/assets/images/Download_ScrenShot-1.jpg',
    'lib/assets/images/Download_ScrenShot-2.png',
  ];

  try {
    await Future.wait(
      imagesToPrecache.map(
        (imagePath) => precacheImage(
          AssetImage(imagePath),
          context,
        ),
      ),
    );
    debugPrint('✅ Images précachées avec succès');
  } catch (e) {
    debugPrint('⚠️ Erreur lors du précache des images: $e');
  }
}
