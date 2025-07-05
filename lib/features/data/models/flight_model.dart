enum TravelClass {
  economy('Economy'),
  premiumEconomy('Premium Economy'),
  business('Business'),
  first('First Class');

  const TravelClass(this.displayName);
  final String displayName;

  static TravelClass fromString(String value) {
    switch (value) {
      case 'economy':
        return TravelClass.economy;
      case 'premiumEconomy':
        return TravelClass.premiumEconomy;
      case 'business':
        return TravelClass.business;
      case 'first':
        return TravelClass.first;
      default:
        return TravelClass.economy;
    }
  }

  String toJsonString() {
    switch (this) {
      case TravelClass.economy:
        return 'economy';
      case TravelClass.premiumEconomy:
        return 'premiumEconomy';
      case TravelClass.business:
        return 'business';
      case TravelClass.first:
        return 'first';
    }
  }
}

enum TripType {
  oneWay('One Way'),
  roundTrip('Round Trip'),
  multiCity('Multi-City');

  const TripType(this.displayName);
  final String displayName;

  static TripType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'oneway':
      case 'one_way':
      case 'one way':
        return TripType.oneWay;
      case 'roundtrip':
      case 'round_trip':
      case 'round trip':
        return TripType.roundTrip;
      case 'multicity':
      case 'multi_city':
      case 'multi city':
        return TripType.multiCity;
      default:
        return TripType.oneWay;
    }
  }

  String toJsonString() {
    switch (this) {
      case TripType.oneWay:
        return 'one_way';
      case TripType.roundTrip:
        return 'round_trip';
      case TripType.multiCity:
        return 'multi_city';
    }
  }
}

class FlightModel {
  final String id;
  final String airline;
  final String? airlineLogo;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String aircraft;
  final int duration;
  final List<String>? stops;
  final TravelClass travelClass;
  final TripType tripType;

  FlightModel({
    required this.id,
    required this.airline,
    this.airlineLogo,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.aircraft,
    required this.duration,
    this.stops,
    required this.travelClass,
    required this.tripType,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'],
      airline: json['airline'],
      airlineLogo: json['airline_logo'],
      flightNumber: json['flight_number'],
      departureAirport: json['departure_airport'],
      arrivalAirport: json['arrival_airport'],
      departureTime: DateTime.parse(json['departure_time']),
      arrivalTime: DateTime.parse(json['arrival_time']),
      price: json['price'].toDouble(),
      aircraft: json['aircraft'],
      duration: json['duration'],
      stops: json['stops'] != null ? List<String>.from(json['stops']) : null,
      travelClass: TravelClass.fromString(json['travel_class'] ?? 'economy'),
      tripType: TripType.fromString(json['trip_type'] ?? 'one_way'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airline': airline,
      'airline_logo': airlineLogo,
      'flight_number': flightNumber,
      'departure_airport': departureAirport,
      'arrival_airport': arrivalAirport,
      'departure_time': departureTime.toIso8601String(),
      'arrival_time': arrivalTime.toIso8601String(),
      'price': price,
      'aircraft': aircraft,
      'duration': duration,
      'stops': stops,
      'travel_class': travelClass.toJsonString(),
      'trip_type': tripType.toJsonString(),
    };
  }
}
