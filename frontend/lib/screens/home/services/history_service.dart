import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants.dart';
import '../../../repositories/auth_repository.dart';
import '../../cart/models/cart_models.dart';

class HistoryService {
  final _dio = Dio();
  final _authRepo = AuthRepository();

  Future<List<CartTicket>> fetchHistory() async {
    try {
      final token = await _authRepo.getToken();
      
      if (token == null) {
        debugPrint('HistoryService: No auth token found.');
        return [];
      }

      final response = await _dio.get(
        '${Constants.bookingsUrl}history/',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        debugPrint('Debug: History raw response (${data.length} items): $data');
        return data.map((json) => CartTicket.fromJson(json)).toList();
      }
      throw Exception('Failed to fetch history: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        debugPrint('500 Internal Server Error: Could not fetch history. Check backend data sync.');
        return [];
      }
      rethrow;
    } catch (e) {
      debugPrint('Error parsing history: $e');
      return [];
    }
  }
}
