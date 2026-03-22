import 'package:flutter/foundation.dart';

@immutable
class Promotion {
  final String id;
  final String title;
  final String dateRange;
  final String description;

  const Promotion({
    required this.id,
    required this.title,
    required this.dateRange,
    required this.description,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as String,
      title: json['title'] as String,
      dateRange: json['date_range'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date_range': dateRange,
      'description': description,
    };
  }
}
