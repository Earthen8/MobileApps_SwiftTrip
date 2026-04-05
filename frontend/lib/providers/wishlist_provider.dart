import 'package:flutter/foundation.dart';
import 'package:swifttrip_frontend/screens/destination/services/destination_service.dart';

class WishlistProvider extends ChangeNotifier {
  final Set<String> _wishlistedIds = {};
  bool _isLoading = false;

  Set<String> get wishlistedIds => _wishlistedIds;
  bool get isLoading => _isLoading;

  Future<void> loadWishlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      final ids = await DestinationService().fetchWishlistIds();
      _wishlistedIds.clear();
      _wishlistedIds.addAll(ids);
    } catch (e) {
      print('Error loading wishlist: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearWishlist() {
    _wishlistedIds.clear();
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _wishlistedIds.contains(id);
  }

  Future<bool> toggleWishlist(String id) async {
    final bool wasFavorite = _wishlistedIds.contains(id);

    // Optimistic UI toggle
    if (wasFavorite) {
      _wishlistedIds.remove(id);
    } else {
      _wishlistedIds.add(id);
    }
    notifyListeners();

    // Backend call
    final success = await DestinationService().toggleWishlist(id);

    // Rollback if failure
    if (!success) {
      if (wasFavorite) {
        _wishlistedIds.add(id);
      } else {
        _wishlistedIds.remove(id);
      }
      notifyListeners();
    }

    return success;
  }
}
