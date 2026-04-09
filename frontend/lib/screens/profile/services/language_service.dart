import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_model.dart';

class LanguageService {
  static const String _langKey = 'selected_language_code';

  Future<List<Language>> getLanguages() async {
    return const [
      Language(code: 'en', flag: '🇬🇧', name: 'English'),
      Language(code: 'id', flag: '🇮🇩', name: 'Indonesia'),
    ];
  }

  Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }

  Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? 'en';
  }
}

class AppStrings {
  static const Map<String, Map<String, String>> values = {
    'en': {
      'schedule': 'Your Schedule',
      'recommendation': 'Recommendation',
      'search': 'Search Destination',
    },
    'id': {
      'schedule': 'Jadwal Anda',
      'recommendation': 'Rekomendasi',
      'search': 'Cari Destinasi',
    },
  };
}
