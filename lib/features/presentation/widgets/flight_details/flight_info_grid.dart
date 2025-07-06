import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_detail_card.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/utils.dart';
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


class PriceInfoTile extends StatelessWidget {
  final double totalPrice;

  const PriceInfoTile({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: Icons.attach_money,
      label: 'Total Price: ₦${totalPrice.toStringAsFixed(2)}',
    );
  }
}

class TripTypeInfoTile extends StatelessWidget {
  final TripType tripType;

  const TripTypeInfoTile({super.key, required this.tripType});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: Icons.swap_horiz,
      label: 'Trip Type: ${FlightDetailUtils.getTripTypeDisplay(tripType)}',
    );
  }
}

class ReturnDateInfoTile extends StatelessWidget {
  final String returnDateText;

  const ReturnDateInfoTile({super.key, required this.returnDateText});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: Icons.calendar_today,
      label: 'Return Date: $returnDateText',
    );
  }
}

class PassengerInfoTile extends StatelessWidget {
  final dynamic state;

  const PassengerInfoTile({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: Icons.person,
      label: 'Passengers: ${state.passengers}',
    );
  }
}
