import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/widgets/flight_results/flight_result_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightListView extends StatefulWidget {
  final List<Flight> flights;
  final FlightSearchState state;
  final Function(int) onPageChanged;

  const FlightListView({
    super.key,
    required this.flights,
    required this.state,
    required this.onPageChanged,
  });

  @override
  State<FlightListView> createState() => _FlightListViewState();
}

class _FlightListViewState extends State<FlightListView> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged(index);
            },
            itemCount: widget.flights.length,
            itemBuilder: (context, index) {
              final flight = widget.flights[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FlightListItem(
                  flight: flight,
                  state: widget.state,
                  animationIndex: index,
                ),
              );
            },
          ),
        ),
        if (widget.flights.length > 1)
          PageIndicator(
            currentIndex: _currentIndex,
            itemCount: widget.flights.length,
          ),
      ],
    );
  }
}

class FlightListItem extends StatelessWidget {
  final Flight flight;
  final FlightSearchState state;
  final int animationIndex;

  const FlightListItem({
    super.key,
    required this.flight,
    required this.state,
    required this.animationIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (animationIndex * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: FlightResultCard(flight: flight, state: state),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        FlightDetails(flight: flight),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FlightDetails extends StatelessWidget {
  final Flight flight;

  const FlightDetails({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          flight.airline,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        _buildFlightTimes(),
      ],
    );
  }

  Widget _buildFlightTimes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${flight.departureAirport} ${DateFormat.Hm().format(flight.departureTime)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(width: 8),
        _buildDot(),
        const SizedBox(width: 8),
        Text(
          '${flight.arrivalAirport} ${DateFormat.Hm().format(flight.arrivalTime)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(width: 8),
        _buildDot(),
        const SizedBox(width: 8),
        Text(
          '${flight.duration ~/ 60}h ${flight.duration % 60}m',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
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

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.blue : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
