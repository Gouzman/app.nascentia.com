class SupabaseConfig {
  static const String url = 'https://ukqbpzpqlaejgddzsqml.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrcWJwenBxbGFlamdkZHpzcW1sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI1NDAxMTksImV4cCI6MjA4ODExNjExOX0.dFpmXbYquSk1UMPCOuBM1ZY2EPQCSj1nxSFq6il-kvY';

  /// URL de téléchargement de l'APK Android.
  ///
  /// L'APK doit être hébergé sur Supabase Storage (ou un CDN externe).
  /// Pour le mettre en ligne : Supabase Dashboard → Storage → uploads →
  /// charger nascentia.apk et récupérer l'URL publique ici.
  ///
  /// Exemple Supabase Storage :
  /// '$url/storage/v1/object/public/uploads/nascentia.apk'
  static const String apkDownloadUrl =
      '$url/storage/v1/object/public/uploads/nascentia.apk';
}
