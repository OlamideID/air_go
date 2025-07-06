import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/screens/flight_detail_screen.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_grid.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/seat_card.dart';
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
          TripTypeInfoTile(tripType: flight.tripType),
          if (returnDateText != null) ...[
            const SizedBox(height: 16),
            ReturnDateInfoTile(returnDateText: returnDateText!),
          ],
          const SizedBox(height: 16),
          PassengerInfoTile(state: state),
          if (state.passengers > 1) ...[
            const SizedBox(height: 12),
            SeatAssignmentCard(assignedSeats: assignedSeats),
          ],
          const SizedBox(height: 16),
          PriceInfoTile(totalPrice: totalPrice),
          const SizedBox(height: 16),
          AdditionalInfoCard(flight: flight),
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


