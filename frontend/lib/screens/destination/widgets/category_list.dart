import 'package:flutter/material.dart';
import 'category_item.dart';
import '../services/destination_service.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = DestinationService().getCategories();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((cat) => CategoryItem(category: cat)).toList(),
      ),
    );
  }
}
