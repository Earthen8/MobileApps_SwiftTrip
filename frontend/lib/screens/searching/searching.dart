import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import 'land_vehicle.dart';
import '../customer_service/onboarding.dart';

class CouponModel {
  final String title;
  final String description;
  final String code;

  const CouponModel({
    required this.title,
    required this.description,
    required this.code,
  });
}

class SearchingPage extends StatelessWidget {
  const SearchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Image.asset(
              'assets/images/searching/background.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              TopBar(
                onHamburgerTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                  );
                },
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      const _FlightSearchCard(),
                      const SizedBox(height: 30),
                      const _CouponSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FlightSearchCard extends StatefulWidget {
  const _FlightSearchCard();

  @override
  State<_FlightSearchCard> createState() => _FlightSearchCardState();
}

class _FlightSearchCardState extends State<_FlightSearchCard> {
  String _fromLabel = 'Jakarta (JKTA)';
  String _toLabel = 'Malang (MLA)';
  String _dateLabel = 'Friday, 20 Feb 2026';
  String _passengerLabel = '1 Passenger';
  String _classLabel = 'Economy';
  bool _isSwapped = false;
  bool _isMultiCity = false;

  // TODO: Each leg will carry from/to/date — send as array to backend
  final List<Map<String, String>> _multiCityLegs = [
    {
      'from': 'Malang (MLA)',
      'to': 'Malang (MLA)',
      'date': 'Friday, 20 Feb 2026',
    },
  ];

  void _addLeg() {
    setState(() {
      final String lastTo = _multiCityLegs.last['to'] ?? 'Malang (MLA)';
      _multiCityLegs.add({
        'from': lastTo,
        'to': 'Malang (MLA)',
        'date': 'Friday, 20 Feb 2026',
      });
    });
  }

  void _removeLeg(int index) {
    if (_multiCityLegs.length > 1) {
      setState(() => _multiCityLegs.removeAt(index));
    }
  }

  void _swap() {
    setState(() {
      final temp = _fromLabel;
      _fromLabel = _toLabel;
      _toLabel = temp;
      _isSwapped = !_isSwapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
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
          // Tabs
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isMultiCity = false),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: !_isMultiCity
                              ? const Color(0xFF2B99E3)
                              : Colors.black.withOpacity(0.1),
                          width: !_isMultiCity ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Round-trip',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: const Color(0xFF2B99E3),
                        fontSize: 16,
                        fontWeight: !_isMultiCity
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isMultiCity = true),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _isMultiCity
                              ? const Color(0xFF2B99E3)
                              : Colors.black.withOpacity(0.1),
                          width: _isMultiCity ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Multi-city',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: const Color(0xFF2B99E3),
                        fontSize: 16,
                        fontWeight: _isMultiCity
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Inputs
          if (!_isMultiCity) ...[
            // ── Round-trip layout ──────────────────────────────
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    _SearchInputField(
                      label: 'From',
                      icon: Icons.flight_takeoff,
                      value: _fromLabel,
                    ),
                    _SearchInputField(
                      label: 'To',
                      icon: Icons.flight_land,
                      value: _toLabel,
                    ),
                  ],
                ),
                Positioned(
                  top: 40,
                  right: 0,
                  child: GestureDetector(
                    onTap: _swap,
                    child: AnimatedRotation(
                      turns: _isSwapped ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.swap_vert,
                          size: 20,
                          color: Color(0xFF2B99E3),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _SearchInputField(
              label: 'Date',
              icon: Icons.calendar_today_outlined,
              value: _dateLabel,
            ),
            Row(
              children: [
                Expanded(
                  child: _SearchInputField(
                    label: 'Penumpang',
                    icon: Icons.person_outline,
                    value: _passengerLabel,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SearchInputField(
                    label: 'Flight Class',
                    icon: Icons.airline_seat_recline_normal,
                    value: _classLabel,
                  ),
                ),
              ],
            ),
          ] else ...[
            // ── Multi-city layout ───────────────────────────────────────────
            ...List.generate(_multiCityLegs.length, (i) {
              final leg = _multiCityLegs[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (i == 0)
                    _SearchInputField(
                      label: 'From',
                      icon: Icons.flight_takeoff,
                      value: leg['from'],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: _SearchInputField(
                          label: 'To',
                          icon: Icons.flight_land,
                          value: leg['to'],
                        ),
                      ),
                      if (i > 0)
                        GestureDetector(
                          onTap: () => _removeLeg(i),
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 12, left: 8),
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.black54,
                              size: 22,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }),

            // ── Add leg button ──────────────────────────────────────────────
            GestureDetector(
              onTap: _addLeg,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),

            _SearchInputField(
              label: 'Date',
              icon: Icons.calendar_today_outlined,
              value: _dateLabel,
            ),
            Row(
              children: [
                Expanded(
                  child: _SearchInputField(
                    label: 'Penumpang',
                    icon: Icons.person_outline,
                    value: _passengerLabel,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SearchInputField(
                    label: 'Flight Class',
                    icon: Icons.airline_seat_recline_normal,
                    value: _classLabel,
                  ),
                ),
              ],
            ),

            // ── Penerbangan (airline picker) ────────────────────────────────
            _SearchInputFieldWithTrailing(
              label: 'Penerbangan',
              icon: Icons.airplanemode_active,
              // TODO: Replace with selected airline from backend options
              value: 'Citilink',
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LandVehicleSearch(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                    ),
                    child: const Text(
                      'Kendaraan Darat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF616161),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B99E3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Cari',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchInputField extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? value;

  const _SearchInputField({this.label, this.icon, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black.withOpacity(0.60),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon ?? Icons.circle, size: 20, color: Colors.black),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),
                  child: Text(
                    value ?? '-',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchInputFieldWithTrailing extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? value;
  final Widget? trailing;

  const _SearchInputFieldWithTrailing({
    this.label,
    this.icon,
    this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black.withOpacity(0.60),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon ?? Icons.circle, size: 20, color: Colors.black),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),
                  child: Text(
                    value ?? '-',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ],
      ),
    );
  }
}

class _CouponSection extends StatefulWidget {
  const _CouponSection();

  @override
  State<_CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<_CouponSection> {
  final TextEditingController _couponController = TextEditingController();

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
      builder: (_) => _CouponOverlay(
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

  static const List<String> _categories = [
    'Coupon Raya',
    'Coupon Ticket Plane',
    'Australia',
    'Indonesia',
  ];

  static const List<CouponModel> _coupons = [
    CouponModel(
      title: 'Coupon Raya',
      description: 'Get 10% discount on your next purchase',
      code: 'COUPON123',
    ),
    CouponModel(
      title: 'Coupon Ticket Plane',
      description: 'Get 20% discount on your next purchase',
      code: 'COUPON456',
    ),
    CouponModel(
      title: 'Australia',
      description: 'Get 30% discount on your next purchase',
      code: 'COUPON789',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Limited Coupon',
              style: const TextStyle(
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_categories.length, (index) {
              return _buildChip(_categories[index], isActive: index == 0);
            }),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _coupons
                .map((coupon) => _CouponCard(coupon: coupon))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5A9AE5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.black12,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: isActive ? Colors.white : const Color(0xFF5A9AE5),
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  final CouponModel coupon;
  const _CouponCard({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF5A9AE5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flight, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  coupon.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const Icon(Icons.info_outline, size: 16, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              coupon.description,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.copy, size: 12, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(
                        coupon.code,
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A9AE5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'COPY', // TODO: Implement Copy
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CouponOverlay extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;
  final VoidCallback onUse;

  const _CouponOverlay({
    required this.controller,
    required this.onCancel,
    required this.onUse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      decoration: const ShapeDecoration(
        color: Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title ──────────────────────────────────────────────────
          const Center(
            child: Text(
              'Use Coupon?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Coupon label ────────────────────────────────────────────
          const Text(
            'Coupon',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // ── Input row ───────────────────────────────────────────────
          Row(
            children: [
              const Icon(
                Icons.discount_outlined,
                size: 20,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Punya Kupon?',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: const Color(0x99999999),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Icon(Icons.copy_outlined, size: 18, color: Colors.black45),
            ],
          ),

          const Divider(color: Color(0x4D000000), thickness: 1),
          const SizedBox(height: 12),

          // ── Action buttons ──────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onCancel,
                child: Container(
                  width: 60,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDFDFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          offset: Offset.zero,
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onUse,
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2B99E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Use',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
