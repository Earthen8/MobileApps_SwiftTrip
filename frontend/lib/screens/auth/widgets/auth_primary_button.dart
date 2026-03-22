import 'package:flutter/material.dart';

class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;
  final Color textColor;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = 315,
    this.height = 48,
    this.color = const Color(0xFF2B99E3),
    this.textColor = const Color(0xFFF7F9F9),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: color,
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
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}
