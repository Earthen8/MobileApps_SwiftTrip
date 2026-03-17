import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import 'onboarding.dart';
import 'main_page.dart';
import 'cs_chat.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────────────────────

enum _TicketStatus { pending, solved, replied }

class _TicketItem {
  final String title;
  final String issuedDate;
  final String preview;
  final _TicketStatus status;
  final bool isPublic;

  const _TicketItem({
    required this.title,
    required this.issuedDate,
    required this.preview,
    required this.status,
    required this.isPublic,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────────────────────

class YourTicketPage extends StatefulWidget {
  const YourTicketPage({super.key});

  @override
  State<YourTicketPage> createState() => _YourTicketPageState();
}

class _YourTicketPageState extends State<YourTicketPage> {
  final TextEditingController _searchController = TextEditingController();

  // TODO: Replace with data fetched from backend API
  final List<_TicketItem> _tickets = const [
    _TicketItem(
      title: 'Saldo tidak terupdate',
      issuedDate: '15 Jan 2026',
      preview:
          'Saldo terakhir tidak sesuai dengan transaksi terbaru. Mohon pengecekan karena nilai tidak berubah setelah pembayaran...',
      status: _TicketStatus.pending,
      isPublic: true,
    ),

    _TicketItem(
      title: 'Gagal login aplikasi',
      issuedDate: '16 Jan 2026',
      preview:
          'Tidak bisa login meskipun username dan password sudah benar. Muncul error tidak dikenal saat mencoba masuk...',
      status: _TicketStatus.pending,
      isPublic: true,
    ),

    _TicketItem(
      title: 'Notifikasi tidak masuk',
      issuedDate: '17 Jan 2026',
      preview:
          'Aplikasi tidak mengirim notifikasi transaksi terbaru. Sudah cek pengaturan tapi tetap tidak ada pemberitahuan...',
      status: _TicketStatus.pending,
      isPublic: true,
    ),

    _TicketItem(
      title: 'Transaksi tertunda',
      issuedDate: '18 Jan 2026',
      preview:
          'Transaksi sudah dilakukan namun status masih pending lebih dari 24 jam. Mohon konfirmasi apakah berhasil atau tidak...',
      status: _TicketStatus.pending,
      isPublic: true,
    ),

    _TicketItem(
      title: 'Error saat checkout',
      issuedDate: '19 Jan 2026',
      preview:
          'Terjadi error ketika menekan tombol checkout. Halaman tidak memproses dan kembali ke halaman sebelumnya...',
      status: _TicketStatus.pending,
      isPublic: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── Top Bar ──────────────────────────────────────────────────────
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
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // ── Search Bar ─────────────────────────────────────────
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

                  // ── Section Title ──────────────────────────────────────
                  const Text(
                    'Your Tickets',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Ticket List ────────────────────────────────────────
                  // TODO: Replace _tickets with paginated backend response
                  ..._tickets.map(
                    (ticket) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TicketCard(
                        item: ticket,
                        onReadMore: () {
                          // TODO: Navigate to ticket detail page
                          // TODO: Pass ticket.id to fetch full thread
                        },
                      ),
                    ),
                  ),
                ],
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
// TICKET CARD
// ─────────────────────────────────────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  final _TicketItem item;
  final VoidCallback onReadMore;

  const _TicketCard({required this.item, required this.onReadMore});

  Color get _statusColor {
    switch (item.status) {
      case _TicketStatus.pending:
        return const Color(0xFF2B99E3);
      case _TicketStatus.solved:
        return const Color(0xFF2B99E3);
      case _TicketStatus.replied:
        return const Color(0xFF2B99E3);
    }
  }

  String get _statusLabel {
    switch (item.status) {
      case _TicketStatus.pending:
        return 'Pending';
      case _TicketStatus.solved:
        return 'Solved';
      case _TicketStatus.replied:
        return 'Replied';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 11, 18, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title Row + Status ───────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.67,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Issued: ${item.issuedDate}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 2,
                            color: Color(0xFF0C161C),
                          ),
                        ),
                        Text(
                          _statusLabel,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 2,
                            color: _statusColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Ticket is ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            height: 2.4,
                            color: Color(0xFF0C161C),
                          ),
                        ),
                        Text(
                          item.isPublic ? 'public' : 'Private',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            height: 2.4,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const Divider(color: Color(0x4D000000), thickness: 1, height: 16),

            // ── Preview Text ─────────────────────────────────────────────
            Text(
              item.preview,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.67,
                color: Color(0xFF999999),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // ── Read More ────────────────────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CsChatPage()),
                  );
                },
                child: const Text(
                  'Read more >',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 2,
                    color: Color(0xFF2B99E3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
