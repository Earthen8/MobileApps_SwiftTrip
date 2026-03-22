import 'package:flutter/material.dart';
import 'package:swifttrip_frontend/screens/cart/models/cart_models.dart';
import 'package:swifttrip_frontend/screens/cart/widgets/ticket_card.dart';
import '../../widgets/top_bar.dart';
import '../cart/cart.dart';
import '../customer_service/onboarding.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(
              showBackButton: true,
              onHamburgerTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom:
                      40, // Reduced padding since there is no navbar blocking it
                ),
                itemCount: 3,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return TicketCard(
                    ticket: CartTicket(
                      type: 'Train Ticket',
                      bookingId: 'ID-HISTORY${index}123',
                      classLabel: 'ECONOMY CLASS',
                      from: 'Jakarta',
                      to: 'Bali',
                      date: '10/12/2025',
                      departure: '08:00',
                      arrive: '10:00',
                      train: 'Argo Bromo',
                      carriage: '3',
                      seat: '12A',
                      priceRp: 500000,
                    ),
                    formatRp: (val) => 'Rp. $val',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
