import 'package:flutter/material.dart';

class RideOption {
  final String name;
  final String duration;
  final int passengerCapacity;
  final int priceRp;
  final IconData icon;

  const RideOption({
    required this.name,
    required this.duration,
    required this.passengerCapacity,
    required this.priceRp,
    required this.icon,
  });

  factory RideOption.fromJson(Map<String, dynamic> json) => RideOption(
        name: json['name'] as String,
        duration: json['duration'] as String,
        passengerCapacity: json['passengerCapacity'] as int,
        priceRp: json['priceRp'] as int,
        icon: IconData(
          json['iconCodePoint'] as int,
          fontFamily: 'MaterialIcons',
        ),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'duration': duration,
        'passengerCapacity': passengerCapacity,
        'priceRp': priceRp,
        'iconCodePoint': icon.codePoint,
      };
}

