import 'package:flight_test/features/data/repositories/decoy_repo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flight_test/features/domain/usecases/search_flight.dart';

void main() {
  test('returns list of flights from fake repository', () async {
    final repository = FakeFlightRepository();
    final searchFlights = SearchFlights(repository);
    final date = DateTime(2025, 7, 4);

    final result = await searchFlights(
      departure: 'Lagos (LOS)',
      arrival: 'London (LHR)',
      date: date,
    );

    expect(result, isNotEmpty);
    expect(result.first.airline, 'Test Airline');
    expect(result.first.departureAirport, 'Lagos (LOS)');
    expect(result.first.arrivalAirport, 'London (LHR)');
  });
}
