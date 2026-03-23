class CacheService {
  Future<Map<String, double>> getCacheDetails() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'Search Cache': 103,
      'User Cache': 0,
      'Download Cache': 201,
    };
  }

  Future<void> clearAllCache() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
  }
}
