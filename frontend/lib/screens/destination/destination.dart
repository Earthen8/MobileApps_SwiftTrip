import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import '../customer_service/onboarding.dart';
import 'widgets/destination_search_bar.dart';
import 'widgets/category_list.dart';
import 'widgets/destination_section.dart';
import 'widgets/destination_card.dart';
import 'search.dart';

// --- Main Page ---
class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          TopBar(
            showHamburger: true,
            onHamburgerTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OnboardingPage()),
              );
            },
          ),
          // ── Fixed: search bar + categories ───────────────────────────
          const SizedBox(height: 30),
          DestinationSearchBar(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DestinationSearchPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          const CategoryList(),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black12,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ── Scrollable: destination sections ─────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DestinationSection(
                    title: 'Discount',
                    items: _mockDestinations,
                  ),
                  DestinationSection(
                    title: 'People’s Favorites',
                    items: _mockDestinations,
                  ),
                  DestinationSection(
                    title: 'Hot Destinations',
                    items: _mockDestinations,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Dummy Data ---
final List<DestinationModel> _mockDestinations = [
  DestinationModel(
    id: '1',
    name: 'Bali - Pantai Kuta',
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
    rating: 4.8,
    hasDiscount: true,
    isFavorite: false,
  ),
  DestinationModel(
    id: '2',
    name: 'Yogyakarta - Candi Borobudur',
    imageUrl:
        'https://images.unsplash.com/photo-1588666309990-d68f08e3d4a6?w=500',
    rating: 4.9,
    hasDiscount: false,
    isFavorite: false,
  ),
  DestinationModel(
    id: '3',
    name: 'Labuan Bajo - Pulau Komodo',
    imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=500',
    rating: 4.9,
    hasDiscount: true,
    isFavorite: false,
  ),
  DestinationModel(
    id: '4',
    name: 'Bandung - Kawah Putih',
    imageUrl:
        'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=500',
    rating: 4.7,
    hasDiscount: false,
    isFavorite: false,
  ),
  DestinationModel(
    id: '5',
    name: 'Lombok - Pantai Tanjung Aan',
    imageUrl:
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=500',
    rating: 4.8,
    hasDiscount: true,
    isFavorite: false,
  ),
];
