import '../models/cart_models.dart';
import '../models/promotion_models.dart';

class CartService {
  // Mock data fetching, could be replaced with Dio/http later
  Future<List<CartTicket>> fetchTickets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const CartTicket(
        type: 'Train Ticket',
        bookingId: 'ID-1231KADASMASDKAASD',
        classLabel: 'ECONOMY CLASS',
        from: 'Jakarta',
        to: 'Ngawi Barat',
        date: '19/2/2026',
        departure: '9:00',
        arrive: '11:00',
        train: '1234',
        carriage: '01',
        seat: 'A12',
        priceRp: 100000,
      ),
      const CartTicket(
        type: 'Accommodation',
        bookingId: 'ID-1231KADASMASDKAASD',
        classLabel: 'Hotel Santika Bandung',
        priceRp: 100000,
        stayDate: '19/2/2026',
        stayDuration: '1 Day 1 Night',
        bedType: '2 Queen Sized Bed',
        location: 'Hotel Santika Jln indonesia americano no.213 poetry 123194',
        imageUrl: null,
      ),
      const CartTicket(
        type: 'Train Ticket',
        bookingId: 'ID-7HSG2JSK8291',
        classLabel: 'BUSINESS CLASS',
        from: 'Bandung',
        to: 'Yogyakarta',
        date: '20/2/2026',
        departure: '08:30',
        arrive: '12:10',
        train: '3345',
        carriage: '03',
        seat: 'A4',
        priceRp: 350000,
      ),
    ];
  }

  Future<List<Promotion>> fetchPromotions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      Promotion(
        id: 'promo_1',
        title: 'Family Discount',
        dateRange: '12 Feb 2024 - 12 Mar 2025',
        description: 'Discount 10% with minimum Rp 1.000.000 purchases',
      ),
      Promotion(
        id: 'promo_2',
        title: 'Student Getaway',
        dateRange: '01 Jan 2024 - 31 Dec 2024',
        description: 'Discount 15% with valid student ID card',
      ),
      Promotion(
        id: 'promo_3',
        title: 'Weekend Flash Sale',
        dateRange: 'Every Saturday - Sunday',
        description: 'Cashback Rp 50.000 with no minimum purchase',
      ),
    ];
  }

  int calculateDiscount(List<CartTicket> tickets, Promotion? promo) {
    if (promo == null) return 0;
    final baseTotal = tickets.fold(0, (sum, t) => sum + t.priceRp);

    if (promo.id == 'promo_1' && baseTotal >= 1000000) {
      return (baseTotal * 0.10).toInt();
    }
    if (promo.id == 'promo_2') {
      return (baseTotal * 0.15).toInt();
    }
    if (promo.id == 'promo_3') {
      return 50000;
    }
    return 0;
  }
}
