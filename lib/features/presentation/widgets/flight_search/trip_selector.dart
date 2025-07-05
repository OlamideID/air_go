import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flutter/material.dart';

class TripTypeSelector extends StatelessWidget {
  final TripType tripType;
  final ValueChanged<TripType> onTypeSelected;

  const TripTypeSelector({
    super.key,
    required this.tripType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTripTypeButton('One way', TripType.oneWay)),
          Expanded(child: _buildTripTypeButton('Round trip', TripType.roundTrip)),
          Expanded(child: _buildTripTypeButton('Multi-City', TripType.multiCity)),
        ],
      ),
    );
  }

  Widget _buildTripTypeButton(String text, TripType type) {
    final isSelected = tripType == type;
    return InkWell(
      onTap: () => onTypeSelected(type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.black87 : Colors.black54,
          ),
        ),
      ),
    );
  }
}

