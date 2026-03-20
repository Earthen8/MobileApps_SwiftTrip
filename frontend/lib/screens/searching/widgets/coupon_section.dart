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

  static const List<String> _categories = [
    'Coupon Raya',
    'Coupon Ticket Plane',
    'Australia',
    'Indonesia',
  ];

  static const List<CouponModel> _coupons = [
    CouponModel(
      title: 'Coupon Raya',
      description: 'Get 10% discount on your next purchase',
      code: 'COUPON123',
    ),
    CouponModel(
      title: 'Coupon Ticket Plane',
      description: 'Get 20% discount on your next purchase',
      code: 'COUPON456',
    ),
    CouponModel(
      title: 'Australia',
      description: 'Get 30% discount on your next purchase',
      code: 'COUPON789',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Limited Coupon',
              style: const TextStyle(
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_categories.length, (index) {
              return _buildChip(_categories[index], isActive: index == 0);
            }),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _coupons
                .map((coupon) => CouponCard(coupon: coupon))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5A9AE5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.black12,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: isActive ? Colors.white : const Color(0xFF5A9AE5),
          fontSize: 12,
        ),
      ),
    );
  }
}

