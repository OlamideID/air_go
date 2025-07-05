import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/widgets/flight_results/filter_section.dart';
import 'package:flight_test/features/presentation/widgets/flight_results/flight_route_info.dart';
import 'package:flight_test/features/presentation/widgets/flight_results/list.dart';
import 'package:flight_test/features/presentation/widgets/flight_results/status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlightResultsScreen extends ConsumerStatefulWidget {
  const FlightResultsScreen({super.key});

  @override
  ConsumerState<FlightResultsScreen> createState() =>
      _FlightResultsScreenState();
}

class _FlightResultsScreenState extends ConsumerState<FlightResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(flightSearchNotifierProvider);
    final notifier = ref.read(flightSearchNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          FlightRouteInfo(state: state),
          SortFilterSection(
            notifier: notifier,
            onFilterPressed: () => _showFilterOptions(context, notifier),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildFlightContent(state)),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Flights',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildFlightContent(FlightSearchState state) {
    switch (state.status) {
      case FlightSearchStatus.initial:
        return FlightStatusWidgets.buildInitialState();

      case FlightSearchStatus.loading:
        return FlightStatusWidgets.buildLoadingState();

      case FlightSearchStatus.error:
        return FlightStatusWidgets.buildErrorState(state.errorMessage);

      case FlightSearchStatus.success:
        final displayedFlights = state.filteredFlights;

        if (displayedFlights.isEmpty) {
          return FlightStatusWidgets.buildEmptyState();
        }

        return FlightListView(
          flights: displayedFlights,
          state: state,
          onPageChanged: (index) {
            setState(() {});
          },
        );
    }
  }

  void _showFilterOptions(BuildContext context, dynamic notifier) {
    FilterBottomSheet.show(context, notifier);
  }
}
