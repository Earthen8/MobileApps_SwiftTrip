import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import '../customer_service/onboarding.dart';
import 'widgets/destination_search_bar.dart';
import 'widgets/category_list.dart';
import 'widgets/destination_section.dart';
import 'search.dart';
import 'services/destination_service.dart';

// --- Main Page ---
class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = DestinationService();

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
                    items: service.getDiscountDestinations(),
                  ),
                  DestinationSection(
                    title: 'People’s Favorites',
                    items: service.getFavoriteDestinations(),
                  ),
                  DestinationSection(
                    title: 'Hot Destinations',
                    items: service.getHotDestinations(),
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
