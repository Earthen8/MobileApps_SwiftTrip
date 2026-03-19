import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  // 1. The Logic Gate
  final bool showBackButton;
  final bool showHamburger;
  final VoidCallback? onHamburgerTap;
  final VoidCallback? onBackTap;

  const TopBar({
    super.key,
    this.showBackButton = false,
    this.showHamburger = true,
    this.onHamburgerTap,
    this.onBackTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

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
          // 2. The Back Arrow (Only renders if showBackButton is true)
          if (showBackButton) ...[
            GestureDetector(
              onTap: onBackTap ?? () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
          ],

          // 3. Your Logo
          SvgPicture.asset('assets/icons/swifttrip_logo.svg', height: 30),

          const Spacer(),

          // 4. The Hamburger Menu (Only renders if showBackButton is false)
          if (showHamburger)
            GestureDetector(
              onTap: onHamburgerTap,
              child: SvgPicture.asset('assets/icons/hamburger.svg', height: 30),
            ),
        ],
      ),
    );
  }
}
