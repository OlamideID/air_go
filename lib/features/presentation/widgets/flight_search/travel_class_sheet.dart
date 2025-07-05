import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flutter/material.dart';

class TravelClassBottomSheet extends StatelessWidget {
  final TravelClass selectedTravelClass;
  final ValueChanged<TravelClass> onTravelClassSelected;

  const TravelClassBottomSheet({
    super.key,
    required this.selectedTravelClass,
    required this.onTravelClassSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Travel Class',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          ...TravelClass.values.map(
            (travelClass) => ListTile(
              leading: Icon(
                selectedTravelClass == travelClass
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: selectedTravelClass == travelClass
                    ? const Color(0xFF2563EB)
                    : Colors.grey[400],
              ),
              title: Text(
                travelClass.displayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selectedTravelClass == travelClass
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: selectedTravelClass == travelClass
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF1E293B),
                ),
              ),
              onTap: () {
                onTravelClassSelected(travelClass);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
