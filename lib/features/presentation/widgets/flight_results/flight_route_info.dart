import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightRouteInfo extends StatelessWidget {
  final FlightSearchState state;

  const FlightRouteInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRouteSection(),
          const SizedBox(height: 12),
          _buildTripDetails(),
        ],
      ),
    );
  }

  Widget _buildRouteSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAirportInfo(
          code: state.departure ?? 'JFK',
          city: state.departure ?? 'New York',
          alignment: CrossAxisAlignment.start,
        ),
        const Icon(Icons.flight_takeoff, color: Colors.grey, size: 24),
        _buildAirportInfo(
          code: state.arrival ?? 'LAX',
          city: state.arrival ?? 'Los Angeles',
          alignment: CrossAxisAlignment.end,
        ),
      ],
    );
  }

  Widget _buildAirportInfo({
    required String code,
    required String city,
    required CrossAxisAlignment alignment,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          code,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(city, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTripDetails() {
    return Row(
      children: [
        Text(
          state.date != null
              ? DateFormat('E, MMM d').format(state.date!)
              : 'Fri, Jul 12',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        const SizedBox(width: 8),
        _buildDot(),
        const SizedBox(width: 8),
        Text(
          '${state.passengers} Adult${state.passengers > 1 ? 's' : ''}',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
