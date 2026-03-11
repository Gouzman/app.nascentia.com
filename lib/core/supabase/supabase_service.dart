import 'package:supabase_flutter/supabase_flutter.dart';

/// Service centralisé pour accéder à Supabase
class SupabaseService {

  /// Client Supabase unique pour toute l'application
  static SupabaseClient get client => Supabase.instance.client;

}
