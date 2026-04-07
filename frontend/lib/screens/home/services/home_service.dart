import 'package:dio/dio.dart';
import '../../../core/constants.dart';
import '../../../repositories/auth_repository.dart';
import '../../cart/models/cart_models.dart';
import 'package:swifttrip_frontend/models/recommendation_item.dart';

class HomeService {
  Future<List<CartTicket>> fetchSchedules() async {
    try {
      final dio = Dio();
      final token = await AuthRepository().getToken();
      
      final response = await dio.get(
        Constants.historyUrl,
        options: Options(headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CartTicket.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Debug: Home Schedule Fetch Error: $e');
      return [];
    }
  }

  Future<List<RecommendationItem>> fetchRecommendations() async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      return const [
        RecommendationItem(
          name: 'The Langham',
          description: 'Jakarta',
          imageAsset: 'assets/images/home/vacation_logo.png',
        ),
        RecommendationItem(
          name: 'The Ritz-Carlton',
          description: 'Bali',
          imageAsset: 'assets/images/home/vacation_logo.png',
        ),
        RecommendationItem(
          name: 'Hotel Tentrem',
          description: 'Yogyakarta',
          imageAsset: 'assets/images/home/vacation_logo.png',
        ),
        RecommendationItem(
          name: 'Padma Hotel',
          description: 'Bandung',
          imageAsset: 'assets/images/home/vacation_logo.png',
        ),
      ];
    } catch (e) {
      print('Debug: Recommendation Fetch Error: $e');
      return [];
    }
  }
}
