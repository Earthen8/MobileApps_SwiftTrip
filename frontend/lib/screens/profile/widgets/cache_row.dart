import 'package:flutter/material.dart';

class CacheRow extends StatelessWidget {
  final String label;
  final double valueKb;

  const CacheRow({super.key, required this.label, required this.valueKb});

  @override
  Widget build(BuildContext context) {
    final display = valueKb == 0
        ? '0 kb'
        : '${valueKb.toStringAsFixed(0)} kb';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        Text(
          display,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
