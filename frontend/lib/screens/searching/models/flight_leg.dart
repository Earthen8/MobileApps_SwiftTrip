class FlightLeg {
  final String originLocationCode;
  final String destinationLocationCode;
  final String originLabel;
  final String destinationLabel;
  final String departureDate;

  const FlightLeg({
    required this.originLocationCode,
    required this.destinationLocationCode,
    required this.originLabel,
    required this.destinationLabel,
    required this.departureDate,
  });

  factory FlightLeg.fromJson(Map<String, dynamic> json) => FlightLeg(
        originLocationCode: json['originLocationCode'] as String,
        destinationLocationCode: json['destinationLocationCode'] as String,
        originLabel: json['originLabel'] as String? ?? json['originLocationCode'] as String,
        destinationLabel: json['destinationLabel'] as String? ?? json['destinationLocationCode'] as String,
        departureDate: json['departureDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        'originLocationCode': originLocationCode,
        'destinationLocationCode': destinationLocationCode,
        'originLabel': originLabel,
        'destinationLabel': destinationLabel,
        'departureDate': departureDate,
      };
}
