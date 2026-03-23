class FlightLeg {
  final String from;
  final String to;
  final String date;

  const FlightLeg({required this.from, required this.to, required this.date});

  factory FlightLeg.fromJson(Map<String, dynamic> json) => FlightLeg(
    from: json['from'] as String,
    to: json['to'] as String,
    date: json['date'] as String,
  );

  Map<String, dynamic> toJson() => {'from': from, 'to': to, 'date': date};
}
