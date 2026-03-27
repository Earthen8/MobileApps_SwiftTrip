class AirportResult {
  final String iataCode;
  final String name;
  final String cityName;
  final String countryCode;

  const AirportResult({
    required this.iataCode,
    required this.name,
    required this.cityName,
    required this.countryCode,
  });

  factory AirportResult.fromJson(Map<String, dynamic> json) => AirportResult(
        iataCode: json['iataCode'] as String,
        name: json['name'] as String,
        cityName: json['cityName'] as String,
        countryCode: json['countryCode'] as String,
      );

  String get displayLabel => '$cityName ($iataCode)';
}
