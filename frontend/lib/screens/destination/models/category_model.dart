import 'package:flutter/material.dart';

class CategoryModel {
  final String label;
  final String? iconPath;
  final String? iconSvg;
  final Widget? targetPage;

  CategoryModel({
    required this.label,
    this.iconPath,
    this.iconSvg,
    this.targetPage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      label: json['label'] as String,
      iconPath: json['iconPath'] as String?,
      iconSvg: json['iconSvg'] as String?,
      // Note: targetPage cannot be directly serialized from JSON
      // This would usually be handled by a router or factory
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'iconPath': iconPath,
      'iconSvg': iconSvg,
    };
  }
}
