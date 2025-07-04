import 'package:flight_test/features/data/datasources/flight_remote_data_source.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/domain/repositories/flight_repository.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Flight>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    try {
      final flightModels = await remoteDataSource.searchFlights(
        departure: departure,
        arrival: arrival,
        date: date,
      );

      return flightModels
          .map(
            (model) => Flight(
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
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to search flights: $e');
    }
  }
}
