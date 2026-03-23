import 'package:flutter/material.dart';
import 'menu_item.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MENU SECTION  (white card with dividers between items)
// ─────────────────────────────────────────────────────────────────────────────

class MenuSection extends StatelessWidget {
  final List<MenuItem> items;

  const MenuSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1)
              const Divider(height: 1, indent: 20, endIndent: 20),
          ],
        ],
      ),
    );
  }
}
