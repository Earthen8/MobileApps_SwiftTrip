import 'package:flutter/material.dart';
import '../models/coupon_model.dart';
import 'coupon_card.dart';
import 'coupon_overlay.dart';

class CouponSection extends StatefulWidget {
  const CouponSection({super.key});

  @override
  State<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  final TextEditingController _couponController = TextEditingController();
  int _activeCategory = 0;

  // TODO: Fetch categories from backend
  static const List<String> _categories = [
    'Coupon Raya',
    'Coupon Ticket Plane',
    'Australia',
    'Indonesia',
  ];

  // TODO: Replace with backend data keyed by category
  static const Map<String, List<CouponModel>> _couponsByCategory = {
    'Coupon Raya': [
      CouponModel(
        title: 'Raya Special',
        description: 'Get 10% off this Raya',
        code: 'RAYA10',
      ),
      CouponModel(
        title: 'Raya Extra',
        description: 'Get 15% off this Raya',
        code: 'RAYA15',
      ),
    ],
    'Coupon Ticket Plane': [
      CouponModel(
        title: 'Plane Saver',
        description: 'Get 20% off flights',
        code: 'PLANE20',
      ),
      CouponModel(
        title: 'Fly More',
        description: 'Get 25% off flights',
        code: 'FLY25',
      ),
    ],
    'Australia': [
      CouponModel(
        title: 'AUS Deal',
        description: 'Get 30% off to Australia',
        code: 'AUS30',
      ),
    ],
    'Indonesia': [
      CouponModel(
        title: 'IDN Deal',
        description: 'Get 5% off domestic',
        code: 'IDN05',
      ),
    ],
  };

  List<CouponModel> get _activeCoupons =>
      _couponsByCategory[_categories[_activeCategory]] ?? [];

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _showCouponOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CouponOverlay(
        controller: _couponController,
        onCancel: () => Navigator.pop(context),
        onUse: () {
          // TODO: Validate and apply coupon code via backend
          // TODO: Apply discount to current search session on success
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Limited Coupon',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: _showCouponOverlay,
              child: const Text(
                'Use Coupon?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xFF2B99E3),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Category chips ─────────────────────────────────────────────
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_categories.length, (index) {
              final isActive = index == _activeCategory;
              return GestureDetector(
                onTap: () {
                  setState(() => _activeCategory = index);
                  // TODO: Fetch coupons by _categories[index] from backend
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF5A9AE5) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? Colors.transparent : Colors.black12,
                    ),
                  ),
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: isActive ? Colors.white : const Color(0xFF5A9AE5),
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // ── Coupon cards ───────────────────────────────────────────────
        // TODO: Replace _activeCoupons with API response filtered by active category
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _activeCoupons
                .map((coupon) => CouponCard(coupon: coupon))
                .toList(),
          ),
        ),
      ],
    );
  }
}
