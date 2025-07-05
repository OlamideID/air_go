import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/screens/flight_detail_screen.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_duration_indicator.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_route_point.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FlightDetailScreen(flight: flight)),
        );
      },
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildBackground(),
            _buildPriceTag(),
            _buildStopInfo(),
            _buildOverlayInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: flight.airlineLogo != null && flight.airlineLogo!.isNotEmpty
          ? Image.asset(
              flight.airlineLogo!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => _fallbackBackground(),
            )
          : _fallbackBackground(),
    );
  }

  Widget _fallbackBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(Icons.flight, size: 60, color: Colors.grey),
      ),
    );
  }

  Widget _buildPriceTag() {
    return Positioned(
      top: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          '₦${flight.price.toStringAsFixed(0)} • ${_className(flight.travelClass)}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildStopInfo() {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          (flight.stops != null && flight.stops!.isNotEmpty)
              ? '${flight.stops!.length} Stop${flight.stops!.length > 1 ? 's' : ''}'
              : 'Non-stop',
          style: TextStyle(
            fontSize: 12,
            color: (flight.stops != null && flight.stops!.isNotEmpty)
                ? Colors.black
                : Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayInfo() {
    final timeFormat = DateFormat.Hm();
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAirportTimeBlock(
              code: flight.departureAirport,
              time: timeFormat.format(flight.departureTime),
              align: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                const Icon(Icons.flight, color: Colors.white, size: 20),
                Text(
                  '${flight.duration ~/ 60}h ${flight.duration % 60}m',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            _buildAirportTimeBlock(
              code: flight.arrivalAirport,
              time: timeFormat.format(flight.arrivalTime),
              align: CrossAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirportTimeBlock({
    required String code,
    required String time,
    required CrossAxisAlignment align,
  }) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          code,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(time, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  String _className(TravelClass travelClass) {
    switch (travelClass) {
      case TravelClass.economy:
        return 'Economy';
      case TravelClass.business:
        return 'Business';
      case TravelClass.first:
        return 'First';
      default:
        return 'Class';
    }
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DetailCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
            value: flight.flightNumber,
          ),
          InfoRow(
            icon: Icons.event_seat,
            title: 'Seat Class',
            value: flight.travelClass.displayName,
          ),
          InfoRow(
            icon: Icons.luggage,
            title: 'Baggage',
            value: '23kg included',
          ),
          InfoRow(icon: Icons.wifi, title: 'WiFi', value: 'Available'),
        ],
      ),
    );
  }
}

class CardWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const CardWrapper({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class FlightHeaderCard extends StatelessWidget {
  final Flight flight;
  final String status;
  final Color statusColor;

  const FlightHeaderCard({
    super.key,
    required this.flight,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAirlineLogo(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flight.airline,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  flight.flightNumber,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirlineLogo() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: flight.airlineLogo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                flight.airlineLogo!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.flight, size: 30, color: Colors.blue.shade600),
              ),
            )
          : Icon(Icons.flight, size: 30, color: Colors.blue.shade600),
    );
  }
}

class FlightRouteCard extends StatelessWidget {
  final Flight flight;
  final String Function(int) formatDuration;

  const FlightRouteCard({
    super.key,
    required this.flight,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return CardWrapper(
      title: 'Flight Route',
      child: Column(
        children: [
          RoutePoint(
            icon: Icons.flight_takeoff,
            label: 'Departure',
            airport: flight.departureAirport,
            dateTime: flight.departureTime,
            color: Colors.green,
          ),
          DurationIndicator(duration: formatDuration(flight.duration)),
          RoutePoint(
            icon: Icons.flight_land,
            label: 'Arrival',
            airport: flight.arrivalAirport,
            dateTime: flight.arrivalTime,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
