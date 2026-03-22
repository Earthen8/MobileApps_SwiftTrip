import 'package:flutter/material.dart';
import 'package:swifttrip_frontend/screens/cart/models/cart_models.dart';
import 'package:swifttrip_frontend/screens/cart/widgets/ticket_card.dart';
import '../../widgets/top_bar.dart';
import '../cart/cart.dart';
import '../cart/checkout/checkout.dart';
import '../main/main_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────────────────────

class OrderTicketPage extends StatefulWidget {
  const OrderTicketPage({super.key});

  @override
  State<OrderTicketPage> createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  // TODO: Replace with data fetched from backend (e.g. GET /tickets/search-results)
  final List<CartTicket> _tickets = [
    const CartTicket(
      type: 'Train Ticket',
      bookingId: 'ID-1231KADASMASDKAASD',
      classLabel: 'ECONOMY CLASS',
      from: 'Jakarta',
      to: 'Ngawi Barat',
      date: '19/2/2026',
      departure: '9:00',
      arrive: '11:00',
      train: '1234',
      carriage: '01',
      seat: 'A12',
      priceRp: 100000,
    ),
    const CartTicket(
      type: 'Train Ticket',
      bookingId: 'ID-1231KADASMASDKAASD',
      classLabel: 'ECONOMY CLASS',
      from: 'Ngawati Barat',
      to: 'Solo',
      date: '19/2/2026',
      departure: '9:00',
      arrive: '11:00',
      train: '1234',
      carriage: '01',
      seat: 'A12',
      priceRp: 100000,
    ),
    const CartTicket(
      type: 'Train Ticket',
      bookingId: 'ID-1231KADASMASDKAASD',
      classLabel: 'ECONOMY CLASS',
      from: 'Jakarta',
      to: 'Ngawi Barat',
      date: '19/2/2026',
      departure: '9:00',
      arrive: '11:00',
      train: '1234',
      carriage: '01',
      seat: 'A12',
      priceRp: 100000,
    ),
  ];

  // TODO: Track which tickets are selected for cart/checkout
  final Set<int> _selectedIndices = {};

  int get _totalPrice =>
      _selectedIndices.fold(0, (sum, i) => sum + _tickets[i].priceRp);

  String _formatRp(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp. ${buffer.toString()}';
  }

  void _handleAddToCart() {
    // TODO: POST selected tickets to cart endpoint
    // TODO: Navigate to CartPage or show confirmation snackbar
    debugPrint('Add to cart: $_selectedIndices');
  }

  void _handleConfirm() {
    // TODO: POST selected tickets directly to checkout/order endpoint
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CheckoutPage()),
    );
  }

  void _removeTicket(int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 313,
            height: 157,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFFFCDCD),
                  Color(0xFFF6F6F6),
                  Color(0xFFF6F6F6),
                  Color(0xFFFFCDCD),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x4C000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Are You Sure To Remove \nYour Order?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 121,
                        height: 37,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: const Color(0xFFFFFFFF),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF999999),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 8,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Delete Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _tickets.removeAt(index);
                          _selectedIndices.remove(index);
                          // Adjust remaining indices to account for the removal
                          final updated = _selectedIndices
                              .map((i) => i > index ? i - 1 : i)
                              .toSet();
                          _selectedIndices.clear();
                          _selectedIndices.addAll(updated);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 121,
                        height: 33,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE55A5A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          const TopBar(showBackButton: true, showHamburger: false),

          // ── Ticket List ────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                children: List.generate(
                  _tickets.length,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedIndices.contains(i)) {
                            _selectedIndices.remove(i);
                          } else {
                            _selectedIndices.add(i);
                          }
                        });
                      },
                      child: TicketCard(
                        ticket: _tickets[i],
                        formatRp: _formatRp,
                        onDelete: () => _removeTicket(i),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom Action Bar ──────────────────────────────────────────
          _BottomActionBar(
            totalLabel: _totalPrice > 0
                ? _formatRp(_totalPrice)
                : 'Rp. 300.000', // TODO: Remove fallback once selection is wired
            onAddToCart: _handleAddToCart,
            onConfirm: _handleConfirm,
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM ACTION BAR
// ─────────────────────────────────────────────────────────────────────────────

class _BottomActionBar extends StatelessWidget {
  final String totalLabel;
  final VoidCallback onAddToCart;
  final VoidCallback onConfirm;

  const _BottomActionBar({
    required this.totalLabel,
    required this.onAddToCart,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 59,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              // ── Total Price ─────────────────────────────────────────────
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),
                  Text(
                    totalLabel,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      height: 1.54,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ── Add To Cart Button ──────────────────────────────────────
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(initialIndex: 1),
                    ),
                  );
                },
                child: Container(
                  width: 103,
                  height: 29,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Add To Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // ── Confirm Button ──────────────────────────────────────────
              GestureDetector(
                onTap: onConfirm,
                child: Container(
                  width: 103,
                  height: 29,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2B99E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE5E5E5),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
