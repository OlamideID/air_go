import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flutter/material.dart';

class OptionFilters extends StatelessWidget {
  final bool directOnly;
  final bool includeNearbyAirports;
  final TravelClass selectedTravelClass;
  final int passengers;
  final ValueChanged<bool> onDirectOnlyChanged;
  final ValueChanged<bool> onIncludeNearbyChanged;
  final VoidCallback onTravelClassTap;
  final VoidCallback onPassengerDecreased;
  final VoidCallback onPassengerIncreased;

  const OptionFilters({
    super.key,
    required this.directOnly,
    required this.includeNearbyAirports,
    required this.selectedTravelClass,
    required this.passengers,
    required this.onDirectOnlyChanged,
    required this.onIncludeNearbyChanged,
    required this.onTravelClassTap,
    required this.onPassengerDecreased,
    required this.onPassengerIncreased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Optional Filters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          _buildDirectFlightsSwitch(),
          const SizedBox(height: 12),
          _buildNearbyAirportsSwitch(),
          const SizedBox(height: 12),
          _buildTravelClassSelector(),
          const SizedBox(height: 12),
          _buildPassengerSelector(),
        ],
      ),
    );
  }

  Widget _buildDirectFlightsSwitch() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: const Text(
          'Direct Flights Only',
          style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
        ),
        value: directOnly,
        onChanged: onDirectOnlyChanged,
        activeColor: const Color(0xFF2563EB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildNearbyAirportsSwitch() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: const Text(
          'Include Nearby Airports',
          style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
        ),
        value: includeNearbyAirports,
        onChanged: onIncludeNearbyChanged,
        activeColor: const Color(0xFF2563EB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildTravelClassSelector() {
    return InkWell(
      onTap: onTravelClassTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Travel Class',
              style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
            ),
            Row(
              children: [
                Text(
                  selectedTravelClass.displayName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Passengers',
            style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color(0xFF64748B)),
                onPressed: passengers > 1 ? onPassengerDecreased : null,
              ),
              Text(
                '$passengers',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF64748B)),
                onPressed: passengers < 9 ? onPassengerIncreased : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}