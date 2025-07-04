import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightDetailsGrid extends StatelessWidget {
  final Flight flight;
  final String Function(int) formatDuration;

  const FlightDetailsGrid({
    super.key,
    required this.flight,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flight Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: 'Aircraft',
                value: flight.aircraft,
                icon: Icons.airplanemode_active,
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DetailCard(
                title: 'Duration',
                value: formatDuration(flight.duration),
                icon: Icons.access_time,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DetailCard(
                title: 'Stops',
                value: flight.stops?.join(', ') ?? 'Non-stop',
                icon: Icons.route,
                color: Colors.teal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DetailCard(
                title: 'Price',
                value: '₦${NumberFormat('#,##0.00').format(flight.price)}',
                icon: Icons.attach_money,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
