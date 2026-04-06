import 'package:flutter/material.dart';
import '../screens/cart/models/cart_models.dart';
import '../screens/cart/services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartTicket> _tickets = [];

  List<CartTicket> get tickets => _tickets;

  Future<void> loadCart() async {
    _tickets = await _cartService.fetchTickets();
    notifyListeners();
  }

  void addTicket(CartTicket ticket) {
    _cartService.addTicket(ticket);
    loadCart();
  }

  void removeTicket(int index) {
    _cartService.removeTicket(index);
    loadCart();
  }

  void clearCart() {
    // Also need to clear in the service if it's keeping local state
    // For now we'll implement clearCart in service too
    _cartService.clearLocalCart();
    _tickets = [];
    notifyListeners();
  }
}
