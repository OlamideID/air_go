import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flutter/material.dart';

class FlightList extends StatelessWidget {
  final List<Flight> flights;

  const FlightList({super.key, required this.flights});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flights.length,
      itemBuilder: (context, index) => FlightCard(flight: flights[index]),
    );
  }
}