import 'package:flight_test/features/data/models/flight_model.dart';

class Flight {
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
  final int passengers;

  Flight({
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
    required this.passengers,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airline': airline,
      'airlineLogo': airlineLogo,
      'flightNumber': flightNumber,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'price': price,
      'aircraft': aircraft,
      'duration': duration,
      'stops': stops,
      'travelClass': travelClass.toJsonString(),
      'tripType': tripType.name,
      'passengers': passengers, 
    };
  }

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] as String,
      airline: json['airline'] as String,
      airlineLogo: json['airlineLogo'] as String?,
      flightNumber: json['flightNumber'] as String,
      departureAirport: json['departureAirport'] as String,
      arrivalAirport: json['arrivalAirport'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      arrivalTime: DateTime.parse(json['arrivalTime'] as String),
      price: (json['price'] as num).toDouble(),
      aircraft: json['aircraft'] as String,
      duration: json['duration'] as int,
      stops: json['stops'] != null ? List<String>.from(json['stops']) : null,
      travelClass: TravelClass.fromString(json['travelClass'] ?? 'economy'),
      tripType: TripType.values.firstWhere(
        (t) => t.name == (json['tripType'] ?? 'oneWay'),
        orElse: () => TripType.oneWay,
      ),
      passengers: json['passengers'] as int? ?? 1,
    );
  }

  Flight copyWith({
    String? id,
    String? airline,
    String? airlineLogo,
    String? flightNumber,
    String? departureAirport,
    String? arrivalAirport,
    DateTime? departureTime,
    DateTime? arrivalTime,
    double? price,
    String? aircraft,
    int? duration,
    List<String>? stops,
    TravelClass? travelClass,
    TripType? tripType,
    int? passengers,
  }) {
    return Flight(
      id: id ?? this.id,
      airline: airline ?? this.airline,
      airlineLogo: airlineLogo ?? this.airlineLogo,
      flightNumber: flightNumber ?? this.flightNumber,
      departureAirport: departureAirport ?? this.departureAirport,
      arrivalAirport: arrivalAirport ?? this.arrivalAirport,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      price: price ?? this.price,
      aircraft: aircraft ?? this.aircraft,
      duration: duration ?? this.duration,
      stops: stops ?? this.stops,
      travelClass: travelClass ?? this.travelClass,
      tripType: tripType ?? this.tripType,
      passengers: passengers ?? this.passengers,
    );
  }

  bool get isDirect => stops == null || stops!.isEmpty;

  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    return '${hours}h ${minutes}m';
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
