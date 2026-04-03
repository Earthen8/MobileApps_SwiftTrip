import 'package:flutter/foundation.dart';

class DestinationModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String location;
  final double rating;
  final double originalPrice;
  final int discountPercentage;
  final double price;
  final String description;
  final List<String> features;
  final String sectionTag;
  final ValueNotifier<bool> isFavoriteNotifier;

  DestinationModel({
    required this.id,
    required this.name,
    this.category = '',
    required this.imageUrl,
    this.location = '',
    required this.rating,
    this.originalPrice = 0.0,
    this.discountPercentage = 0,
    this.price = 0.0,
    this.description = '',
    this.features = const [],
    this.sectionTag = '',
    bool isFavorite = false,
  }) : isFavoriteNotifier = ValueNotifier<bool>(isFavorite);

  bool get isFavorite => isFavoriteNotifier.value;
  set isFavorite(bool value) => isFavoriteNotifier.value = value;

  bool get hasDiscount => discountPercentage > 0;

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id']?.toString() ?? '',
      name: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      location: json['location'] as String? ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
      originalPrice:
          double.tryParse(json['original_price']?.toString() ?? '0.0') ?? 0.0,
      discountPercentage: json['discount_percentage'] as int? ?? 0,
      price: double.tryParse(json['final_price']?.toString() ?? '0.0') ?? 0.0,
      description: json['description'] as String? ?? '',
      features:
          (json['advantages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      sectionTag: json['section_tag'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'category': category,
      'image_url': imageUrl,
      'location': location,
      'rating': rating,
      'original_price': originalPrice,
      'discount_percentage': discountPercentage,
      'final_price': price,
      'description': description,
      'advantages': features,
      'section_tag': sectionTag,
    };
  }
}
