import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review.dart';

class DownloadService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future<List<Review>> getReviews() async {
    final response = await _client
        .from('reviews')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => Review.fromMap(e)).toList();
  }

  static Future<int> getDownloadsCount() async {
    final response = await _client
        .from('app_stats')
        .select('downloads_count')
        .eq('id', 1)
        .single();
    return response['downloads_count'] as int;
  }

  static Future<void> incrementHelpful(String reviewId) async {
    await _client.rpc('increment_helpful', params: {'review_id': reviewId});
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
