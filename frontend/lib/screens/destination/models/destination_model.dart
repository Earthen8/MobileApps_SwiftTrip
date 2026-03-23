class DestinationModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String description;
  final double price;
  final List<String> features;
  final bool hasDiscount;
  final bool isFavorite;

  DestinationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    this.description = '',
    this.price = 0.0,
    this.features = const [],
    this.hasDiscount = false,
    this.isFavorite = false,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      hasDiscount: json['hasDiscount'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'hasDiscount': hasDiscount,
      'isFavorite': isFavorite,
    };
  }
}
