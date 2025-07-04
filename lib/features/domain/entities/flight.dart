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
  });

  // Convert Flight to JSON
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
    };
  }

  // Create Flight from JSON
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
    );
  }
}
