import 'package:swifttrip_frontend/models/recommendation_item.dart';
import 'package:swifttrip_frontend/models/schedule_item.dart';

class HomeService {
  Future<List<ScheduleItem>> fetchSchedules() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const [
      ScheduleItem(
        title: 'Jakarta - Bandung',
        time: '14 Jan 2026',
        imageAsset: 'assets/images/home/vacation_logo.png',
      ),
      ScheduleItem(
        title: 'Surabaya - Malang',
        time: '15 Jan 2026',
        imageAsset: 'assets/images/home/vacation_logo.png',
      ),
    ];
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
