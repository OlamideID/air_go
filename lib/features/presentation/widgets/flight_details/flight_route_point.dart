import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/utils.dart';
import 'package:flutter/material.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';

class FlightDetailBottomSection extends StatelessWidget {
  final Flight flight;
  final dynamic state;
  final String? returnDateText;
  final List<String> assignedSeats;
  final double totalPrice;

  const FlightDetailBottomSection({
    super.key,
    required this.flight,
    required this.state,
    this.returnDateText,
    required this.assignedSeats,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTripTypeInfo(flight.tripType),
          if (returnDateText != null) ...[
            const SizedBox(height: 16),
            _buildReturnDate(returnDateText!),
          ],
          const SizedBox(height: 16),
          _buildPassengerInfo(state),
          if (state.passengers > 1) ...[
            const SizedBox(height: 12),
            _buildSeatAssignments(context),
          ],
          const SizedBox(height: 16),
          _buildPriceInfo(totalPrice),
          const SizedBox(height: 16),
          AdditionalInfoCard(flight: flight),
          const SizedBox(height: 100), // Space for button
        ],
      ),
    );
  }

  Widget _buildTripTypeInfo(TripType tripType) {
    return _infoTile(
      icon: Icons.swap_horiz,
      label: 'Trip Type: ${FlightDetailUtils.getTripTypeDisplay(tripType)}',
    );
  }

  Widget _buildReturnDate(String returnDateText) {
    return _infoTile(
      icon: Icons.calendar_today,
      label: 'Return Date: $returnDateText',
    );
  }

  Widget _buildPassengerInfo(dynamic state) {
    return _infoTile(
      icon: Icons.person,
      label: 'Passengers: ${state.passengers}',
    );
  }

  Widget _buildPriceInfo(double totalPrice) {
    return _infoTile(
      icon: Icons.attach_money,
      label: 'Total Price: ₦${totalPrice.toStringAsFixed(2)}',
    );
  }

  Widget _buildSeatAssignments(BuildContext context) {
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
              return Chip(
                label: Text('Seat $seat'),
                backgroundColor: const Color(0xFF1E40AF).withOpacity(0.1),
                labelStyle: const TextStyle(color: Color(0xFF1E40AF)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({required IconData icon, required String label}) {
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
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E40AF)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
