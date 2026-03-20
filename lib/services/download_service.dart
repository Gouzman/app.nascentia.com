import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review.dart';

class DownloadService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future<List<Review>> getReviews() async {
    try {
      final response = await _client
          .from('reviews')
          .select()
          .order('created_at', ascending: false);
      return (response as List).map((e) => Review.fromMap(e)).toList();
    } catch (e) {
      debugPrint('DownloadService.getReviews erreur: $e');
      return [];
    }
  }

  static Future<int> getDownloadsCount() async {
    try {
      final response = await _client
          .from('app_stats')
          .select('downloads_count')
          .eq('id', 1)
          .single();
      return response['downloads_count'] as int;
    } catch (e) {
      debugPrint('DownloadService.getDownloadsCount erreur: $e');
      return 0;
    }
  }

  static Future<void> incrementHelpful(String reviewId) async {
    try {
      await _client.rpc('increment_helpful', params: {'review_id': reviewId});
    } catch (e) {
      debugPrint('DownloadService.incrementHelpful erreur: $e');
    }
  }

  static Future<void> submitReview({
    required String name,
    required int rating,
    required String title,
    required String comment,
  }) async {
    await _client.from('reviews').insert({
      'author_name': name,
      'rating': rating,
      'title': title,
      'comment': comment,
    });
  }
}
