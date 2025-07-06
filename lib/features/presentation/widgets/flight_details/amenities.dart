import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flutter/material.dart';

class FlightDetailAmenitiesSection extends StatelessWidget {
  const FlightDetailAmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amenities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          const InfoRow(
            icon: Icons.tv,
            title: 'In-flight Entertainment',
            subtitle: '',
          ),
          const SizedBox(height: 16),
          const InfoRow(icon: Icons.wifi, title: 'Wi-Fi', subtitle: ''),
          const SizedBox(height: 16),
          const InfoRow(icon: Icons.restaurant, title: 'Meals', subtitle: ''),
        ],
      ),
    );
  }
}
