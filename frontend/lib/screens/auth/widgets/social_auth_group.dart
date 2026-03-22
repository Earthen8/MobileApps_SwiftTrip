import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth_widgets.dart';

class SocialAuthGroup extends StatelessWidget {
  const SocialAuthGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 266,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Facebook
          AuthWidgets.socialButton(
            child: SvgPicture.asset(
              'assets/icons/facebook_logo.svg',
              width: 20,
            ),
          ),
          // X (Twitter)
          AuthWidgets.socialButton(
            child: SvgPicture.asset(
              'assets/icons/x_logo.svg',
              width: 20,
            ),
          ),
          // Google
          AuthWidgets.socialButton(
            child: SvgPicture.asset(
              'assets/icons/google_logo.svg',
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
