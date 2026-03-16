import 'package:flutter/material.dart';
import 'customer_service_page.dart';

class CustomerServiceOverlay extends StatelessWidget {
  const CustomerServiceOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F3D),
      body: SafeArea(
        child: Stack(
          children: [
            // ── X close button — top right ──────────────────────────────
            Positioned(
              top: 12,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),

            // ── Center: animated "Customer Service" text ────────────────
            const Center(
              child: _AnimatedCsText(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED TEXT  — hover → scale up + yellow color
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedCsText extends StatefulWidget {
  const _AnimatedCsText();

  @override
  State<_AnimatedCsText> createState() => _AnimatedCsTextState();
}

class _AnimatedCsTextState extends State<_AnimatedCsText>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _colorAnim = ColorTween(
      begin: Colors.white,
      end: const Color(0xFFFFD700), // gold yellow
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    setState(() => _hovered = true);
    _controller.forward();
  }

  void _onHoverExit() {
    setState(() => _hovered = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerServicePage(),
            ),
          );
        },
        // Also handle tap hold for mobile (finger press = hover effect)
        onTapDown: (_) => _onHoverEnter(),
        onTapUp: (_) => _onHoverExit(),
        onTapCancel: () => _onHoverExit(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Transform.scale(
              scale: _scaleAnim.value,
              child: Text(
                'Customer Service',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: _colorAnim.value,
                  shadows: _hovered
                      ? [
                          Shadow(
                            color: const Color(0xFFFFD700).withOpacity(0.5),
                            blurRadius: 16,
                            offset: Offset.zero,
                          ),
                        ]
                      : [],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}