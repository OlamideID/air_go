import 'package:flight_test/features/data/datasources/flight_remote_data_source.dart';
import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/data/repositories/flight_repository_impl.dart';
import 'package:flight_test/features/domain/entities/flight.dart';
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
  final DateTime? returnDate;
  final TripType? tripType;
  final TravelClass? travelClass;
  final int passengers;
  final bool directOnly;
  final bool includeNearbyAirports;
  final RangeValues? priceRange;
  final List<String> selectedAirlines;
  final List<TravelClass> selectedTravelClasses;
  final SortOption sortOption;

  FlightSearchState({
    required this.status,
    this.flights = const [],
    this.errorMessage,
    this.departure,
    this.arrival,
    this.date,
    this.returnDate,
    this.tripType,
    this.travelClass,
    this.passengers = 1,
    this.directOnly = false,
    this.includeNearbyAirports = false,
    this.priceRange,
    this.selectedAirlines = const [],
    this.selectedTravelClasses = const [],
    this.sortOption = SortOption.priceLowToHigh,
  });

  factory FlightSearchState.initial() =>
      FlightSearchState(status: FlightSearchStatus.initial);

  List<Flight> get filteredFlights {
    List<Flight> result = List.from(flights);

    if (priceRange != null) {
      result = result.where((flight) {
        return flight.price >= priceRange!.start &&
            flight.price <= priceRange!.end;
      }).toList();
    }

    if (selectedAirlines.isNotEmpty) {
      result = result
          .where((flight) => selectedAirlines.contains(flight.airline))
          .toList();
    }

    if (selectedTravelClasses.isNotEmpty) {
      result = result
          .where((flight) => selectedTravelClasses.contains(flight.travelClass))
          .toList();
    }

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
    DateTime? returnDate,
    TripType? tripType,
    TravelClass? travelClass,
    int? passengers,
    bool? directOnly,
    bool? includeNearbyAirports,
    RangeValues? priceRange,
    List<String>? selectedAirlines,
    List<TravelClass>? selectedTravelClasses,
    SortOption? sortOption,
  }) {
    return FlightSearchState(
      status: status ?? this.status,
      flights: flights ?? this.flights,
      errorMessage: errorMessage ?? this.errorMessage,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      date: date ?? this.date,
      returnDate: returnDate ?? this.returnDate,
      tripType: tripType ?? this.tripType,
      travelClass: travelClass ?? this.travelClass,
      passengers: passengers ?? this.passengers,
      directOnly: directOnly ?? this.directOnly,
      includeNearbyAirports:
          includeNearbyAirports ?? this.includeNearbyAirports,
      priceRange: priceRange ?? this.priceRange,
      selectedAirlines: selectedAirlines ?? this.selectedAirlines,
      selectedTravelClasses:
          selectedTravelClasses ?? this.selectedTravelClasses,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

// Providers
final flightRepositoryProvider = Provider<FlightRepository>((ref) {
  return FlightRepositoryImpl(remoteDataSource: FlightRemoteDataSourceImpl());
});

final searchFlightsProvider = Provider.autoDispose<SearchFlights>((ref) {
  final repository = ref.watch(flightRepositoryProvider);
  return SearchFlights(repository);
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
    DateTime? returnDate,
    TripType? tripType,
    TravelClass? travelClass,
    int passengers = 1,
    bool directOnly = false,
    bool includeNearbyAirports = false,
  }) async {
    state = state.copyWith(status: FlightSearchStatus.loading);

    try {
      final flights = await searchFlights(
        departure: departure,
        arrival: arrival,
        date: date,
        returnDate: returnDate,
        tripType: tripType,
        travelClass: travelClass,
        passengers: passengers,
        directOnly: directOnly,
        includeNearbyAirports: includeNearbyAirports,
      );

      state = state.copyWith(
        status: FlightSearchStatus.success,
        flights: flights,
        departure: departure,
        arrival: arrival,
        date: date,
        returnDate: returnDate,
        tripType: tripType,
        travelClass: travelClass,
        passengers: passengers,
        directOnly: directOnly,
        includeNearbyAirports: includeNearbyAirports,
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
    List<TravelClass>? selectedTravelClasses,
  }) {
    state = state.copyWith(
      priceRange: priceRange,
      selectedAirlines: selectedAirlines,
      selectedTravelClasses: selectedTravelClasses,
    );
  }

  void sortFlights(SortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void clearResults() {
    state = state.copyWith(
      status: FlightSearchStatus.initial,
      flights: [],
      travelClass: null,
      selectedTravelClasses: [],
    );
  }

  void setTravelClass(TravelClass travelClass) {
    state = state.copyWith(travelClass: travelClass);
  }

  void setTripType(TripType tripType) {
    state = state.copyWith(tripType: tripType);
  }

  void toggleTravelClassFilter(TravelClass travelClass) {
    final current = List<TravelClass>.from(state.selectedTravelClasses);
    current.contains(travelClass)
        ? current.remove(travelClass)
        : current.add(travelClass);
    state = state.copyWith(selectedTravelClasses: current);
  }

  void clearTravelClassFilters() {
    state = state.copyWith(selectedTravelClasses: []);
  }
}
