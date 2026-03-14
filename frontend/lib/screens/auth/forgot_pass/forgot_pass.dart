import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'verification.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _verificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 297,
                  child: Text(
                    'Forgot Password?\nWe Got You!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _inputField(controller: _emailController, hint: 'Email'),
                const SizedBox(height: 14),
                _verificationField(
                  controller: _verificationController,
                  hint: 'Email Verification',
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 266,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _socialButton(
                        child: SvgPicture.asset(
                          'assets/icons/facebook_logo.svg',
                          width: 20,
                        ),
                      ),
                      _socialButton(
                        child: SvgPicture.asset(
                          'assets/icons/x_logo.svg',
                          width: 20,
                        ),
                      ),
                      _socialButton(
                        child: SvgPicture.asset(
                          'assets/icons/google_logo.svg',
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 315,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2B99E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF7F9F9),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 315,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Have Another Account?',
                        style: TextStyle(
                          color: Color(0xFF0C161C),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF2B99E3),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      width: 347,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8EDF2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD1DEE5)),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: hint == 'Email'
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              style: const TextStyle(
                color: Color(0xFF0C161C),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF4F7A93),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verificationField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      width: 347,
      height: 56,
      decoration: ShapeDecoration(
        color: const Color(0xFFE8EDF2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD1DEE5)),
          borderRadius: BorderRadius.circular(12),
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
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Color(0xFF0C161C),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF4F7A93),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(right: 90),
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 80,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFF2B99E3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Ask\nCode',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF7F9F9),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton({required Widget child}) {
    return Container(
      width: 74,
      height: 40,
      decoration: ShapeDecoration(
        color: const Color(0xFF2B99E3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
