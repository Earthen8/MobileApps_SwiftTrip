import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/customer_service/customer_service_overlay.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        left: 20,
        right: 20,
        bottom: 15,
      ),
      child: Row(
        children: [
          // Logo
          SvgPicture.asset('assets/icons/swifttrip_logo.svg', height: 30),

          const Spacer(),

          // Menu icon — tap to open Customer Service overlay
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CustomerServiceOverlay(),
                ),
              );
            },
            child: SvgPicture.asset('assets/icons/hamburger.svg', height: 30),
          ),
        ],
      ),
    );
  }
}