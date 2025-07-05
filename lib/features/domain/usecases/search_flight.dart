import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/data/repositories/flight_repository_impl.dart';
import 'package:flight_test/features/domain/entities/flight.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<List<Flight>> call({
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
    return await repository.searchFlights(
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
  }
}
