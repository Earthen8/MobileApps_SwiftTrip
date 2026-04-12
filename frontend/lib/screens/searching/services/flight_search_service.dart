import '../models/flight_leg.dart';

class FlightSearchService {
  const FlightSearchService();

  Future<bool> search({
    required List<FlightLeg> multiCityLegs,
    required String from,
    required String to,
    required String date,
    required String passengers,
    required String flightClass,
    required bool isMultiCity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return true;
  }
}
