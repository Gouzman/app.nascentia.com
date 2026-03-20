/// Configuration Supabase.
///
/// Les valeurs sont injectées au moment du build via `--dart-define` :
///   flutter build web \
///     --dart-define=SUPABASE_URL=https://xxx.supabase.co \
///     --dart-define=SUPABASE_ANON_KEY=eyJ...
///
/// Les valeurs ci-dessous sont des valeurs de développement par défaut.
/// Ne jamais committer des clés de production dans le code source.
class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ukqbpzpqlaejgddzsqml.supabase.co',
  );
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrcWJwenBxbGFlamdkZHpzcW1sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI1NDAxMTksImV4cCI6MjA4ODExNjExOX0.dFpmXbYquSk1UMPCOuBM1ZY2EPQCSj1nxSFq6il-kvY',
  );
}
