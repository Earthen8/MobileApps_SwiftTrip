import 'package:flutter/material.dart';
import '../models/coupon_model.dart';
import 'coupon_card.dart';
import 'coupon_overlay.dart';
import '../services/searching_service.dart';

class CouponSection extends StatefulWidget {
  const CouponSection({super.key});

  @override
  State<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  final TextEditingController _couponController = TextEditingController();
  final SearchingService _service = const SearchingService();
  List<String> _categories = [];
  List<CouponModel> _activeCoupons = [];
  int _activeCategory = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final cats = await _service.getCouponCategories();
    if (!mounted) return;
    setState(() {
      _categories = cats;
      _isLoading = _categories.isEmpty;
    });
    if (_categories.isNotEmpty) {
      _fetchCoupons();
    }
  }

  Future<void> _fetchCoupons() async {
    setState(() => _isLoading = true);
    final coupons = await _service.getCouponsByCategory(_categories[_activeCategory]);
    if (!mounted) return;
    setState(() {
      _activeCoupons = coupons;
      _isLoading = false;
    });
  }

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
                  _fetchCoupons();
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
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
