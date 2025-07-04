import 'package:flight_test/features/presentation/widgets/flight_search/search_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flight_test/features/presentation/widgets/airport_autocomplete.dart';

class FlightSearchForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController departureController;
  final TextEditingController arrivalController;
  final DateTime? selectedDate;
  final VoidCallback onDateTap;
  final VoidCallback onSearch;
  final bool isSearching;

  const FlightSearchForm({
    super.key,
    required this.formKey,
    required this.departureController,
    required this.arrivalController,
    required this.selectedDate,
    required this.onDateTap,
    required this.onSearch,
    required this.isSearching,
  });

  @override
  State<FlightSearchForm> createState() => _FlightSearchFormState();
}

class _FlightSearchFormState extends State<FlightSearchForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              buildStyledAutocomplete(
                controller: widget.departureController,
                label: 'From',
                icon: Icons.flight_takeoff,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please select departure'
                    : null,
              ),
              const SizedBox(height: 20),
              buildStyledAutocomplete(
                controller: widget.arrivalController,
                label: 'To',
                icon: Icons.flight_land,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please select arrival'
                    : null,
              ),
              const SizedBox(height: 20),
              buildDateField(),
              const SizedBox(height: 32),
              FlightSearchButton(
                onPressed: widget.isSearching ? null : widget.onSearch,
                isSearching: widget.isSearching,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStyledAutocomplete({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: AirportAutocomplete(
        controller: controller,
        labelText: label,
        validator: validator,
      ),
    );
  }

  Widget buildDateField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: Color(0xFF1E40AF),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintText: widget.selectedDate == null
              ? 'Select travel date'
              : DateFormat('MMM dd, yyyy').format(widget.selectedDate!),
          hintStyle: TextStyle(
            color: widget.selectedDate == null
                ? Colors.grey
                : const Color(0xFF1E293B),
          ),
        ),
        onTap: widget.onDateTap,
        validator: (value) =>
            widget.selectedDate == null ? 'Please select date' : null,
      ),
    );
  }
}

