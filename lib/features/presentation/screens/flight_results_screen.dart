import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/screens/flight_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FlightResultsScreen extends ConsumerWidget {
  const FlightResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flightSearchNotifierProvider);
    final notifier = ref.read(flightSearchNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Flight Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (option) => notifier.sortFlights(option),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: SortOption.priceLowToHigh,
                child: Text('Price: Low to High'),
              ),
              const PopupMenuItem(
                value: SortOption.priceHighToLow,
                child: Text('Price: High to Low'),
              ),
              const PopupMenuItem(
                value: SortOption.durationShortToLong,
                child: Text('Duration: Short to Long'),
              ),
              const PopupMenuItem(
                value: SortOption.durationLongToShort,
                child: Text('Duration: Long to Short'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(state, context),
    );
  }

  Widget _buildBody(FlightSearchState state, BuildContext context) {
    // Get filtered flights based on current filters
    List<Flight> displayedFlights = _getFilteredFlights(state);

    switch (state.status) {
      case FlightSearchStatus.initial:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 64, color: Color(0xFF94A3B8)),
              SizedBox(height: 16),
              Text(
                'Enter search criteria',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ],
          ),
        );
      case FlightSearchStatus.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF1E40AF)),
              SizedBox(height: 16),
              Text(
                'Searching flights...',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ],
          ),
        );
      case FlightSearchStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFFEF4444),
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Color(0xFFEF4444)),
              ),
            ],
          ),
        );
      case FlightSearchStatus.success:
        if (displayedFlights.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flight_takeoff, size: 64, color: Color(0xFF94A3B8)),
                SizedBox(height: 16),
                Text(
                  'No flights found',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: displayedFlights.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final flight = displayedFlights[index];
              final departureTime = DateFormat.Hm().format(
                DateTime.parse(flight.departureTime.toString()),
              );
              final arrivalTime = DateFormat.Hm().format(
                DateTime.parse(flight.arrivalTime.toString()),
              );

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300 + (index * 100)),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FlightDetailScreen(flight: flight),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                    flight.airlineLogo ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.flight,
                                      size: 32,
                                      color: Color(0xFF1E40AF),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${flight.airline} (${flight.flightNumber})',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$departureTime → $arrivalTime',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${flight.aircraft} • ₦${flight.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF1E40AF,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Color(0xFF1E40AF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
    }
  }

  List<Flight> _getFilteredFlights(FlightSearchState state) {
    List<Flight> flights = List.from(state.flights);

    // Apply sorting
    switch (state.sortOption) {
      case SortOption.priceLowToHigh:
        flights.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        flights.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.durationShortToLong:
        flights.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case SortOption.durationLongToShort:
        flights.sort((a, b) => b.duration.compareTo(a.duration));
        break;
    }

    return flights;
  }
}
