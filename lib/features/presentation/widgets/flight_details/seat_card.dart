
import 'package:flutter/material.dart';

class SeatAssignmentCard extends StatelessWidget {
  final List<String> assignedSeats;

  const SeatAssignmentCard({super.key, required this.assignedSeats});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 360;

    final horizontalSpacing = isCompact ? 6.0 : 12.0;
    final verticalSpacing = isCompact ? 6.0 : 12.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assigned Seats',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: horizontalSpacing,
            runSpacing: verticalSpacing,
            children: assignedSeats.map((seat) {
              return SeatChip(seatNumber: seat);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
class SeatChip extends StatelessWidget {
  final String seatNumber;

  const SeatChip({super.key, required this.seatNumber});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('Seat $seatNumber'),
      backgroundColor: const Color(0xFF1E40AF).withOpacity(0.1),
      labelStyle: const TextStyle(color: Color(0xFF1E40AF)),
    );
  }
}


