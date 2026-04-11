class ReviewModel {
  final int id;
  final String username;
  final int rating;
  final String? feeling;
  final String? thoughts;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.username,
    required this.rating,
    this.feeling,
    this.thoughts,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      feeling: json['feeling'] as String?,
      thoughts: json['thoughts'] as String?,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
