import 'package:flutter/material.dart';

class CsDropdownLabel extends StatelessWidget {
  final String text;

  const CsDropdownLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        height: 1.2,
        color: Colors.black,
      ),
    );
  }
}
