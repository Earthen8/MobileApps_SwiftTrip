import 'package:flutter/material.dart';
import '../models/ride_option.dart';
import '../models/detail_row.dart';
import '../models/coupon_model.dart';
import '../models/flight_leg.dart';

class SearchingService {
  const SearchingService();

  // ── Land Vehicle ───────────────────────────────────────────────────────────

  /// Fetches available ride options for land vehicles.
  Future<List<RideOption>> getRideOptions() async {
    // TODO: Replace with real API call (e.g. Dio.get('/land-vehicles/options'))
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      RideOption(
        name: 'Car',
        duration: '2 hrs',
        passengerCapacity: 4,
        priceRp: 50000,
        icon: Icons.directions_car_outlined,
      ),
      RideOption(
        name: 'Bus',
        duration: '3 hrs',
        passengerCapacity: 0,
        priceRp: 50000,
        icon: Icons.directions_bus_outlined,
      ),
      RideOption(
        name: 'Train',
        duration: '4 hrs',
        passengerCapacity: 0,
        priceRp: 75000,
        icon: Icons.train_outlined,
      ),
    ];
  }

  /// Fetches default purchase details for land vehicles.
  Future<List<DetailRow>> getPurchaseDetails() async {
    // TODO: Replace with real API call
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      DetailRow(label: 'Tiket Kereta', amount: 'Rp 14.000.000'),
      DetailRow(label: 'Voucher', amount: '-Rp 300.000'),
      DetailRow(label: 'Diskon liburan', amount: '-Rp 1.800.000'),
      DetailRow(label: 'PPN 10%', amount: 'Rp 110.700'),
    ];
  }

  // ── Coupons ───────────────────────────────────────────────────────────────

  /// Fetches available coupon categories.
  Future<List<String>> getCouponCategories() async {
    // TODO: Fetch from backend
    await Future.delayed(const Duration(milliseconds: 200));
    return ['Coupon Raya', 'Coupon Ticket Plane', 'Australia', 'Indonesia'];
  }

  /// Fetches coupons filtered by category.
  Future<List<CouponModel>> getCouponsByCategory(String category) async {
    // TODO: Replace with backend API
    await Future.delayed(const Duration(milliseconds: 400));

    final Map<String, List<CouponModel>> mockData = {
      'Coupon Raya': [
        const CouponModel(
          title: 'Raya Special',
          description: 'Get 10% off this Raya',
          code: 'RAYA10',
        ),
        const CouponModel(
          title: 'Raya Extra',
          description: 'Get 15% off this Raya',
          code: 'RAYA15',
        ),
      ],
      'Coupon Ticket Plane': [
        const CouponModel(
          title: 'Plane Saver',
          description: 'Get 20% off flights',
          code: 'PLANE20',
        ),
        const CouponModel(
          title: 'Fly More',
          description: 'Get 25% off flights',
          code: 'FLY25',
        ),
      ],
      'Australia': [
        const CouponModel(
          title: 'AUS Deal',
          description: 'Get 30% off to Australia',
          code: 'AUS30',
        ),
      ],
      'Indonesia': [
        const CouponModel(
          title: 'IDN Deal',
          description: 'Get 5% off domestic',
          code: 'IDN05',
        ),
      ],
    };

    return mockData[category] ?? [];
  }

  // ── Flights ────────────────────────────────────────────────────────────────

  /// Searches for flights based on Amadeus API parameters.
  Future<bool> searchFlights({
    required List<FlightLeg> multiCityLegs,
    required String from, // originLocationCode (IATA)
    required String to, // destinationLocationCode (IATA)
    required String date, // departureDate (YYYY-MM-DD)
    required String passengers, // total adults
    required String flightClass, // ECONOMY, etc.
    required bool isMultiCity,
  }) async {
    // ── Prepare Amadeus Payload ──────────────────────────────────────────────
    
    // ignore: unused_local_variable
    final Map<String, dynamic> payload;
    
    if (isMultiCity) {
      payload = {
        'currencyCode': 'IDR',
        'originDestinations': multiCityLegs.asMap().entries.map((entry) {
          final i = entry.key;
          final leg = entry.value;
          return {
            'id': (i + 1).toString(),
            'originLocationCode': leg.originLocationCode,
            'destinationLocationCode': leg.destinationLocationCode,
            'departureDateTimeRange': {
              'date': leg.departureDate,
            },
          };
        }).toList(),
        'travelers': List.generate(int.parse(passengers), (i) => {
          'id': (i + 1).toString(),
          'travelerType': 'ADULT',
        }),
        'sources': ['GDS'],
        'searchCriteria': {
          'maxFlightOffers': 2,
          'flightFilters': {
            'cabinRestrictions': [
              {
                'cabin': flightClass,
                'originDestinationIds': multiCityLegs.asMap().keys.map((k) => (k+1).toString()).toList(),
              }
            ]
          }
        }
      };
    } else {
      payload = {
        'originLocationCode': from,
        'destinationLocationCode': to,
        'departureDate': date,
        'adults': passengers,
        'travelClass': flightClass,
        'max': 2,
      };
    }

    // Log the payload to verify Amadeus mapping
    debugPrint('Searching flights with payload: $payload');

    // TODO: POST to backend API (e.g., Dio.post('/api/flights/search', data: payload))
    await Future.delayed(const Duration(seconds: 1));

    // Mock logic for demonstration
    if (isMultiCity) {
      return multiCityLegs.any(
        (leg) => leg.originLocationCode == 'CGK' || leg.destinationLocationCode == 'CGK',
      );
    }
    return from == 'CGK' || to == 'CGK';
  }
}
