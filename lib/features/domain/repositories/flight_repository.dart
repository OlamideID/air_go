import 'package:flight_test/features/data/datasources/flight_remote_data_source.dart';
import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';

abstract class FlightRepository {
  Future<List<Flight>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
    DateTime? returnDate,
    TripType? tripType,
    TravelClass? travelClass,
    bool directOnly,
    bool includeNearbyAirports,
    int passengers,
  });
}

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Flight>> searchFlights({
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
    try {
      final flightModels = await remoteDataSource.searchFlights(
        departure: departure,
        arrival: arrival,
        date: date,
        returnDate: returnDate,
        tripType: tripType,
        travelClass: travelClass,
        directOnly: directOnly,
        includeNearbyAirports: includeNearbyAirports,
        passengers: passengers,
      );

      return flightModels.map((model) {
        return Flight(
          id: model.id,
          airline: model.airline,
          airlineLogo: model.airlineLogo,
          flightNumber: model.flightNumber,
          departureAirport: model.departureAirport,
          arrivalAirport: model.arrivalAirport,
          departureTime: model.departureTime,
          arrivalTime: model.arrivalTime,
          price: model.price,
          aircraft: model.aircraft,
          duration: model.duration,
          stops: model.stops,
          travelClass: model.travelClass,
          tripType: model.tripType,
          passengers: passengers, // ✅ Inject passengers from parameter
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to search flights: $e');
    }
  }
}
