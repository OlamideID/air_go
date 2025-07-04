import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/favorites_provider.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_card.dart';
import 'package:flight_test/features/presentation/widgets/flight_details/flight_info_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlightDetailScreen extends ConsumerStatefulWidget {
  final Flight flight;
  const FlightDetailScreen({super.key, required this.flight});

  @override
  ConsumerState<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends ConsumerState<FlightDetailScreen>
    with SingleTickerProviderStateMixin {
  late Future<bool> _isFavoriteFuture;
  late AnimationController _controller;

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
          duration: Duration(seconds: 1),
        ),
      );

      setState(() {
        _isFavoriteFuture = Future.value(!wasFavorite);
      });
    }
  }

  String _formatDuration(int minutes) => '${minutes ~/ 60}h ${minutes % 60}m';

  String _getFlightStatus() {
    final now = DateTime.now();
    final departure = DateTime.parse(widget.flight.departureTime.toString());
    final arrival = DateTime.parse(widget.flight.arrivalTime.toString());
    if (now.isBefore(departure)) return 'Scheduled';
    if (now.isAfter(departure) && now.isBefore(arrival)) return 'In Flight';
    return 'Completed';
  }

  Color _getStatusColor() => switch (_getFlightStatus()) {
    'Scheduled' => Colors.blue,
    'In Flight' => Colors.green,
    _ => Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    final flight = widget.flight;

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
              AdditionalInfoCard(flight: flight),
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
      foregroundColor: Colors.black87,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
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
