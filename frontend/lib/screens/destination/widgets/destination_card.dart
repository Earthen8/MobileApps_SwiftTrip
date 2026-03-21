import 'package:flutter/material.dart';

class DestinationModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final bool hasDiscount;
  final bool isFavorite;

  DestinationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    this.hasDiscount = false,
    this.isFavorite = false,
  });
}

class DestinationCard extends StatelessWidget {
  final DestinationModel destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  destination.imageUrl,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 110,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              if (destination.hasDiscount)
                const Positioned(
                  top: 8,
                  left: 8,
                  child: Icon(
                    Icons.discount_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  destination.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  destination.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    destination.rating.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.star, size: 12, color: Colors.black),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
