import '../../cart/models/cart_models.dart';
import 'purchase_item_model.dart';

class CheckoutDetailsModel {
  final List<CartTicket> tickets;
  final List<PurchaseItemModel> purchaseItems;
  final int discountTotal;
  final String totalPrice;

  const CheckoutDetailsModel({
    required this.tickets,
    required this.purchaseItems,
    required this.totalPrice,
    required this.discountTotal,
  });

  factory CheckoutDetailsModel.fromJson(Map<String, dynamic> json) {
    return CheckoutDetailsModel(
      tickets: (json['tickets'] as List<dynamic>)
          .map((item) => CartTicket.fromJson(item as Map<String, dynamic>))
          .toList(),
      purchaseItems: (json['purchase_items'] as List<dynamic>)
          .map((item) => PurchaseItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPrice: json['total_price'] as String,
      discountTotal: json['discount_total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tickets': tickets.map((item) => item.toJson()).toList(),
      'purchase_items': purchaseItems.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
      'discount_total': discountTotal,
    };
  }
}
