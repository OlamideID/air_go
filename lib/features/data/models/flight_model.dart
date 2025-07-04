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
    );
  }
}