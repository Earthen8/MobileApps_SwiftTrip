class FlightOffer {
  final String airlineCode;
  final String airlineName;
  final List<String> allAirlines;
  final String origin;
  final String destination;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final String currency;
  final double? latitude;
  final double? longitude;

  const FlightOffer({
    required this.airlineCode,
    required this.airlineName,
    required this.allAirlines,
    required this.origin,
    required this.destination,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.currency,
    this.latitude,
    this.longitude,
  });

  factory FlightOffer.fromJson(Map<String, dynamic> json) {
    return FlightOffer(
      airlineCode: json['airline']?.toString() ?? '',
      airlineName: json['airlineName']?.toString() ?? json['airline']?.toString() ?? 'Unknown',
      allAirlines: (json['all_airlines'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      origin: json['origin']?.toString() ?? '',
      destination: json['destination']?.toString() ?? '',
      flightNumber: json['flight_number']?.toString() ?? '-',
      departureTime: json['departure_time']?.toString() ?? '',
      arrivalTime: json['arrival_time']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? 'IDR',
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
    );
  }
}
