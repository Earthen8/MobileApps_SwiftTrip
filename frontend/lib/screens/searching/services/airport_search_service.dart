import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/airport_model.dart';

class AirportSearchService {
  static const String _baseUrl = 'http://localhost:8000/api/travel';

  Future<List<AirportResult>> searchAirports(String query) async {
    if (query.trim().length < 2) return [];

    final uri = Uri.parse('$_baseUrl/search/airports/').replace(
      queryParameters: {'q': query.trim()},
    );

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final results = body['results'] as List<dynamic>;
        return results
            .map((e) => AirportResult.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }
}
