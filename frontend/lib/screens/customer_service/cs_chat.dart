import 'package:flutter/material.dart';
import '../../widgets/top_bar.dart';
import 'onboarding.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────────────────────────────────────

class _Question {
  final String username;
  final String subtitle;
  final String body;

  const _Question({
    required this.username,
    required this.subtitle,
    required this.body,
  });
}

class _FeedbackEntry {
  final String username;
  final String date;
  final String body;
  final bool isAnswered;

  const _FeedbackEntry({
    required this.username,
    required this.date,
    required this.body,
    this.isAnswered = false,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────────────────────

class CsChatPage extends StatefulWidget {
  const CsChatPage({super.key});

  @override
  State<CsChatPage> createState() => _CsChatPageState();
}

class _CsChatPageState extends State<CsChatPage> {
  final TextEditingController _replyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO: Replace with data fetched from backend API using ticket ID
  final _Question _question = const _Question(
    username: 'Anonymous_121',
    subtitle: '12 des 2025 Refund request',
    body: 'How to get refund after accidentally press confirm?',
  );

  // TODO: Replace with paginated feedback thread from backend
  final List<_FeedbackEntry> _feedbacks = const [
    _FeedbackEntry(
      username: 'IT Team CS',
      date: '14 jan 2026',
      body:
          'Saldo yang tidak terupdate biasanya disebabkan oleh proses pembayaran yang masih dalam tahap verifikasi, keterlambatan dari pihak bank atau metode pembayaran yang digunakan, atau transaksi yang belum berhasil sepenuhnya. Silakan cek kembali status transaksi di riwayat pesanan Anda dan pastikan pembayaran sudah berhasil. Jika saldo belum juga masuk setelah beberapa waktu, kemungkinan ada kendala teknis atau sistem, sehingga disarankan untuk menghubungi layanan pelanggan dengan menyertakan bukti pembayaran agar dapat ditindaklanjuti lebih lanjut.',
      isAnswered: true,
    ),
    _FeedbackEntry(
      username: 'Anonymous_121',
      date: '15 jan 2026',
      body: 'Thank you',
    ),
  ];

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSendReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;
    // TODO: POST reply to backend with ticket ID and reply text
    // TODO: Append new _FeedbackEntry to _feedbacks on success
    _replyController.clear();
    debugPrint('Reply sent: $text');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── Top Bar ────────────────────────────────────────────────────
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

          // ── Scrollable Content ─────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // ── Original Question Card ───────────────────────────
                  _QuestionCard(question: _question),

                  const SizedBox(height: 16),
                  const Divider(color: Color(0x4D000000), thickness: 1),
                  const SizedBox(height: 8),

                  // ── Feedback Section Title ───────────────────────────
                  const Text(
                    'Feedback:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 2.19,
                      color: Color(0xFF2B99E3),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Feedback Thread ──────────────────────────────────
                  ..._feedbacks.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _FeedbackCard(entry: entry),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Reply Input Bar ────────────────────────────────────────────
          _ReplyBar(controller: _replyController, onSend: _handleSendReply),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QUESTION CARD
// ─────────────────────────────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  final _Question question;

  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserRow(username: question.username),
          const SizedBox(height: 4),
          Text(
            question.subtitle,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              height: 2,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            question.body,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.67,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FEEDBACK CARD
// ─────────────────────────────────────────────────────────────────────────────

class _FeedbackCard extends StatelessWidget {
  final _FeedbackEntry entry;

  const _FeedbackCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _UserRow(username: entry.username)),
              if (entry.isAnswered)
                const Text(
                  'Answered',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF2B99E3),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            entry.date,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              height: 2,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            entry.body,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.67,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED USER ROW  (avatar circle + username)
// ─────────────────────────────────────────────────────────────────────────────

class _UserRow extends StatelessWidget {
  final String username;

  const _UserRow({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 33.52,
          height: 33.52,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: OvalBorder(),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_outline,
            size: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          username,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.67,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REPLY INPUT BAR
// ─────────────────────────────────────────────────────────────────────────────

class _ReplyBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _ReplyBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                onSubmitted: (_) => onSend(),
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Reply This Questions',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: onSend,
              child: const Icon(
                Icons.arrow_upward,
                size: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
