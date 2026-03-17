import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/top_bar.dart';
import 'onboarding.dart';
import 'main_page.dart';
import 'your_ticket.dart';

class AddRequestPage extends StatefulWidget {
  const AddRequestPage({super.key});

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _notifController;
  late Animation<Offset> _notifSlide;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _statementController = TextEditingController();

  String? _selectedProblemType;
  String? _selectedLocation;
  String? _selectedPublishType;
  String? _uploadedFileName;

  // TODO: Fetch these options from backend
  final List<String> _problemTypes = [
    'Bugs',
    'Text Error',
    'Button Malfunctions',
    'Design Error',
    'Others',
  ];
  final List<String> _locations = [
    'Home',
    'Chat AI',
    'Keranjang',
    'Pembayaran',
    'Others',
  ];
  final List<String> _publishTypes = ['Public', 'Private'];

  @override
  void initState() {
    super.initState();
    _notifController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _notifSlide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _notifController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _notifController.dispose();
    _searchController.dispose();
    _headerController.dispose();
    _statementController.dispose();
    super.dispose();
  }

  Future<void> _handleImportFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() => _uploadedFileName = image.name);
      // TODO: Actually upload the file to your backend here
    }
  }

  void _handleSendRequest() {
    // TODO: Validate all fields before submitting
    // TODO: POST request body to backend
    _showNotificationThenNavigate();
  }

  Future<void> _showNotificationThenNavigate() async {
    await _notifController.forward();
    await Future.delayed(const Duration(seconds: 2));
    await _notifController.reverse();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CustomerServicePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              TopBar(
                showBackButton: true,
                showHamburger: true,
                onHamburgerTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OnboardingPage()),
                  );
                },
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // ── Search Bar ─────────────────────────────────────────────
                      _SearchBar(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CustomerServicePage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // ── Section Title Row ──────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'State Your Problems',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            // TODO: Navigate to user's ticket page
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const YourTicketPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Your Ticket >',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF2B99E3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Dropdowns ──────────────────────────────────────────────
                      _DropdownField(
                        hint: 'Problem Type?',
                        value: _selectedProblemType,
                        items: _problemTypes,
                        onChanged: (val) =>
                            setState(() => _selectedProblemType = val),
                      ),
                      const SizedBox(height: 10),
                      _DropdownField(
                        hint: 'Where Is It Located?',
                        value: _selectedLocation,
                        items: _locations,
                        onChanged: (val) =>
                            setState(() => _selectedLocation = val),
                      ),
                      const SizedBox(height: 10),
                      _DropdownField(
                        hint: 'Publish Type?',
                        value: _selectedPublishType,
                        items: _publishTypes,
                        onChanged: (val) =>
                            setState(() => _selectedPublishType = val),
                      ),

                      const SizedBox(height: 15),
                      const Divider(color: Color(0x4D000000), thickness: 1),

                      // ── Header Field ───────────────────────────────────────────
                      const _SectionLabel(text: 'Header'),
                      const SizedBox(height: 8),
                      _InputField(
                        controller: _headerController,
                        hint: 'Type Here',
                        minLines: 1,
                        maxLines: 1,
                        height: 40,
                      ),
                      const SizedBox(height: 16),

                      // ── Main Statements Field ──────────────────────────────────
                      const _SectionLabel(text: 'Main Statements'),
                      const SizedBox(height: 8),
                      _InputField(
                        controller: _statementController,
                        hint: 'Type Here',
                        minLines: 5,
                        maxLines: 8,
                        height: 142,
                      ),
                      const SizedBox(height: 16),

                      // ── Upload Evidence ────────────────────────────────────────
                      const _SectionLabel(text: 'Upload Evidence'),
                      const SizedBox(height: 8),
                      _UploadField(
                        fileName: _uploadedFileName,
                        onImport: _handleImportFile,
                      ),
                      const SizedBox(height: 32),

                      // ── Send Request Button ────────────────────────────────────
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _handleSendRequest,
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2B99E3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Sent Request',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFFF7F9F9),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 50,
            right: 30,
            child: IgnorePointer(
              child: SlideTransition(
                position: _notifSlide,
                child: Container(
                  width: 208,
                  height: 57,
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Request Sent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.string(
                        '''<svg width="124" height="124" viewBox="0 0 124 124" fill="none" xmlns="http://www.w3.org/2000/svg">
<g filter="url(#filter0_d_482_1238)">
<path fill-rule="evenodd" clip-rule="evenodd" d="M61.75 115.5C69.3338 115.5 76.8434 114.006 83.85 111.104C90.8565 108.202 97.2228 103.948 102.585 98.5854C107.948 93.2228 112.202 86.8565 115.104 79.85C118.006 72.8434 119.5 65.3338 119.5 57.75C119.5 50.1662 118.006 42.6566 115.104 35.65C112.202 28.6435 107.948 22.2772 102.585 16.9146C97.2228 11.552 90.8565 7.29817 83.85 4.39596C76.8434 1.49375 69.3338 -1.13008e-07 61.75 0C46.4337 2.2823e-07 31.7448 6.08436 20.9146 16.9146C10.0844 27.7448 4 42.4337 4 57.75C4 73.0663 10.0844 87.7552 20.9146 98.5854C31.7448 109.416 46.4337 115.5 61.75 115.5ZM60.2613 81.1067L92.3447 42.6067L82.4887 34.3933L54.897 67.4969L40.6199 53.2134L31.5468 62.2866L50.7967 81.5366L55.7633 86.5031L60.2613 81.1067Z" fill="#02C518"/>
</g>
<defs>
<filter id="filter0_d_482_1238" x="0" y="0" width="123.5" height="123.5" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4"/>
<feGaussianBlur stdDeviation="2"/>
<feComposite in2="hardAlpha" operator="out"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_482_1238"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_482_1238" result="shape"/>
</filter>
</defs>
</svg>
''',
                        width: 40,
                        height: 40,
                      ),
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
// SEARCH BAR
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onTap;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
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
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                readOnly: true,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Let Us Help Answering Your Question',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const Icon(Icons.search, size: 20, color: Colors.black54),
          ],
        ),
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
        // ── Header (always visible) ───────────────────────────────────────
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
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.67,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  _open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 22,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),

        // ── Dropdown Body ─────────────────────────────────────────────────
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            vertical: 10,
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.67,
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

// ─────────────────────────────────────────────────────────────────────────────
// SECTION LABEL
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 2.19,
        color: Color(0xFFA0A0A0),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INPUT FIELD  (single-line for Header, multi-line for Main Statements)
// ─────────────────────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int minLines;
  final int maxLines;
  final double height;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.minLines,
    required this.maxLines,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFF6F6F6)),
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
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        minLines: minLines,
        maxLines: maxLines,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.2,
            color: Color(0xFFA0A0A0),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// UPLOAD EVIDENCE FIELD
// ─────────────────────────────────────────────────────────────────────────────

class _UploadField extends StatelessWidget {
  final String? fileName;
  final VoidCallback onImport;

  const _UploadField({required this.fileName, required this.onImport});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImport,
      child: Container(
        width: double.infinity,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          color: const Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fileName ?? 'Upload File Here',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 2,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Import file',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                  height: 3,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
