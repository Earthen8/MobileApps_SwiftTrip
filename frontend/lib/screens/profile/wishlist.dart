import 'package:flutter/material.dart';
import '../destination/category_page_base.dart';
import '../destination/detail_page.dart';
import '../destination/models/destination_model.dart';
import 'services/wishlist_service.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistService _wishlistService = WishlistService();
  List<DestinationModel> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    try {
      final items = await _wishlistService.getWishlistItems();
      if (mounted) {
        setState(() {
          _items = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching wishlist: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToDetail(DestinationModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DestinationDetailPage(destination: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return CategoryPageBase(
      title: 'Wishlist',
      items: _items,
      onItemTap: _navigateToDetail,
    );
  }
}
