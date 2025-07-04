import 'package:flight_test/features/data/models/flight_model.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  });
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
final List<Map<String, dynamic>> _mockFlights = [
  {
    'id': '1',
    'airline': 'Delta Airlines',
    'airline_logo': 'assets/wallpaperflare.com_wallpaper (10).jpg',
    'flight_number': 'DL123',
    'departure_airport': 'Lagos (LOS)',
    'arrival_airport': 'London (LHR)',
    'departure_time': DateTime(2025, 7, 5, 8).toIso8601String(),
    'arrival_time': DateTime(2025, 7, 5, 12).toIso8601String(),
    'price': 299.99,
    'aircraft': 'Boeing 737',
    'duration': 240,
    'stops': null,
  },
  {
    'id': '2',
    'airline': 'United Airlines',
    'airline_logo': 'assets/wallpaperflare.com_wallpaper (11).jpg',
    'flight_number': 'UA456',
    'departure_airport': 'Lagos (LOS)',
    'arrival_airport': 'London (LHR)',
    'departure_time': DateTime(2025, 7, 5, 14).toIso8601String(),
    'arrival_time': DateTime(2025, 7, 5, 20).toIso8601String(),
    'price': 249.99,
    'aircraft': 'Airbus A320',
    'duration': 360,
    'stops': ['Chicago (ORD)'],
  },
  {
    'id': '3',
    'airline': 'Emirates',
    'airline_logo': 'assets/wallpaperflare.com_wallpaper (12).jpg',
    'flight_number': 'EK202',
    'departure_airport': 'Lagos (LOS)',
    'arrival_airport': 'Dubai (DXB)',
    'departure_time': DateTime(2025, 7, 6, 6).toIso8601String(),
    'arrival_time': DateTime(2025, 7, 6, 12).toIso8601String(),
    'price': 399.00,
    'aircraft': 'Airbus A380',
    'duration': 360,
    'stops': null,
  },
  {
    'id': '4',
    'airline': 'Qatar Airways',
    'airline_logo': 'assets/wallpaperflare.com_wallpaper (13).jpg',
    'flight_number': 'QR721',
    'departure_airport': 'Abuja (ABV)',
    'arrival_airport': 'Dubai (DXB)',
    'departure_time': DateTime(2025, 7, 6, 10).toIso8601String(),
    'arrival_time': DateTime(2025, 7, 6, 17).toIso8601String(),
    'price': 410.50,
    'aircraft': 'Boeing 787',
    'duration': 420,
    'stops': ['Doha (DOH)'],
  },
  {
    'id': '5',
    'airline': 'KLM Royal Dutch Airlines',
    'airline_logo': 'assets/wallpaperflare.com_wallpaper (14).jpg',
    'flight_number': 'KL642',
    'departure_airport': 'Lagos (LOS)',
    'arrival_airport': 'Amsterdam (AMS)',
    'departure_time': DateTime(2025, 7, 7, 10).toIso8601String(),
    'arrival_time': DateTime(2025, 7, 7, 17).toIso8601String(),
    'price': 340.25,
    'aircraft': 'Airbus A330',
    'duration': 420,
    'stops': null,
  },
];


  @override
  Future<List<FlightModel>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final filteredFlights = _mockFlights.where((flight) {
      final dep = flight['departure_airport'];
      final arr = flight['arrival_airport'];
      final depTime = DateTime.parse(flight['departure_time']);

      return dep == departure &&
          arr == arrival &&
          depTime.year == date.year &&
          depTime.month == date.month &&
          depTime.day == date.day;
    }).toList();

    return filteredFlights.map((json) => FlightModel.fromJson(json)).toList();
  }
}
