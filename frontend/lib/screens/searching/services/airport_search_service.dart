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

    // --- ASIA ---
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
      'iataCode': 'DMK',
      'name': 'Don Mueang International Airport',
      'cityName': 'Bangkok',
      'countryCode': 'TH',
    },
    {
      'iataCode': 'HKT',
      'name': 'Phuket International Airport',
      'cityName': 'Phuket',
      'countryCode': 'TH',
    },
    {
      'iataCode': 'CNX',
      'name': 'Chiang Mai International Airport',
      'cityName': 'Chiang Mai',
      'countryCode': 'TH',
    },
    {
      'iataCode': 'MNL',
      'name': 'Ninoy Aquino International Airport',
      'cityName': 'Manila',
      'countryCode': 'PH',
    },
    {
      'iataCode': 'CEB',
      'name': 'Mactan-Cebu International Airport',
      'cityName': 'Cebu',
      'countryCode': 'PH',
    },
    {
      'iataCode': 'SGN',
      'name': 'Tan Son Nhat International Airport',
      'cityName': 'Ho Chi Minh City',
      'countryCode': 'VN',
    },
    {
      'iataCode': 'HAN',
      'name': 'Noi Bai International Airport',
      'cityName': 'Hanoi',
      'countryCode': 'VN',
    },
    {
      'iataCode': 'DAD',
      'name': 'Da Nang International Airport',
      'cityName': 'Da Nang',
      'countryCode': 'VN',
    },
    {
      'iataCode': 'RGN',
      'name': 'Yangon International Airport',
      'cityName': 'Yangon',
      'countryCode': 'MM',
    },
    {
      'iataCode': 'PNH',
      'name': 'Phnom Penh International Airport',
      'cityName': 'Phnom Penh',
      'countryCode': 'KH',
    },
    {
      'iataCode': 'REP',
      'name': 'Siem Reap International Airport',
      'cityName': 'Siem Reap',
      'countryCode': 'KH',
    },
    {
      'iataCode': 'VTE',
      'name': 'Wattay International Airport',
      'cityName': 'Vientiane',
      'countryCode': 'LA',
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
      'iataCode': 'KIX',
      'name': 'Kansai International Airport',
      'cityName': 'Osaka',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'NGO',
      'name': 'Chubu Centrair International Airport',
      'cityName': 'Nagoya',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'CTS',
      'name': 'New Chitose Airport',
      'cityName': 'Sapporo',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'FUK',
      'name': 'Fukuoka Airport',
      'cityName': 'Fukuoka',
      'countryCode': 'JP',
    },
    {
      'iataCode': 'ICN',
      'name': 'Incheon International Airport',
      'cityName': 'Seoul',
      'countryCode': 'KR',
    },
    {
      'iataCode': 'GMP',
      'name': 'Gimpo International Airport',
      'cityName': 'Seoul',
      'countryCode': 'KR',
    },
    {
      'iataCode': 'CJU',
      'name': 'Jeju International Airport',
      'cityName': 'Jeju',
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
      'iataCode': 'TSA',
      'name': 'Songshan Airport',
      'cityName': 'Taipei',
      'countryCode': 'TW',
    },
    {
      'iataCode': 'PVG',
      'name': 'Pudong International Airport',
      'cityName': 'Shanghai',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'SHA',
      'name': 'Hongqiao International Airport',
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
      'iataCode': 'PKX',
      'name': 'Beijing Daxing International Airport',
      'cityName': 'Beijing',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'CAN',
      'name': 'Guangzhou Baiyun International Airport',
      'cityName': 'Guangzhou',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'SZX',
      'name': 'Shenzhen Bao\'an International Airport',
      'cityName': 'Shenzhen',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'CTU',
      'name': 'Chengdu Tianfu International Airport',
      'cityName': 'Chengdu',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'MFM',
      'name': 'Macau International Airport',
      'cityName': 'Macau',
      'countryCode': 'MO',
    },
    {
      'iataCode': 'DEL',
      'name': 'Indira Gandhi International Airport',
      'cityName': 'Delhi',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'BOM',
      'name': 'Chhatrapati Shivaji Maharaj Intl Airport',
      'cityName': 'Mumbai',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'BLR',
      'name': 'Kempegowda International Airport',
      'cityName': 'Bangalore',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'MAA',
      'name': 'Chennai International Airport',
      'cityName': 'Chennai',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'HYD',
      'name': 'Rajiv Gandhi International Airport',
      'cityName': 'Hyderabad',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'CCU',
      'name': 'Netaji Subhas Chandra Bose Intl Airport',
      'cityName': 'Kolkata',
      'countryCode': 'IN',
    },
    {
      'iataCode': 'CMB',
      'name': 'Bandaranaike International Airport',
      'cityName': 'Colombo',
      'countryCode': 'LK',
    },
    {
      'iataCode': 'DAC',
      'name': 'Hazrat Shahjalal International Airport',
      'cityName': 'Dhaka',
      'countryCode': 'BD',
    },
    {
      'iataCode': 'KTM',
      'name': 'Tribhuvan International Airport',
      'cityName': 'Kathmandu',
      'countryCode': 'NP',
    },
    {
      'iataCode': 'MLE',
      'name': 'Velana International Airport',
      'cityName': 'Male',
      'countryCode': 'MV',
    },
    {
      'iataCode': 'PEN',
      'name': 'Penang International Airport',
      'cityName': 'Penang',
      'countryCode': 'MY',
    },
    {
      'iataCode': 'BKI',
      'name': 'Kota Kinabalu International Airport',
      'cityName': 'Kota Kinabalu',
      'countryCode': 'MY',
    },
    {
      'iataCode': 'PUS',
      'name': 'Gimhae International Airport',
      'cityName': 'Busan',
      'countryCode': 'KR',
    },
    {
      'iataCode': 'KMG',
      'name': 'Kunming Changshui International Airport',
      'cityName': 'Kunming',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'XIY',
      'name': 'Xi\'an Xianyang International Airport',
      'cityName': 'Xi\'an',
      'countryCode': 'CN',
    },
    {
      'iataCode': 'HGH',
      'name': 'Hangzhou Xiaoshan International Airport',
      'cityName': 'Hangzhou',
      'countryCode': 'CN',
    },

    // --- MIDDLE EAST / WEST ASIA ---
    {
      'iataCode': 'DXB',
      'name': 'Dubai International Airport',
      'cityName': 'Dubai',
      'countryCode': 'AE',
    },
    {
      'iataCode': 'AUH',
      'name': 'Abu Dhabi International Airport',
      'cityName': 'Abu Dhabi',
      'countryCode': 'AE',
    },
    {
      'iataCode': 'DOH',
      'name': 'Hamad International Airport',
      'cityName': 'Doha',
      'countryCode': 'QA',
    },
    {
      'iataCode': 'KWI',
      'name': 'Kuwait International Airport',
      'cityName': 'Kuwait City',
      'countryCode': 'KW',
    },
    {
      'iataCode': 'RUH',
      'name': 'King Khalid International Airport',
      'cityName': 'Riyadh',
      'countryCode': 'SA',
    },
    {
      'iataCode': 'JED',
      'name': 'King Abdulaziz International Airport',
      'cityName': 'Jeddah',
      'countryCode': 'SA',
    },
    {
      'iataCode': 'MCT',
      'name': 'Muscat International Airport',
      'cityName': 'Muscat',
      'countryCode': 'OM',
    },
    {
      'iataCode': 'AMM',
      'name': 'Queen Alia International Airport',
      'cityName': 'Amman',
      'countryCode': 'JO',
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

    // --- EUROPE (Main Hubs) ---
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
