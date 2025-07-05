import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/data/repositories/flight_repository_impl.dart';
import 'package:flight_test/features/domain/entities/flight.dart';

class FakeFlightRepository implements FlightRepository {
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
    final List<Flight> allFlights = [
      // Outbound Flights
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
        travelClass: TravelClass.economy,
        tripType: tripType ?? TripType.oneWay,
        passengers: passengers,
      ),
      Flight(
        id: '1b',
        airline: 'Test Airline',
        airlineLogo: 'https://logo.test.com/test.png',
        flightNumber: 'TA101',
        departureAirport: departure,
        arrivalAirport: arrival,
        departureTime: date,
        arrivalTime: date.add(const Duration(hours: 5)),
        price: 1200.0,
        aircraft: 'TestPlane 737',
        duration: 300,
        stops: ['Paris'],
        travelClass: TravelClass.business,
        tripType: tripType ?? TripType.oneWay,
        passengers: passengers,
      ),

      // Return Flights (for round trip)
      if (tripType == TripType.roundTrip && returnDate != null) ...[
        Flight(
          id: '1r',
          airline: 'Test Airline',
          airlineLogo: 'https://logo.test.com/test.png',
          flightNumber: 'TA102',
          departureAirport: arrival,
          arrivalAirport: departure,
          departureTime: returnDate,
          arrivalTime: returnDate.add(const Duration(hours: 5)),
          price: 500.0,
          aircraft: 'TestPlane 737',
          duration: 300,
          stops: null,
          travelClass: TravelClass.economy,
          tripType: TripType.roundTrip,
          passengers: passengers,
        ),
        Flight(
          id: '1rb',
          airline: 'Test Airline',
          airlineLogo: 'https://logo.test.com/test.png',
          flightNumber: 'TA102',
          departureAirport: arrival,
          arrivalAirport: departure,
          departureTime: returnDate,
          arrivalTime: returnDate.add(const Duration(hours: 5)),
          price: 1200.0,
          aircraft: 'TestPlane 737',
          duration: 300,
          stops: null,
          travelClass: TravelClass.business,
          tripType: TripType.roundTrip,
          passengers: passengers,
        ),
      ],
    ];

    return allFlights.where((flight) {
      final matchesClass =
          travelClass == null || flight.travelClass == travelClass;

      final isDirect = directOnly
          ? (flight.stops == null || flight.stops!.isEmpty)
          : true;

      final depMatches = includeNearbyAirports
          ? flight.departureAirport.contains(departure.split(' ').first) ||
                departure.contains(flight.departureAirport.split(' ').first)
          : flight.departureAirport == departure;

      final arrMatches = includeNearbyAirports
          ? flight.arrivalAirport.contains(arrival.split(' ').first) ||
                arrival.contains(flight.arrivalAirport.split(' ').first)
          : flight.arrivalAirport == arrival;

      final dateMatches = _isSameDay(flight.departureTime, date);
      final returnMatches =
          returnDate != null &&
          _isSameDay(flight.departureTime, returnDate) &&
          flight.tripType == TripType.roundTrip;

      if (tripType == TripType.oneWay) {
        return flight.tripType == TripType.oneWay &&
            depMatches &&
            arrMatches &&
            dateMatches &&
            matchesClass &&
            isDirect;
      } else if (tripType == TripType.roundTrip) {
        return flight.tripType == TripType.roundTrip &&
            ((depMatches && arrMatches && dateMatches) ||
                (arrMatches && depMatches && returnMatches)) &&
            matchesClass &&
            isDirect;
      } else if (tripType == TripType.multiCity) {
        return flight.tripType == TripType.multiCity &&
            depMatches &&
            arrMatches &&
            dateMatches &&
            matchesClass &&
            isDirect;
      }

      return false;
    }).toList();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
