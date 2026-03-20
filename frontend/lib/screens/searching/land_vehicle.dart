import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifttrip_frontend/screens/cart/promotions.dart';
import '../../widgets/top_bar.dart';
import '../customer_service/onboarding.dart';
import '../home/next_trip.dart';
import '../cart/cart.dart';
import '../checkout/checkout.dart';
import '../main/main_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _RideOption {
  final String name;
  final String duration;
  final int passengerCapacity;
  final int priceRp;
  final IconData icon;

  const _RideOption({
    required this.name,
    required this.duration,
    required this.passengerCapacity,
    required this.priceRp,
    required this.icon,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────────────────────

class LandVehicleSearch extends StatefulWidget {
  const LandVehicleSearch({super.key});

  @override
  State<LandVehicleSearch> createState() => _LandVehicleSearchState();
}

class _LandVehicleSearchState extends State<LandVehicleSearch> {
  int? _selectedRideIndex;
  Promotion? _appliedPromo;

  // TODO: Replace with data fetched from backend (e.g. GET /land-vehicles/options)
  final List<_RideOption> _rideOptions = const [
    _RideOption(
      name: 'boom boom boogie',
      duration: '2 hrs',
      passengerCapacity: 4,
      priceRp: 50000,
      icon: Icons.directions_car_outlined,
    ),
    _RideOption(
      name: 'boom boom bus',
      duration: '3 hrs',
      passengerCapacity: 0,
      priceRp: 50000,
      icon: Icons.directions_bus_outlined,
    ),
    _RideOption(
      name: 'boom boom train',
      duration: '4 hrs',
      passengerCapacity: 0,
      priceRp: 75000,
      icon: Icons.train_outlined,
    ),
  ];

  // TODO: Replace with dynamic purchase details from backend
  final List<_DetailRow> _purchaseDetails = const [
    _DetailRow(label: 'Tiket Kereta', amount: 'Rp 14.000.000'),
    _DetailRow(label: 'Voucher', amount: '-Rp 300.000'),
    _DetailRow(label: 'Diskon liburan', amount: '-Rp 1.800.000'),
    _DetailRow(label: 'PPN 10%', amount: 'Rp 110.700'),
  ];

  int get _total {
    // TODO: Calculate total from backend pricing + selected ride
    if (_selectedRideIndex != null) {
      return _rideOptions[_selectedRideIndex!].priceRp;
    }
    return 300000;
  }

  String _formatRp(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'Rp. ${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          // ── Top Bar ──────────────────────────────────────────────────
          TopBar(
            showHamburger: true,
            showBackButton: true,
            onHamburgerTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingPage()),
              );
            },
          ),

          // ── Scrollable Content ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // ── Map Placeholder ───────────────────────────────────
                  _MapPlaceholder(),
                  const SizedBox(height: 30),

                  // ── Choose Ride Section ───────────────────────────────
                  const Text(
                    'Choose ride:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 176,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: _rideOptions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) => _RideCard(
                        option: _rideOptions[i],
                        isSelected: _selectedRideIndex == i,
                        onTap: () => setState(() {
                          _selectedRideIndex = _selectedRideIndex == i
                              ? null
                              : i;
                        }),
                        formatRp: _formatRp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Purchase Details ──────────────────────────────────
                  // TODO: Replace total with computed value from backend
                  _PurchaseDetailsCard(
                    details: _purchaseDetails,
                    total: 'Rp 12.000.000',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Pinned Bottom Section ─────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          MediaQuery.of(context).padding.bottom + 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Apply Promotions ────────────────────────────────────────
            ApplyPromotionsRow(
              appliedPromo: _appliedPromo,
              onTap: () async {
                final result = await Navigator.push<Promotion?>(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PromotionsPage(initialSelection: _appliedPromo),
                  ),
                );
                if (mounted && result != _appliedPromo) {
                  setState(() => _appliedPromo = result);
                }
              },
            ),
            const SizedBox(height: 10),

            // ── Total + Confirm ─────────────────────────────────────────
            _TotalConfirmBar(
              totalLabel: 'Total:',
              totalAmount: _formatRp(_total),
              onConfirm: () {
                // TODO: POST selected ride + applied promo to backend
                // TODO: Navigate to checkout or booking confirmation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RIDE CARD
// ─────────────────────────────────────────────────────────────────────────────

class _RideCard extends StatelessWidget {
  final _RideOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final String Function(int) formatRp;

  const _RideCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.formatRp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 164,
        height: 176,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ── Radio indicator top-right ─────────────────────────────
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 18,
                height: 20,
                decoration: ShapeDecoration(
                  color: isSelected
                      ? const Color(0xFF2B99E3)
                      : Colors.white.withOpacity(0),
                  shape: OvalBorder(
                    side: const BorderSide(width: 2, color: Color(0xFF2B99E3)),
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 11, color: Colors.white)
                    : null,
              ),
            ),

            // ── Vehicle icon centered top ─────────────────────────────
            Positioned(
              top: 34,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(option.icon, size: 55, color: Colors.black87),
              ),
            ),

            // ── Name ─────────────────────────────────────────────────
            Positioned(
              top: 93,
              left: 0,
              right: 0,
              child: Text(
                option.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),

            // ── Duration + capacity ───────────────────────────────────
            Positioned(
              top: 117,
              left: 46,
              child: Text(
                option.duration,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
            if (option.passengerCapacity > 0)
              Positioned(
                top: 117,
                right: 46,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 14,
                      color: Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${option.passengerCapacity}',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Price ─────────────────────────────────────────────────
            Positioned(
              top: 151,
              left: 0,
              right: 0,
              child: Text(
                formatRp(option.priceRp),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOTAL + CONFIRM BAR
// ─────────────────────────────────────────────────────────────────────────────

class _TotalConfirmBar extends StatelessWidget {
  final String totalLabel;
  final String totalAmount;
  final VoidCallback onConfirm;

  const _TotalConfirmBar({
    required this.totalLabel,
    required this.totalAmount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 59,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Total ───────────────────────────────────────────────────
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalLabel,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                totalAmount,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Confirm button ──────────────────────────────────────────
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              width: 90,
              height: 32,
              decoration: ShapeDecoration(
                color: const Color(0xFF2B99E3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAP PLACEHOLDER
// ─────────────────────────────────────────────────────────────────────────────

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 180,
        color: const Color(0xFFCBD5E1),
        child: Stack(
          children: [
            // TODO: Replace with actual map widget (e.g. google_maps_flutter)
            // TODO: Center map on ticket departure → arrival coordinates
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.map_outlined, size: 48, color: Colors.white54),
                  SizedBox(height: 8),
                  Text(
                    'Map Placeholder',
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PURCHASE DETAILS CARD
// ─────────────────────────────────────────────────────────────────────────────

class _DetailRow {
  final String label;
  final String amount;

  const _DetailRow({required this.label, required this.amount});
}

class _PurchaseDetailsCard extends StatelessWidget {
  final List<_DetailRow> details;
  final String total;

  const _PurchaseDetailsCard({required this.details, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rincian Pembelian:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.black12, thickness: 1),
          const SizedBox(height: 8),

          ...details.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    row.label,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    row.amount,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Divider(color: Colors.black12, thickness: 1),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                total,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
