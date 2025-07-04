import 'package:flight_test/features/data/datasources/flight_remote_data_source.dart';
import 'package:flight_test/features/data/repositories/flight_repository_impl.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
import 'package:flight_test/features/domain/repositories/flight_repository.dart';
import 'package:flight_test/features/domain/usecases/search_flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOption {
  priceLowToHigh,
  priceHighToLow,
  durationShortToLong,
  durationLongToShort,
}

enum FlightSearchStatus { initial, loading, success, error }

class FlightSearchState {
  final FlightSearchStatus status;
  final List<Flight> flights;
  final String? errorMessage;
  final String? departure;
  final String? arrival;
  final DateTime? date;
  final RangeValues? priceRange;
  final List<String> selectedAirlines;
  final SortOption sortOption;

  FlightSearchState({
    required this.status,
    this.flights = const [],
    this.errorMessage,
    this.departure,
    this.arrival,
    this.date,
    this.priceRange,
    this.selectedAirlines = const [],
    this.sortOption = SortOption.priceLowToHigh,
  });

  factory FlightSearchState.initial() =>
      FlightSearchState(status: FlightSearchStatus.initial);

  List<Flight> get filteredFlights {
    // Create a new mutable list from the original flights
    List<Flight> result = List.from(flights);

    // Apply price filter
    if (priceRange != null) {
      result = result.where((flight) {
        return flight.price >= priceRange!.start &&
            flight.price <= priceRange!.end;
      }).toList();
    }

    // Apply airline filter
    if (selectedAirlines.isNotEmpty) {
      result = result.where((flight) {
        return selectedAirlines.contains(flight.airline);
      }).toList();
    }

    // Apply sorting
    switch (sortOption) {
      case SortOption.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.durationShortToLong:
        result.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case SortOption.durationLongToShort:
        result.sort((a, b) => b.duration.compareTo(a.duration));
        break;
    }

    return result;
  }

  FlightSearchState copyWith({
    FlightSearchStatus? status,
    List<Flight>? flights,
    String? errorMessage,
    String? departure,
    String? arrival,
    DateTime? date,
    RangeValues? priceRange,
    List<String>? selectedAirlines,
    SortOption? sortOption,
  }) {
    return FlightSearchState(
      status: status ?? this.status,
      flights: flights ?? this.flights,
      errorMessage: errorMessage ?? this.errorMessage,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      date: date ?? this.date,
      priceRange: priceRange ?? this.priceRange,
      selectedAirlines: selectedAirlines ?? this.selectedAirlines,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

final flightRepositoryProvider = Provider<FlightRepository>((ref) {
  return FlightRepositoryImpl(remoteDataSource: FlightRemoteDataSourceImpl());
});

final searchFlightsProvider = Provider<SearchFlights>((ref) {
  return SearchFlights(ref.read(flightRepositoryProvider));
});

final flightSearchNotifierProvider =
    StateNotifierProvider<FlightSearchNotifier, FlightSearchState>((ref) {
      return FlightSearchNotifier(ref.read(searchFlightsProvider));
    });

class FlightSearchNotifier extends StateNotifier<FlightSearchState> {
  final SearchFlights searchFlights;

  FlightSearchNotifier(this.searchFlights) : super(FlightSearchState.initial());

  Future<void> search({
    required String departure,
    required String arrival,
    required DateTime date,
  }) async {
    state = state.copyWith(status: FlightSearchStatus.loading);

    try {
      final flights = await searchFlights(
        departure: departure,
        arrival: arrival,
        date: date,
      );

      state = state.copyWith(
        status: FlightSearchStatus.success,
        flights: flights,
        departure: departure,
        arrival: arrival,
        date: date,
      );
    } catch (e) {
      state = state.copyWith(
        status: FlightSearchStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void updateFilters({
    RangeValues? priceRange,
    List<String>? selectedAirlines,
  }) {
    state = state.copyWith(
      priceRange: priceRange,
      selectedAirlines: selectedAirlines,
    );
  }

  void sortFlights(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  // void showFilterDialog(BuildContext context) {
  //   final airlines = state.flights.map((f) => f.airline).toSet().toList();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           RangeValues? tempPriceRange = state.priceRange;
  //           List<String> tempSelectedAirlines = List.from(
  //             state.selectedAirlines,
  //           );

  //           return AlertDialog(
  //             title: const Text('Filter Flights'),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Text('Price Range'),
  //                 RangeSlider(
  //                   values:
  //                       tempPriceRange ??
  //                       RangeValues(
  //                         state.flights.map((f) => f.price).reduce(min),
  //                         state.flights.map((f) => f.price).reduce(max),
  //                       ),
  //                   min: state.flights.map((f) => f.price).reduce(min),
  //                   max: state.flights.map((f) => f.price).reduce(max),
  //                   onChanged: (values) {
  //                     setState(() => tempPriceRange = values);
  //                   },
  //                 ),
  //                 const Text('Airlines'),
  //                 ...airlines
  //                     .map(
  //                       (airline) => CheckboxListTile(
  //                         title: Text(airline),
  //                         value: tempSelectedAirlines.contains(airline),
  //                         onChanged: (checked) {
  //                           setState(() {
  //                             if (checked!) {
  //                               tempSelectedAirlines.add(airline);
  //                             } else {
  //                               tempSelectedAirlines.remove(airline);
  //                             }
  //                           });
  //                         },
  //                       ),
  //                     )
  //                     ,
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   updateFilters(priceRange: null, selectedAirlines: []);
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Reset'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   updateFilters(
  //                     priceRange: tempPriceRange,
  //                     selectedAirlines: tempSelectedAirlines,
  //                   );
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Apply'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void clearResults() {
    state = state.copyWith(status: FlightSearchStatus.initial, flights: []);
  }
}
