import '../models/language_model.dart';

class LanguageService {
  Future<List<Language>> getLanguages() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      Language(flag: '🇮🇩', name: 'Indonesia'),
      Language(flag: '🇬🇧', name: 'English'),
    ];
  }
}
