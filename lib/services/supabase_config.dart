/// Configuration Supabase avec variables d'environnement
///
/// Pour utiliser en développement :
/// flutter run -d chrome --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
///
/// Pour build production :
/// flutter build web --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
class SupabaseConfig {
  // Récupération depuis --dart-define
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ukqbpzpqlaejgddzsqml.supabase.co', // Fallback pour dev uniquement
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrcWJwenBxbGFlamdkZHpzcW1sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI1NDAxMTksImV4cCI6MjA4ODExNjExOX0.dFpmXbYquSk1UMPCOuBM1ZY2EPQCSj1nxSFq6il-kvY', // Fallback pour dev uniquement
  );

  /// URL de téléchargement de l'APK Android
  ///
  /// 🏆 RECOMMANDATION: GitHub Releases (gratuit, illimité, rapide)
  ///
  /// OPTION 1 - GitHub Releases (RECOMMANDÉ):
  /// 1. Créer un repo sur https://github.com/new (ex: nascentia-app)
  /// 2. Releases → Create a new release → Tag: v1.0.0
  /// 3. Upload nascentia.apk (79 MB)
  /// 4. URL: https://github.com/username/nascentia-app/releases/download/v1.0.0/nascentia.apk
  ///
  /// OPTION 2 - Supabase Storage (⚠️ Nécessite Pro 25$/mois pour fichiers > 50MB):
  /// 1. Dashboard → Storage → New bucket "uploads" (public)
  /// 2. Upload nascentia.apk
  /// 3. URL: https://ukqbpzpqlaejgddzsqml.supabase.co/storage/v1/object/public/uploads/nascentia.apk
  ///
  /// OPTION 3 - Cloudflare R2 (10GB/mois gratuit):
  /// - Voir documentation: https://developers.cloudflare.com/r2/
  static const String apkDownloadUrl = String.fromEnvironment(
    'APK_DOWNLOAD_URL',
    // URL GitHub Releases - Hébergement gratuit et illimité
    defaultValue: 'https://github.com/Gouzman/app.nascentia.com/releases/download/app-v1.0.0/nascentia.apk',
  );

  /// Vérification que les credentials sont bien configurés
  static bool get areCredentialsConfigured {
    return url.isNotEmpty && anonKey.isNotEmpty;
  }
}

