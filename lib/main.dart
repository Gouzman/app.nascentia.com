import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'config/cdn_images.dart';
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
  // Images critiques (hero section) - chargées en priorité depuis CDN
  final criticalImages = [
    'lib/assets/images/logo-nascentia.png',
    ...CdnImages.criticalImages,
  ];

  // Images secondaires (below the fold) - chargées après depuis CDN
  final secondaryImages = CdnImages.secondaryImages;

  try {
    // 1. Charger les images critiques en priorité (en parallèle)
    await Future.wait(
      criticalImages.map(
        (imagePath) => imagePath.startsWith('http')
            ? precacheImage(NetworkImage(imagePath), context)
            : precacheImage(AssetImage(imagePath), context),
      ),
    );
    debugPrint('✅ Images critiques précachées');

    // 2. Charger les images secondaires par lots de 2 pour éviter surcharge mémoire
    for (var i = 0; i < secondaryImages.length; i += 2) {
      final batch = secondaryImages.skip(i).take(2);
      await Future.wait(
        batch.map((path) => path.startsWith('http')
            ? precacheImage(NetworkImage(path), context)
            : precacheImage(AssetImage(path), context)),
      );
    }
    debugPrint('✅ Toutes les images précachées avec succès');
  } catch (e) {
    debugPrint('⚠️ Erreur lors du précache des images: $e');
  }
}
