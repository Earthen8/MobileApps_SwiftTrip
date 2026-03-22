import 'package:flutter/material.dart';
import 'package:swifttrip_frontend/screens/cart/models/promotion_models.dart';
import 'package:swifttrip_frontend/screens/cart/promotions.dart';
import 'package:swifttrip_frontend/screens/cart/widgets/cart_bottom_bar.dart' hide TotalConfirmBar;
import '../../widgets/top_bar.dart';
import '../customer_service/onboarding.dart';


import '../cart/checkout/checkout.dart';
import 'models/detail_row.dart';
import 'models/ride_option.dart';
import 'utils/rp_format.dart';
import 'widgets/map_placeholder.dart';
import 'widgets/purchase_details_card.dart';
import 'widgets/ride_card.dart';
import 'widgets/total_confirm_bar.dart';

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
  final List<RideOption> _rideOptions = const [
    RideOption(
      name: 'boom boom boogie',
      duration: '2 hrs',
      passengerCapacity: 4,
      priceRp: 50000,
      icon: Icons.directions_car_outlined,
    ),
    RideOption(
      name: 'boom boom bus',
      duration: '3 hrs',
      passengerCapacity: 0,
      priceRp: 50000,
      icon: Icons.directions_bus_outlined,
    ),
    RideOption(
      name: 'boom boom train',
      duration: '4 hrs',
      passengerCapacity: 0,
      priceRp: 75000,
      icon: Icons.train_outlined,
    ),
  ];

  // TODO: Replace with dynamic purchase details from backend
  final List<DetailRow> _purchaseDetails = const [
    DetailRow(label: 'Tiket Kereta', amount: 'Rp 14.000.000'),
    DetailRow(label: 'Voucher', amount: '-Rp 300.000'),
    DetailRow(label: 'Diskon liburan', amount: '-Rp 1.800.000'),
    DetailRow(label: 'PPN 10%', amount: 'Rp 110.700'),
  ];

  int get _total {
    // TODO: Calculate total from backend pricing + selected ride
    if (_selectedRideIndex != null) {
      return _rideOptions[_selectedRideIndex!].priceRp;
    }
    return 300000;
  }

  // Kept for now to avoid touching behavior in this file.
  // (The widget layer uses `formatRp()` extracted into `utils/`.)

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
                  const MapPlaceholder(),
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
                      itemBuilder: (_, i) => RideCard(
                        option: _rideOptions[i],
                        isSelected: _selectedRideIndex == i,
                        onTap: () => setState(() {
                          _selectedRideIndex = _selectedRideIndex == i
                              ? null
                              : i;
                        }),
                        formatRp: formatRp,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Purchase Details ──────────────────────────────────
                  // TODO: Replace total with computed value from backend
                  PurchaseDetailsCard(
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
            TotalConfirmBar(
              totalLabel: 'Total:',
              totalAmount: formatRp(_total),
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


