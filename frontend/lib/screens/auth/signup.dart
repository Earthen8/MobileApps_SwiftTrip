import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'forgot_pass/forgot_pass.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TextEditingControllers for all input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _verificationController = TextEditingController();

  // State variable to manage password visibility toggles
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    // Crucial: always dispose of controllers when no longer needed
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _verificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Replicating the clean background color from login.dart
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Matching centered layout
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Title: Replicated Exactly ─────────────────────────
                const SizedBox(
                  width: 297,
                  child: Text(
                    'Plan your vacation\nin a flash.',
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

                // ── Input Fields ──────────────────────────────────────
                // Email Field
                _inputField(
                  controller: _emailController,
                  hint: 'Email',
                  obscure: false,
                ),
                const SizedBox(height: 14),

                // Password Field
                _inputField(
                  controller: _passwordController,
                  hint: 'Password',
                  obscure: _obscurePassword,
                  // Toggled suffix icon
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: const Color(0xFF4F7A93),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Confirm Password Field
                _inputField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm Password',
                  obscure: _obscureConfirmPassword,
                  // Toggled suffix icon
                  suffixIcon: GestureDetector(
                    onTap: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: const Color(0xFF4F7A93),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Email Verification Field (Row)
                _verificationField(
                  controller: _verificationController,
                  hint: 'Email Verification',
                ),
                const SizedBox(height: 25),

                // ── Social Buttons: Replicated Style ──────────────────
                SizedBox(
                  width: 266,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Facebook Pill
                      _socialButton(
                        child: SvgPicture.asset(
                          'assets/icons/facebook_logo.svg',
                          width: 20,
                        ),
                      ),
                      // X (Twitter) Pill
                      _socialButton(
                        child: SvgPicture.asset(
                          'assets/icons/x_logo.svg',
                          width: 20,
                        ),
                      ),
                      // Google Pill
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

                // ── Primary Action: Sign Up Button ────────────────────
                GestureDetector(
                  onTap: () {
                    // TODO: handle signup form submission (validate and call backend)
                    print(
                      'Sign Up pressed with Email: ${_emailController.text}',
                    );
                  },
                  child: Container(
                    width: 315,
                    height: 48,
                    decoration: ShapeDecoration(
                      // Main blue theme color
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
                      'Sign Up',
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

                // ── Footer: Already Have An Account? ─────────────────
                SizedBox(
                  width: 315,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Have an account?',
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
                          // Navigate back to login screen
                          Navigator.pop(context);
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
                const SizedBox(height: 12),

                // ── Tertiary Link: Forgot Password ───────────────────
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 367,
                    padding: const EdgeInsets.only(
                      top: 4,
                      left: 16,
                      right: 16,
                      bottom: 12,
                    ),
                    child: const Text(
                      'Forgot password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4F7A93),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        height: 1.50,
                      ),
                    ),
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

  // ── Modified reusable input field (includes basic setup from login.dart)
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    Widget? suffixIcon,
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
              obscureText: obscure,
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
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }

  // ── Specialized Reusable Verification Field (Visual replica) ─────
  Widget _verificationField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      width: 347,
      height: 56,
      decoration: ShapeDecoration(
        // Soft background color
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
          // Visually matching "Ask Code" button
          GestureDetector(
            onTap: () {
              // TODO: implement ask code logic (call backend)
              print('Ask Code pressed');
            },
            child: Container(
              width: 80,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFF2B99E3), // Match theme blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ), // Matching inner curve
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
                  height: 1.10, // Tighter height for multi-line
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reusable social pill button ────────────────────────────────────
  Widget _socialButton({required Widget child}) {
    return Container(
      width: 74,
      height: 40,
      decoration: ShapeDecoration(
        // Social icons use the theme blue as the button color
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
