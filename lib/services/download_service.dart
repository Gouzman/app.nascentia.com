import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import '../models/review.dart';

/// Service pour gérer les téléchargements et interactions avec Supabase
/// Inclut retry logic, timeout et error handling
class DownloadService {
  static SupabaseClient get _client => Supabase.instance.client;

  // Configuration timeout et retry
  static const Duration _defaultTimeout = Duration(seconds: 10);
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(milliseconds: 500);

  /// Récupère la liste des reviews avec retry et timeout
  static Future<List<Review>> getReviews() async {
    return await _executeWithRetry<List<Review>>(
      () async {
        final response = await _client
            .from('reviews')
            .select()
            .order('created_at', ascending: false)
            .timeout(_defaultTimeout);
        return (response as List).map((e) => Review.fromMap(e)).toList();
      },
      fallback: [], // Retourne liste vide en cas d'échec
      errorMessage: 'Erreur lors de la récupération des reviews',
    );
  }

  /// Récupère le nombre de téléchargements avec retry et timeout
  static Future<int> getDownloadsCount() async {
    return await _executeWithRetry<int>(
      () async {
        final response = await _client
            .from('app_stats')
            .select('downloads_count')
            .eq('id', 1)
            .single()
            .timeout(_defaultTimeout);
        return response['downloads_count'] as int;
      },
      fallback: 0, // Retourne 0 en cas d'échec
      errorMessage: 'Erreur lors de la récupération du compteur',
    );
  }

  /// Incrémente le compteur "utile" d'une review
  static Future<void> incrementHelpful(String reviewId) async {
    try {
      await _client
          .rpc('increment_helpful', params: {'review_id': reviewId})
          .timeout(_defaultTimeout);
    } catch (e) {
      debugPrint('❌ Erreur incrementHelpful: $e');
      // Ne pas bloquer l'UI si l'incrémentation échoue
    }
  }

  /// Soumet une nouvelle review
  static Future<bool> submitReview({
    required String name,
    required int rating,
    required String title,
    required String comment,
  }) async {
    return await _executeWithRetry<bool>(
      () async {
        await _client
            .from('reviews')
            .insert({
              'author_name': name,
              'rating': rating,
              'title': title,
              'comment': comment,
            })
            .timeout(_defaultTimeout);
        return true;
      },
      fallback: false,
      errorMessage: 'Erreur lors de la soumission de la review',
    );
  }

  /// Incrémente le compteur de téléchargements
  static Future<void> trackDownload() async {
    try {
      await _client
          .rpc('increment_downloads')
          .timeout(_defaultTimeout);
      debugPrint('✅ Téléchargement comptabilisé');
    } catch (e) {
      debugPrint('⚠️ Erreur tracking download: $e');
      // Ne pas bloquer l'UI
    }
  }

  /// Exécute une opération avec retry automatique et exponential backoff
  static Future<T> _executeWithRetry<T>(
    Future<T> Function() operation, {
    required T fallback,
    required String errorMessage,
  }) async {
    int retries = 0;

    while (retries < _maxRetries) {
      try {
        return await operation();
      } catch (e) {
        retries++;
        debugPrint('⚠️ $errorMessage (tentative $retries/$_maxRetries): $e');

        if (retries >= _maxRetries) {
          debugPrint('❌ Échec définitif après $_maxRetries tentatives');
          return fallback;
        }

        // Exponential backoff: 500ms, 1000ms, 1500ms
        final delay = _retryDelay * retries;
        await Future.delayed(delay);
      }
    }

    return fallback;
  }

  /// Vérifie la connexion à Supabase
  static Future<bool> checkConnection() async {
    try {
      await _client
          .from('app_stats')
          .select('id')
          .limit(1)
          .timeout(const Duration(seconds: 5));
      return true;
    } catch (e) {
      debugPrint('❌ Pas de connexion Supabase: $e');
      return false;
    }
  }
}
