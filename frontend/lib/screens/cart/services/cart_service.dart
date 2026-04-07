import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants.dart';
import '../../../repositories/auth_repository.dart';
import '../models/cart_models.dart';
import '../models/promotion_models.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartTicket> _tickets = [];

  Future<void> addTicket(CartTicket ticket) async {
    try {
      final dio = Dio();
      final token = await AuthRepository().getToken();
      
      print('Debug: 3. Service attempting POST to ${Constants.bookingsUrl}cart/add/');
      
      final String bookingType = _mapTicketTypeToBookingType(ticket.type);
      
      final response = await dio.post(
        '${Constants.bookingsUrl}cart/add/',
        data: {
          'booking_type': bookingType,
          'price_rp': ticket.priceRp,
          'from': ticket.from,
          'to': ticket.to,
          'date': ticket.date,
          'departure': ticket.departure,
          'arrive': ticket.arrive,
          'train': ticket.trainNumber, // backend uses 'train' key for 'train_number'
          'carriage': ticket.carriage,
          'seat': ticket.seat,
          'class_label': ticket.classLabel,
          'operator': ticket.operator,
          'flight_number': ticket.flightNumber,
          'terminal': ticket.terminal,
          'flight_class': ticket.flightClass,
          'bus_class': ticket.busClass,
          'bus_number': ticket.busNumber,
          'car_plate': ticket.carPlate,
          'driver_name': ticket.driverName,
          'flight_route': ticket.flightRoute,
          'image_url': ticket.imageUrl,
          'stay_date': ticket.stayDate,
          'stay_duration': ticket.stayDuration,
          'bed_type': ticket.bedType,
          'location': ticket.location,
        },
        options: Options(headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201) {
        print('Debug: POST successful. Server message: ${response.data}');
      } else {
        print('Debug: POST returned unexpected status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Debug: CRITICAL ERROR in CartService: $e');
      if (e.response != null) {
        print('Debug: Server response data: ${e.response?.data}');
      }
    } catch (e) {
      print('Debug: CRITICAL ERROR in CartService: $e');
    }
  }

  String _mapTicketTypeToBookingType(String ticketType) {
    switch (ticketType) {
      case 'Plane Ticket':
        return 'PLANE_TICKET';
      case 'Train Ticket':
        return 'TRAIN_TICKET';
      case 'Bus Ticket':
        return 'BUS_TICKET';
      case 'Car Ticket':
        return 'CAR_TICKET';
      case 'Accommodation Ticket':
        return 'ACCOMMODATION';
      default:
        return 'TRAIN_TICKET';
    }
  }

  void removeTicket(int index) {
    if (index >= 0 && index < _tickets.length) {
      _tickets.removeAt(index);
    }
  }

  void clearLocalCart() {
    _tickets.clear();
  }

  Future<List<CartTicket>> fetchTickets() async {
    return List.from(_tickets);
  }

  Future<List<Promotion>> fetchPromotions() async {
    try {
      final dio = Dio();
      final response = await dio.get(Constants.promotionsUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Promotion.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching promotions: $e');
      return [];
    }
  }

  int calculateDiscount(int baseTotal, Promotion? promo) {
    if (promo == null) return 0;

    if (baseTotal < promo.minPurchase) return 0;

    if (promo.promotionType == 'PERCENTAGE') {
      return (baseTotal * (promo.discountValue / 100)).toInt();
    } else if (promo.promotionType == 'CASHBACK') {
      return promo.discountValue.toInt();
    }
    
    return 0;
  }
}
