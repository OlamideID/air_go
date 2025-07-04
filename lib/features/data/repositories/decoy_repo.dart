// Corrected fake implementation
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/domain/repositories/flight_repository.dart';

class FakeFlightRepository implements FlightRepository {
  @override
  Future<List<Flight>> searchFlights({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    return [
      Flight(
        id: '1',
        airline: 'Test Airline',
        airlineLogo: 'https://logo.test.com/test.png',
        flightNumber: 'TA101',
        departureAirport: departure,
        arrivalAirport: arrival,
        departureTime: date, 
        arrivalTime: date.add(const Duration(hours: 5)), 
        price: 500.0,
        aircraft: 'TestPlane 737',
        duration: 300,
        stops: ['Paris'],
      )
    ];
  }
}
