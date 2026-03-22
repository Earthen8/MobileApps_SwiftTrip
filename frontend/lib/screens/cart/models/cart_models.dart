import 'package:flutter/foundation.dart';

@immutable
class CartTicket {
  final String type; // 'Train Ticket' | 'Accommodation'
  final String bookingId;
  final String classLabel;
  final int priceRp;

  // Transport fields
  final String? from;
  final String? to;
  final String? date;
  final String? departure;
  final String? arrive;
  final String? train;
  final String? carriage;
  final String? seat;

  // Accommodation fields
  final String? imageUrl;
  final String? stayDate;
  final String? stayDuration;
  final String? bedType;
  final String? location;

  const CartTicket({
    required this.type,
    required this.bookingId,
    required this.classLabel,
    required this.priceRp,
    this.from,
    this.to,
    this.date,
    this.departure,
    this.arrive,
    this.train,
    this.carriage,
    this.seat,
    this.imageUrl,
    this.stayDate,
    this.stayDuration,
    this.bedType,
    this.location,
  });

  factory CartTicket.fromJson(Map<String, dynamic> json) {
    return CartTicket(
      type: json['type'] as String,
      bookingId: json['booking_id'] as String,
      classLabel: json['class_label'] as String,
      priceRp: json['price_rp'] as int,
      from: json['from'] as String?,
      to: json['to'] as String?,
      date: json['date'] as String?,
      departure: json['departure'] as String?,
      arrive: json['arrive'] as String?,
      train: json['train'] as String?,
      carriage: json['carriage'] as String?,
      seat: json['seat'] as String?,
      imageUrl: json['image_url'] as String?,
      stayDate: json['stay_date'] as String?,
      stayDuration: json['stay_duration'] as String?,
      bedType: json['bed_type'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'booking_id': bookingId,
      'class_label': classLabel,
      'price_rp': priceRp,
      'from': from,
      'to': to,
      'date': date,
      'departure': departure,
      'arrive': arrive,
      'train': train,
      'carriage': carriage,
      'seat': seat,
      'image_url': imageUrl,
      'stay_date': stayDate,
      'stay_duration': stayDuration,
      'bed_type': bedType,
      'location': location,
    };
  }

  CartTicket copyWith({
    String? type,
    String? bookingId,
    String? classLabel,
    int? priceRp,
    String? from,
    String? to,
    String? date,
    String? departure,
    String? arrive,
    String? train,
    String? carriage,
    String? seat,
    String? imageUrl,
    String? stayDate,
    String? stayDuration,
    String? bedType,
    String? location,
  }) {
    return CartTicket(
      type: type ?? this.type,
      bookingId: bookingId ?? this.bookingId,
      classLabel: classLabel ?? this.classLabel,
      priceRp: priceRp ?? this.priceRp,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      departure: departure ?? this.departure,
      arrive: arrive ?? this.arrive,
      train: train ?? this.train,
      carriage: carriage ?? this.carriage,
      seat: seat ?? this.seat,
      imageUrl: imageUrl ?? this.imageUrl,
      stayDate: stayDate ?? this.stayDate,
      stayDuration: stayDuration ?? this.stayDuration,
      bedType: bedType ?? this.bedType,
      location: location ?? this.location,
    );
  }
}
