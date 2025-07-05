import 'package:flight_test/features/core/sample_data.dart';
import 'package:flight_test/features/data/models/flight_model.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
    DateTime? returnDate,
    TripType? tripType,
    TravelClass? travelClass,
    bool directOnly = false,
    bool includeNearbyAirports = false,
    int passengers = 1,
  });
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  @override
  Future<List<FlightModel>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
    DateTime? returnDate,
    TripType? tripType,
    TravelClass? travelClass,
    bool directOnly = false,
    bool includeNearbyAirports = false,
    int passengers = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final filteredFlights = mockFlights.where((flight) {
      final dep = flight['departure_airport'] as String;
      final arr = flight['arrival_airport'] as String;
      final depTime = DateTime.parse(flight['departure_time']);
      final flightClass = TravelClass.fromString(flight['travel_class']);
      final type = flight['trip_type'];
      final stops = flight['stops'];

      final isMatchingClass = travelClass == null || flightClass == travelClass;
      final isDirect = directOnly
          ? (stops == null || (stops as List).isEmpty)
          : true;

      final depMatches = includeNearbyAirports
          ? dep.contains(departure.split(' ').first) ||
                departure.contains(dep.split(' ').first)
          : dep == departure;

      final arrMatches = includeNearbyAirports
          ? arr.contains(arrival.split(' ').first) ||
                arrival.contains(arr.split(' ').first)
          : arr == arrival;

      final dateMatches = _isSameDay(depTime, date);
      final returnMatches =
          returnDate != null && _isSameDay(depTime, returnDate);

      if (tripType == TripType.oneWay) {
        return type == 'oneWay' &&
            depMatches &&
            arrMatches &&
            dateMatches &&
            isMatchingClass &&
            isDirect;
      } else if (tripType == TripType.roundTrip) {
        return type == 'roundTrip' &&
            ((depMatches && arrMatches && dateMatches) ||
                (arrMatches && depMatches && returnMatches)) &&
            isMatchingClass &&
            isDirect;
      } else if (tripType == TripType.multiCity) {
        return type == 'multiCity' &&
            depMatches &&
            arrMatches &&
            dateMatches &&
            isMatchingClass &&
            isDirect;
      }

      return false;
    });

    return filteredFlights.map((json) {
      final model = FlightModel.fromJson(json);
      return FlightModel(
        id: model.id,
        airline: model.airline,
        airlineLogo: model.airlineLogo,
        flightNumber: model.flightNumber,
        departureAirport: model.departureAirport,
        arrivalAirport: model.arrivalAirport,
        departureTime: model.departureTime,
        arrivalTime: model.arrivalTime,
        price: model.price * passengers,
        aircraft: model.aircraft,
        duration: model.duration,
        stops: model.stops,
        travelClass: model.travelClass,
        tripType: model.tripType,
      );
    }).toList();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
