import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import 'models/promotion_models.dart';
import 'services/cart_service.dart';
import 'widgets/promo_card.dart';

class PromotionsPage extends StatefulWidget {
  final Promotion? initialSelection;

  const PromotionsPage({super.key, this.initialSelection});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  final CartService _cartService = CartService();
  Promotion? _selectedPromo;
  List<Promotion> _promotions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedPromo = widget.initialSelection;
    _loadData();
  }

  Future<void> _loadData() async {
    final promotions = await _cartService.fetchPromotions();
    if (mounted) {
      setState(() {
        _promotions = promotions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const TopBar(showBackButton: true, showHamburger: false),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _promotions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final promo = _promotions[index];
                        final isSelected = _selectedPromo?.id == promo.id;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPromo = isSelected ? null : promo;
                            });
                          },
                          child: PromoCard(
                              promotion: promo, isSelected: isSelected),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 40),
              child: ConfirmButton(
                onTap: () => Navigator.pop(context, _selectedPromo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
