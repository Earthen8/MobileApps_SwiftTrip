import '../models/airport_model.dart';

class AirportSearchService {
  static const List<Map<String, String>> commonAirports = [
    // --- INDONESIA (Core Hubs) ---
    {
      'iataCode': 'CGK',
      'name': 'Soekarno-Hatta International Airport',
      'cityName': 'Jakarta',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'DPS',
      'name': 'Ngurah Rai International Airport',
      'cityName': 'Denpasar',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'SUB',
      'name': 'Juanda International Airport',
      'cityName': 'Surabaya',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'KNO',
      'name': 'Kualanamu International Airport',
      'cityName': 'Medan',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'UPG',
      'name': 'Sultan Hasanuddin International Airport',
      'cityName': 'Makassar',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'YIA',
      'name': 'Yogyakarta International Airport',
      'cityName': 'Yogyakarta',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'BPN',
      'name': 'Sultan Aji Muhammad Sulaiman Sepinggan Airport',
      'cityName': 'Balikpapan',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'BTH',
      'name': 'Hang Nadim International Airport',
      'cityName': 'Batam',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'SRG',
      'name': 'Ahmad Yani International Airport',
      'cityName': 'Semarang',
      'countryCode': 'ID',
    },
    {
      'iataCode': 'PLM',
      'name': 'Sultan Mahmud Badaruddin II Airport',
      'cityName': 'Palembang',
      'countryCode': 'ID',
    },

    // --- ASIA (Regional Favorites) ---
    {
      'iataCode': 'SIN',
      'name': 'Changi Airport',
      'cityName': 'Singapore',
      'countryCode': 'SG',
    },
    {
      'iataCode': 'KUL',
      'name': 'Kuala Lumpur International Airport',
      'cityName': 'Kuala Lumpur',
      'countryCode': 'MY',
    },
    {
      'iataCode': 'BKK',
      'name': 'Suvarnabhumi Airport',
      'cityName': 'Bangkok',
      'countryCode': 'TH',
    },
    {
      'iataCode': 'HND',
      'name': 'Haneda Airport',
      'cityName': 'Tokyo',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'NRT',
      'name': 'Narita International Airport',
      'cityName': 'Tokyo',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'ICN',
      'name': 'Incheon International Airport',
      'cityName': 'Seoul',
      'countryCode': 'KR',
    },
    {
      'iataCode': 'HKG',
      'name': 'Hong Kong International Airport',
      'cityName': 'Hong Kong',
      'countryCode': 'HK',
    },
    {
      'iataCode': 'TPE',
      'name': 'Taoyuan International Airport',
      'cityName': 'Taipei',
      'countryCode': 'TW',
    },
    {
      'iataCode': 'MNL',
      'name': 'Ninoy Aquino International Airport',
      'cityName': 'Manila',
      'countryCode': 'PH',
    },
    {
      'iataCode': 'SGN',
      'name': 'Tan Son Nhat International Airport',
      'cityName': 'Ho Chi Minh City',
      'countryCode': 'VN',
    },
    {
      'iataCode': 'KIX',
      'name': 'Kansai International Airport',
      'cityName': 'Osaka',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'PVG',
      'name': 'Pudong International Airport',
      'cityName': 'Shanghai',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'PEK',
      'name': 'Beijing Capital International Airport',
      'cityName': 'Beijing',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'BOM',
      'name': 'Chhatrapati Shivaji Maharaj Intl Airport',
      'cityName': 'Mumbai',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'DEL',
      'name': 'Indira Gandhi International Airport',
      'cityName': 'Delhi',
      'countryCode': 'IN',
    },

    // --- AUSTRALIA & OCEANIA (Study Destinations) ---
    {
      'iataCode': 'SYD',
      'name': 'Kingsford Smith Airport',
      'cityName': 'Sydney',
      'countryCode': 'AU',
    },
    {
      'iataCode': 'MEL',
      'name': 'Melbourne Airport',
      'cityName': 'Melbourne',
      'countryCode': 'AU',
    },
    {
      'iataCode': 'PER',
      'name': 'Perth Airport',
      'cityName': 'Perth',
      'countryCode': 'AU',
    },
    {
      'iataCode': 'BNE',
      'name': 'Brisbane Airport',
      'cityName': 'Brisbane',
      'countryCode': 'AU',
    },
    {
      'iataCode': 'ADL',
      'name': 'Adelaide Airport',
      'cityName': 'Adelaide',
      'countryCode': 'AU',
    },
    {
      'iataCode': 'AKL',
      'name': 'Auckland Airport',
      'cityName': 'Auckland',
      'countryCode': 'NZ',
    },
    {
      'iataCode': 'CHC',
      'name': 'Christchurch International Airport',
      'cityName': 'Christchurch',
      'countryCode': 'NZ',
    },

    // --- MIDDLE EAST & EUROPE ---
    {
      'iataCode': 'DXB',
      'name': 'Dubai International Airport',
      'cityName': 'Dubai',
      'countryCode': 'AE',
    },
    {
      'iataCode': 'DOH',
      'name': 'Hamad International Airport',
      'cityName': 'Doha',
      'countryCode': 'QA',
    },
    {
      'iataCode': 'IST',
      'name': 'Istanbul Airport',
      'cityName': 'Istanbul',
      'countryCode': 'TR',
    },
    {
      'iataCode': 'LHR',
      'name': 'Heathrow Airport',
      'cityName': 'London',
      'countryCode': 'GB',
    },
    {
      'iataCode': 'CDG',
      'name': 'Charles de Gaulle Airport',
      'cityName': 'Paris',
      'countryCode': 'FR',
    },
    {
      'iataCode': 'AMS',
      'name': 'Schiphol Airport',
      'cityName': 'Amsterdam',
      'countryCode': 'NL',
    },
    {
      'iataCode': 'FRA',
      'name': 'Frankfurt Airport',
      'cityName': 'Frankfurt',
      'countryCode': 'DE',
    },
    {
      'iataCode': 'ZRH',
      'name': 'Zurich Airport',
      'cityName': 'Zurich',
      'countryCode': 'CH',
    },
    {
      'iataCode': 'FCO',
      'name': 'Leonardo da Vinci–Fiumicino Airport',
      'cityName': 'Rome',
      'countryCode': 'IT',
    },
    {
      'iataCode': 'MAD',
      'name': 'Adolfo Suárez Madrid–Barajas Airport',
      'cityName': 'Madrid',
      'countryCode': 'ES',
    },

    // --- AMERICAS & AFRICA ---
    {
      'iataCode': 'JFK',
      'name': 'John F. Kennedy International Airport',
      'cityName': 'New York',
      'countryCode': 'US',
    },
    {
      'iataCode': 'LAX',
      'name': 'Los Angeles International Airport',
      'cityName': 'Los Angeles',
      'countryCode': 'US',
    },
    {
      'iataCode': 'SFO',
      'name': 'San Francisco International Airport',
      'cityName': 'San Francisco',
      'countryCode': 'US',
    },
    {
      'iataCode': 'YYZ',
      'name': 'Toronto Pearson International Airport',
      'cityName': 'Toronto',
      'countryCode': 'CA',
    },
    {
      'iataCode': 'GRU',
      'name': 'Guarulhos–Governador André Franco Montoro Intl',
      'cityName': 'Sao Paulo',
      'countryCode': 'BR',
    },
    {
      'iataCode': 'JNB',
      'name': 'O. R. Tambo International Airport',
      'cityName': 'Johannesburg',
      'countryCode': 'ZA',
    },
    {
      'iataCode': 'CAI',
      'name': 'Cairo International Airport',
      'cityName': 'Cairo',
      'countryCode': 'EG',
    },
    {
      'iataCode': 'MEX',
      'name': 'Mexico City International Airport',
      'cityName': 'Mexico City',
      'countryCode': 'MX',
    },
  ];

  Future<List<AirportResult>> searchAirports(String query) async {
    if (query.trim().isEmpty) return [];

    final lowerQuery = query.trim().toLowerCase();

    final filtered = commonAirports.where((airport) {
      final cityName = (airport['cityName'] ?? '').toLowerCase();
      final iataCode = (airport['iataCode'] ?? '').toLowerCase();

      return cityName.contains(lowerQuery) || iataCode.contains(lowerQuery);
    }).toList();

    return filtered
        .map(
          (e) => AirportResult(
            iataCode: e['iataCode'] ?? '',
            name: e['name'] ?? '',
            cityName: e['cityName'] ?? '',
            countryCode: e['countryCode'] ?? '',
          ),
        )
        .toList();
  }
}
