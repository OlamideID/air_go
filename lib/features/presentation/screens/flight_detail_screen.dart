import 'dart:math';

import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/favorites_provider.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/amenities.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_baggage.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_header.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_row.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_map.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/policies.dart';
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

  @override
  Widget build(BuildContext context) {
    final flight = widget.flight;
    final state = ref.watch(flightSearchNotifierProvider);
    final totalPrice = flight.price;
    final returnDateText =
        (flight.tripType == TripType.roundTrip && widget.returnDate != null)
        ? DateFormat.yMMMMd().format(widget.returnDate!)
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(flight),
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlightDetailHeader(flight: flight),

              const Divider(height: 32, thickness: 1, color: Color(0xFFE2E8F0)),

              FlightDetailInfoSection(flight: flight, state: state),

              const FlightDetailMapSection(),
              const FlightDetailBaggageSection(),
              const FlightDetailPoliciesSection(),
              const FlightDetailAmenitiesSection(),

              FlightDetailBottomSection(
                flight: flight,
                state: state,
                returnDateText: returnDateText,
                assignedSeats: _assignedSeats,
                totalPrice: totalPrice,
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue to Book',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32), // extra scroll padding
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(Flight flight) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1E293B),
      leading: IconButton(
        icon: const Icon(Icons.close, size: 24),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Flight Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
      ),
      centerTitle: true,
      actions: [
        FutureBuilder<bool>(
          future: _isFavoriteFuture,
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : const Color(0xFF64748B),
                size: 24,
              ),
              onPressed: _toggleFavorite,
            );
          },
        ),
      ],
    );
  }
}
