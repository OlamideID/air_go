import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/domain/repositories/flight_repository.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<List<Flight>> call({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    return await repository.searchFlights(
      departure: departure,
      arrival: arrival,
      date: date,
    );
  }
}