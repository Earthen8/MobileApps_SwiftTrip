import 'package:swifttrip_frontend/screens/cart/models/cart_models.dart';

/// Pairs a [CartTicket] with a geographic coordinate for map display.
/// Keeps the shared CartTicket model untouched.
class VehiclePin {
  final CartTicket ticket;
  final double latitude;
  final double longitude;

  const VehiclePin({
    required this.ticket,
    required this.latitude,
    required this.longitude,
  });
}
