import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/utils.dart';
import 'package:flutter/material.dart';


import 'package:flight_test/features/domain/entities/flight.dart';


class FlightDetailInfoSection extends StatelessWidget {
  final Flight flight;
  final dynamic state;

  const FlightDetailInfoSection({
    super.key,
    required this.flight,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flight Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          InfoRow(
            icon: Icons.airline_seat_recline_normal,
            title: 'Seat Class',
            subtitle: FlightDetailUtils.getClassDisplay(flight.travelClass),
          ),
          const SizedBox(height: 16),
          InfoRow(
            icon: Icons.access_time,
            title: 'Total Duration',
            subtitle: FlightDetailUtils.formatDuration(flight.duration),
          ),
          const SizedBox(height: 16),
          InfoRow(
            icon: Icons.location_on,
            title: 'Layovers and Stops',
            subtitle: (flight.stops == null || flight.stops!.isEmpty)
                ? 'Non-stop'
                : '${flight.stops!.length} stop${flight.stops!.length > 1 ? 's' : ''} (${flight.stops!.join(', ')})',
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasArrow;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (hasArrow)
          const Icon(Icons.chevron_right, size: 20, color: Color(0xFF94A3B8)),
      ],
    );
  }
}


class AdditionalInfoCard extends StatelessWidget {
  final Flight flight;

  const AdditionalInfoCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: 'Additional Information',
      child: Column(
        children: [
          InfoRow(
            icon: Icons.confirmation_number,
            title: 'Booking Reference',
            subtitle: flight.flightNumber,
          ),
          SizedBox(height: 10),
          InfoRow(
            icon: Icons.event_seat,
            title: 'Seat Class',
            subtitle: flight.travelClass.displayName,
          ),
          SizedBox(height: 10),

          InfoRow(
            icon: Icons.luggage,
            title: 'Baggage',
            subtitle: '23kg included',
          ),
          SizedBox(height: 10),

          InfoRow(icon: Icons.wifi, title: 'WiFi', subtitle: 'Available'),
        ],
      ),
    );
  }
}


class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
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

