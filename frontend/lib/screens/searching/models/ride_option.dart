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

  factory RideOption.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    IconData icon;
    
    // Assign static icons based on name (case-insensitive)
    switch (name.toLowerCase()) {
      case 'car':
        icon = Icons.directions_car_outlined;
        break;
      case 'bus':
        icon = Icons.directions_bus_outlined;
        break;
      case 'train':
        icon = Icons.train_outlined;
        break;
      case 'flight':
      case 'plane':
        icon = Icons.airplanemode_active_outlined;
        break;
      default:
        icon = Icons.directions_transit_outlined;
    }

    return RideOption(
      name: name,
      duration: json['duration'] as String,
      passengerCapacity: json['passenger_capacity'] ?? json['passengerCapacity'] ?? 0,
      priceRp: json['price_rp'] ?? json['priceRp'] ?? 0,
      icon: icon,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'duration': duration,
    'passenger_capacity': passengerCapacity,
    'price_rp': priceRp,
  };
}
