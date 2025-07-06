import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flutter/material.dart';

class FlightDetailBaggageSection extends StatelessWidget {
  const FlightDetailBaggageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Baggage Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          const InfoRow(
            icon: Icons.luggage,
            title: 'Checked Baggage',
            subtitle: '1 checked bag',
          ),
          const SizedBox(height: 16),
          const InfoRow(
            icon: Icons.backpack,
            title: 'Carry-on Baggage',
            subtitle: '1 carry-on',
          ),
        ],
      ),
    );
  }
}