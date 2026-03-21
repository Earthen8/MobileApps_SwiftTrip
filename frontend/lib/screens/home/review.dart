import 'package:flutter/material.dart';
import '../customer_service/onboarding.dart';
import '../../widgets/top_bar.dart';
import '../main/main_screen.dart';

class ReviewPage extends StatefulWidget {
  // TODO: Accept bookingId and targetName from caller to link review to booking
  final String targetName;

  const ReviewPage({super.key, this.targetName = 'Hotel Santika Bandung'});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 1;
  String? _selectedFeeling;
  final TextEditingController _thoughtsController = TextEditingController();

  // TODO: Fetch these options from backend
  final List<String> _feelingOptions = [
    'Relaxing',
    'Cozy',
    'Luxury',
    'Entertaining',
    'Fun',
  ];

  @override
  void dispose() {
    _thoughtsController.dispose();
    super.dispose();
  }

  Future<void> _handleAddPost() async {
    // TODO: Validate fields before submitting
    // TODO: POST review to backend:
    // {
    //   'target_name': widget.targetName,
    //   'rating': _rating,
    //   'feeling': _selectedFeeling,
    //   'thoughts': _thoughtsController.text.trim(),
    // }

    if (!mounted) return;

    final overlay = Overlay.of(context);
    final double topPadding = MediaQuery.of(context).padding.top;
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: topPadding + 60,
        left: 0,
        right: 0,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF323232),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Review posted!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    await Future.delayed(const Duration(milliseconds: 1500));
    entry.remove();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 0)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          TopBar(
            showBackButton: true,
            onHamburgerTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingPage()),
              );
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Page title ──────────────────────────────────────
                  const Text(
                    'Share Your Experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.targetName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1.94,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Your Rating ─────────────────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Rating',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 2.19,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final filled = index < _rating;
                      return GestureDetector(
                        onTap: () => setState(() => _rating = index + 1),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            filled ? Icons.star : Icons.star_border,
                            size: 50,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Colors.black.withOpacity(0.30), thickness: 1),
                  const SizedBox(height: 20),

                  // ── Tell Us What You Loved ──────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tell Us What You Loved',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    hint: 'How Does It Feels?',
                    value: _selectedFeeling,
                    items: _feelingOptions,
                    onChanged: (val) => setState(() => _selectedFeeling = val),
                  ),

                  const SizedBox(height: 24),

                  // ── Share your moments ──────────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Share your moments with us',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 142,
                    padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFF6F6F6),
                        ),
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
                    child: TextField(
                      controller: _thoughtsController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Your thoughts mean a lot to us',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 2,
                          color: Color(0xFFA0A0A0),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Add Post button ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 40,
              bottom: MediaQuery.of(context).padding.bottom + 40,
              top: 12,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _handleAddPost,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2B99E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Add Post',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DROPDOWN FIELD
// ─────────────────────────────────────────────────────────────────────────────

class _DropdownField extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<_DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<_DropdownField> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header ────────────────────────────────────────────────────
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.value ?? widget.hint,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: widget.value != null
                          ? Colors.black
                          : Colors.black45,
                    ),
                  ),
                ),
                Icon(
                  _open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),

        // ── Options ───────────────────────────────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: _open
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE6E6E6),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widget.items.map((item) {
                      final isSelected = item == widget.value;
                      return GestureDetector(
                        onTap: () {
                          widget.onChanged(item);
                          setState(() => _open = false);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: isSelected
                                  ? const Color(0xFF2B99E3)
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
