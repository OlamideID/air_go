import 'package:flight_test/features/presentation/widgets/airport_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightSearchForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController departureController;
  final TextEditingController arrivalController;
  final DateTime? selectedDate;
  final VoidCallback onDateTap;

  const FlightSearchForm({
    super.key,
    required this.formKey,
    required this.departureController,
    required this.arrivalController,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  State<FlightSearchForm> createState() => _FlightSearchFormState();
}

class _FlightSearchFormState extends State<FlightSearchForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            buildStyledAutocomplete(
              controller: widget.departureController,
              label: 'From',
              icon: Icons.keyboard_arrow_down,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please select departure' : null,
            ),
            const SizedBox(height: 12),
            buildStyledAutocomplete(
              controller: widget.arrivalController,
              label: 'To',
              icon: Icons.keyboard_arrow_down,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please select arrival' : null,
            ),
            const SizedBox(height: 12),
            buildDateField(),
          ],
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
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF1F5F9),
      ),
      child: AirportAutocomplete(
        controller: controller,
        labelText: label,
        validator: validator,
        suffixIcon: icon,
      ),
    );
  }

  Widget buildDateField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF1F5F9),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Departure Date',
          labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF64748B),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onTap: widget.onDateTap,
        validator: (value) =>
            widget.selectedDate == null ? 'Please select date' : null,
        style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16),
        controller: TextEditingController(
          text: widget.selectedDate == null
              ? ''
              : DateFormat('MMM dd, yyyy').format(widget.selectedDate!),
        ),
      ),
    );
  }
}
