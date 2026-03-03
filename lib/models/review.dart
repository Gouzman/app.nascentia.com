class Review {
  final String id;
  final String authorName;
  final int rating;
  final String title;
  final String comment;
  final DateTime createdAt;
  final int helpfulCount;

  const Review({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.title,
    required this.comment,
    required this.createdAt,
    this.helpfulCount = 0,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      authorName: map['author_name'] as String,
      rating: map['rating'] as int,
      title: map['title'] as String,
      comment: map['comment'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      helpfulCount: (map['helpful_count'] as int?) ?? 0,
    );
  }
}
