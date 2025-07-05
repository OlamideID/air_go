import 'dart:math';

import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/favorites_provider.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FlightDetailScreen extends ConsumerStatefulWidget {
  final Flight flight;
  final TripType? tripType;
  final DateTime? returnDate;

  const FlightDetailScreen({
    super.key,
    required this.flight,
    this.tripType,
    this.returnDate,
  });

  @override
  ConsumerState<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends ConsumerState<FlightDetailScreen>
    with SingleTickerProviderStateMixin {
  late Future<bool> _isFavoriteFuture;
  late AnimationController _controller;
  late List<String> _assignedSeats;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = ref
        .read(favoritesServiceProvider)
        .isFavorite(widget.flight.id);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    final passengers = ref.read(flightSearchNotifierProvider).passengers;
    _assignedSeats = _generateRandomSeats(passengers);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() async {
    final wasFavorite = await ref
        .read(favoritesServiceProvider)
        .isFavorite(widget.flight.id);

    await ref.read(favoritesProvider.notifier).toggleFavorite(widget.flight);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasFavorite ? 'Removed from bookmarks' : 'Added to bookmarks',
          ),
          duration: const Duration(seconds: 1),
        ),
      );

      setState(() {
        _isFavoriteFuture = Future.value(!wasFavorite);
      });
    }
  }

  List<String> _generateRandomSeats(int count) {
    const rows = 30;
    const seatLetters = ['A', 'B', 'C', 'D', 'E', 'F'];
    final random = Random();
    final seats = <String>{};

    while (seats.length < count) {
      final row = random.nextInt(rows) + 1;
      final letter = seatLetters[random.nextInt(seatLetters.length)];
      seats.add('$row$letter');
    }

    return seats.toList();
  }

  String _formatDuration(int minutes) => '${minutes ~/ 60}h ${minutes % 60}m';

  String _getFlightStatus() {
    final now = DateTime.now();
    final departure = widget.flight.departureTime;
    final arrival = widget.flight.arrivalTime;

    if (now.isBefore(departure)) return 'Scheduled';
    if (now.isAfter(departure) && now.isBefore(arrival)) return 'In Flight';
    return 'Completed';
  }

  Color _getStatusColor() {
    switch (_getFlightStatus()) {
      case 'Scheduled':
        return Colors.blue;
      case 'In Flight':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getClassDisplay(TravelClass travelClass) {
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

  String _getTripTypeDisplay(TripType type) {
    switch (type) {
      case TripType.oneWay:
        return 'One Way';
      case TripType.roundTrip:
        return 'Round Trip';
      case TripType.multiCity:
        return 'Multi-City';
    }
  }

  @override
  Widget build(BuildContext context) {
    final flight = widget.flight;
    final state = ref.watch(flightSearchNotifierProvider);
    final totalPrice = flight.price * state.passengers;
    final returnDateText =
        (flight.tripType == TripType.roundTrip && widget.returnDate != null)
        ? DateFormat.yMMMMd().format(widget.returnDate!)
        : null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(flight),
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FlightHeaderCard(
                flight: flight,
                status: _getFlightStatus(),
                statusColor: _getStatusColor(),
              ),
              const SizedBox(height: 16),
              FlightRouteCard(flight: flight, formatDuration: _formatDuration),
              const SizedBox(height: 16),
              FlightDetailsGrid(
                flight: flight,
                formatDuration: _formatDuration,
              ),
              const SizedBox(height: 16),
              _buildClassInfo(flight),
              const SizedBox(height: 16),
              _buildTripTypeInfo(flight.tripType),
              if (returnDateText != null) ...[
                const SizedBox(height: 16),
                _buildReturnDate(returnDateText),
              ],
              const SizedBox(height: 16),
              _infoTile(
                icon: Icons.person,
                label: 'Passengers: ${state.passengers}',
              ),
              if (state.passengers > 1) ...[
                const SizedBox(height: 12),
                _buildSeatAssignments(),
              ],
              const SizedBox(height: 16),
              _infoTile(
                icon: Icons.attach_money,
                label: 'Total Price: ₦${totalPrice.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),
              AdditionalInfoCard(flight: flight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatAssignments() {
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
            children: _assignedSeats.map((seat) {
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

  Widget _buildClassInfo(Flight flight) {
    return _infoTile(
      icon: Icons.event_seat,
      label: 'Class: ${_getClassDisplay(flight.travelClass)}',
    );
  }

  Widget _buildTripTypeInfo(TripType tripType) {
    return _infoTile(
      icon: Icons.swap_horiz,
      label: 'Trip Type: ${_getTripTypeDisplay(tripType)}',
    );
  }

  Widget _buildReturnDate(String returnDateText) {
    return _infoTile(
      icon: Icons.calendar_today,
      label: 'Return Date: $returnDateText',
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

  AppBar _buildAppBar(Flight flight) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flight Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            flight.flightNumber,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
      actions: [
        FutureBuilder<bool>(
          future: _isFavoriteFuture,
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_rounded,
                color: isFavorite ? Colors.yellow[900] : Colors.grey[600],
              ),
              onPressed: _toggleFavorite,
            );
          },
        ),
      ],
    );
  }
}
