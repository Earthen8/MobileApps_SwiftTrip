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
}

