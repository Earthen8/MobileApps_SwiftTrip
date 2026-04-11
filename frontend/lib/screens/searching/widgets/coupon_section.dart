import 'package:flutter/material.dart';
import '../models/coupon_model.dart';
import 'coupon_card.dart';
import 'coupon_overlay.dart';
import '../services/searching_service.dart';
import 'package:provider/provider.dart';
import '../../../providers/language_provider.dart';
import '../../../core/constants.dart';

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
    final coupons = await _service.getCouponsByCategory(
      _categories[_activeCategory],
    );
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

  // ── Coupon collection logic ───────────────────────────────────────────────

  Future<void> _collectCoupon(String code) async {
    if (code.trim().isEmpty) return;

    final langProvider = context.read<LanguageProvider>();
    final success = await _service.collectCoupon(code.trim());
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            success ? Constants.popupSuccess : Constants.popupError,
        content: Text(
          langProvider.translate(
            success ? 'coupon_collected' : 'coupon_collect_failed',
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
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
          Navigator.pop(context);
          _collectCoupon(_couponController.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              langProvider.translate('limited_coupon'),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: _showCouponOverlay,
              child: Text(
                langProvider.translate('use_coupon'),
                style: const TextStyle(
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
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _activeCoupons
                      .map(
                        (coupon) => CouponCard(
                          coupon: coupon,
                          onCollect: () => _collectCoupon(coupon.code),
                        ),
                      )
                      .toList(),
                ),
              ),
      ],
    );
  }
}
