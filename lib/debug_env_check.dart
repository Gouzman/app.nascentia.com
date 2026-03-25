import 'package:flutter/foundation.dart';

/// Vérifie que les variables d'environnement sont bien chargées
class DebugEnvCheck {
  static void checkEnvironmentVariables() {
    const brevoKey = String.fromEnvironment('BREVO_API_KEY', defaultValue: '');
    const brevoSender = String.fromEnvironment('BREVO_SENDER_EMAIL', defaultValue: '');
    const brevoReceiver = String.fromEnvironment('BREVO_RECEIVER_EMAIL', defaultValue: '');
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

    if (kDebugMode) {
      print('');
      print('═══════════════════════════════════════════════════════');
      print('🔍 DEBUG: Vérification des variables d\'environnement');
      print('═══════════════════════════════════════════════════════');
      print('BREVO_API_KEY: ${brevoKey.isNotEmpty ? "✅ Chargée (${brevoKey.substring(0, 20)}...)" : "❌ MANQUANTE"}');
      print('BREVO_SENDER_EMAIL: ${brevoSender.isNotEmpty ? "✅ $brevoSender" : "❌ MANQUANTE"}');
      print('BREVO_RECEIVER_EMAIL: ${brevoReceiver.isNotEmpty ? "✅ $brevoReceiver" : "❌ MANQUANTE"}');
      print('SUPABASE_URL: ${supabaseUrl.isNotEmpty ? "✅ Chargée" : "❌ MANQUANTE"}');
      print('SUPABASE_ANON_KEY: ${supabaseKey.isNotEmpty ? "✅ Chargée" : "❌ MANQUANTE"}');
      print('═══════════════════════════════════════════════════════');
      print('');
    }
  }
}
