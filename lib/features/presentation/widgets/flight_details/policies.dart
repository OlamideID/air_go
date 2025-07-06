// widgets/flight_detail_policies_section.dart
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flutter/material.dart';

class FlightDetailPoliciesSection extends StatelessWidget {
  const FlightDetailPoliciesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Policies',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          const InfoRow(
            icon: Icons.description,
            title: 'Cancellation Policy',
            subtitle: '',
            hasArrow: true,
          ),
          const SizedBox(height: 16),
          const InfoRow(
            icon: Icons.description,
            title: 'Refund Policy',
            subtitle: '',
            hasArrow: true,
          ),
        ],
      ),
    );
  }
}