import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/screens/flight_detail_screen.dart';
import 'package:flutter/material.dart';

class FlightResultCard extends StatelessWidget {
  final Flight flight;
  final FlightSearchState state;

  const FlightResultCard({
    super.key,
    required this.flight,
    required this.state,
  });

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
            _buildStopIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return flight.airlineLogo != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              flight.airlineLogo!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade100,
                ),
                child: const Center(
                  child: Icon(Icons.flight, size: 80, color: Colors.grey),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
            ),
            child: const Center(
              child: Icon(Icons.flight, size: 80, color: Colors.grey),
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
          '₦${flight.price.toStringAsFixed(0)} • ${_formatTravelClass(flight.travelClass)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildStopIndicator() {
    if (flight.stops != null && flight.stops!.isNotEmpty) {
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
            '${flight.stops!.length} Stop${flight.stops!.length > 1 ? 's' : ''}',
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      );
    } else {
      return Positioned(
        top: 16,
        right: 16,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Non-stop',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  String _formatTravelClass(TravelClass travelClass) {
    switch (travelClass) {
      case TravelClass.economy:
        return 'Economy';
      case TravelClass.premiumEconomy:
        return 'Premium Economy';
      case TravelClass.business:
        return 'Business';
      case TravelClass.first:
        return 'First Class';
    }
  }
}
