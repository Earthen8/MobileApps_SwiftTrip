import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants.dart';
import '../../cart/models/cart_models.dart';

class HistoryService {
  final _dio = Dio();

  Future<List<CartTicket>> fetchHistory() async {
    try {
      // In a real app, we'd pass auth tokens here
      final response = await _dio.get('${Constants.bookingsUrl}history/');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CartTicket.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching history: $e');
      return [];
    }
  }
}
