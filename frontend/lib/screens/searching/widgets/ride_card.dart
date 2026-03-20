import 'package:flutter/material.dart';
import '../models/ride_option.dart';

class RideCard extends StatelessWidget {
  final RideOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final String Function(int) formatRp;

  const RideCard({
    super.key,
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
                    ? const Icon(Icons.check,
                        size: 11, color: Colors.white)
                    : null,
              ),
            ),

            // ── Vehicle icon centered top ─────────────────────────────
            Positioned(
              top: 34,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(option.icon,
                    size: 55, color: Colors.black87),
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

            // ── Duration + capacity ────────────────────────────────
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

            // ── Price ────────────────────────────────────────────────
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

