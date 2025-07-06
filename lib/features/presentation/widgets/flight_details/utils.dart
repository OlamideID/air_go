import 'package:flight_test/features/data/models/flight_model.dart';

class FlightDetailUtils {
  static String formatDuration(int minutes) => '${minutes ~/ 60}h ${minutes % 60}m';

  static String getFlightStatus(DateTime departureTime, DateTime arrivalTime) {
    final now = DateTime.now();
    if (now.isBefore(departureTime)) return 'Scheduled';
    if (now.isAfter(departureTime) && now.isBefore(arrivalTime)) return 'In Flight';
    return 'Completed';
  }

  static String getClassDisplay(TravelClass travelClass) {
    switch (travelClass) {
      case TravelClass.economy:
        return 'Economy';
      case TravelClass.premiumEconomy:
        return 'Premium Economy';
      case TravelClass.business:
        return 'Business';
      case TravelClass.first:
        return 'First Class';
    }
  }

  static String getTripTypeDisplay(TripType type) {
    switch (type) {
      case TripType.oneWay:
        return 'One Way';
      case TripType.roundTrip:
        return 'Round Trip';
      case TripType.multiCity:
        return 'Multi-City';
    }
  }
}