import 'package:flight_test/features/data/models/flight_model.dart';
import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flight_test/features/presentation/screens/flight_results_screen.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/options.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/return_selector.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/search_button.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/search_form.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/travel_class_sheet.dart';
import 'package:flight_test/features/presentation/widgets/flight_search/trip_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlightSearchScreen extends ConsumerStatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  ConsumerState<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends ConsumerState<FlightSearchScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _departureController;
  late TextEditingController _arrivalController;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  DateTime? _selectedDate;
  DateTime? _selectedReturnDate;
  TripType _tripType = TripType.oneWay;
  TravelClass _selectedTravelClass = TravelClass.economy;
  bool _isSearching = false;
  bool _directOnly = false;
  bool _includeNearbyAirports = false;
  int _passengers = 1;

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController();
    _arrivalController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, {bool isReturn = false}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2563EB),
            brightness: Brightness.light,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        if (isReturn) {
          _selectedReturnDate = picked;
        } else {
          _selectedDate = picked;
        }
      });
    }
  }

  void _showTravelClassSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TravelClassBottomSheet(
        selectedTravelClass: _selectedTravelClass,
        onTravelClassSelected: (travelClass) {
          setState(() => _selectedTravelClass = travelClass);
        },
      ),
    );
  }

  void _searchFlights() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() => _isSearching = true);

      ref.read(flightSearchNotifierProvider.notifier).search(
            departure: _departureController.text,
            arrival: _arrivalController.text,
            date: _selectedDate!,
            returnDate: _tripType == TripType.roundTrip ? _selectedReturnDate : null,
            tripType: _tripType,
            travelClass: _selectedTravelClass,
            directOnly: _directOnly,
            includeNearbyAirports: _includeNearbyAirports,
            passengers: _passengers,
          );

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FlightResultsScreen()),
        );
      }

      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Search Flights',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FlightSearchForm(
                      formKey: _formKey,
                      departureController: _departureController,
                      arrivalController: _arrivalController,
                      selectedDate: _selectedDate,
                      onDateTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 8),
                    TripTypeSelector(
                      tripType: _tripType,
                      onTypeSelected: (type) => setState(() => _tripType = type),
                    ),
                    if (_tripType == TripType.roundTrip)
                      ReturnDateSelector(
                        selectedReturnDate: _selectedReturnDate,
                        onTap: () => _selectDate(context, isReturn: true),
                      ),
                    const SizedBox(height: 16),
                    OptionFilters(
                      directOnly: _directOnly,
                      includeNearbyAirports: _includeNearbyAirports,
                      selectedTravelClass: _selectedTravelClass,
                      passengers: _passengers,
                      onDirectOnlyChanged: (value) => setState(() => _directOnly = value),
                      onIncludeNearbyChanged: (value) => 
                          setState(() => _includeNearbyAirports = value),
                      onTravelClassTap: _showTravelClassSelector,
                      onPassengerDecreased: () => setState(() => _passengers--),
                      onPassengerIncreased: () => setState(() => _passengers++),
                    ),
                    const SizedBox(height: 70), // Added space before the button
                  ],
                ),
              ),
            ),
          ),
          SearchButton(
            isSearching: _isSearching,
            onPressed: _searchFlights,
          ),
        ],
      ),
    );
  }
}

