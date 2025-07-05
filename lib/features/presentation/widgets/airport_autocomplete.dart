import 'package:flutter/material.dart';

class AirportAutocomplete extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final IconData suffixIcon;

  const AirportAutocomplete({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return airports.where(
          (airport) => airport.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController fieldController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: fieldController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                labelText: labelText,
                suffixIcon: Icon(suffixIcon),
                border: const OutlineInputBorder(),
              ),

              validator: validator,
            );
          },
    );
  }
}

const airports = [
  'New York (JFK)',
  'Los Angeles (LAX)',
  'Chicago (ORD)',
  'London (LHR)',
  'Paris (CDG)',
  'Tokyo (HND)',
  'Dubai (DXB)',
  'Hong Kong (HKG)',
  'San Francisco (SFO)',
  'Atlanta (ATL)',
  'Toronto (YYZ)',
  'Frankfurt (FRA)',
  'Singapore (SIN)',
  'Amsterdam (AMS)',
  'Sydney (SYD)',
  'Seoul (ICN)',
  'Beijing (PEK)',
  'Doha (DOH)',
  'Zurich (ZRH)',
  'Istanbul (IST)',
  'Bangkok (BKK)',
  'Delhi (DEL)',
  'Mumbai (BOM)',
  'São Paulo (GRU)',
  'Johannesburg (JNB)',
  'Cairo (CAI)',
  'Lagos (LOS)',
  'Abuja (ABV)',
  'Cape Town (CPT)',
  'Nairobi (NBO)',
  'Madrid (MAD)',
  'Rome (FCO)',
  'Barcelona (BCN)',
  'Vienna (VIE)',
  'Milan (MXP)',
  'Brussels (BRU)',
  'Munich (MUC)',
  'Berlin (BER)',
  'Lisbon (LIS)',
  'Oslo (OSL)',
  'Stockholm (ARN)',
  'Helsinki (HEL)',
  'Copenhagen (CPH)',
  'Warsaw (WAW)',
  'Athens (ATH)',
  'Dublin (DUB)',
  'Budapest (BUD)',
  'Manila (MNL)',
  'Jakarta (CGK)',
  'Kuala Lumpur (KUL)',
  'Mexico City (MEX)',
  'Vancouver (YVR)',
  'Boston (BOS)',
  'Seattle (SEA)',
  'Miami (MIA)',
  'Philadelphia (PHL)',
  'Dallas (DFW)',
  'Houston (IAH)',
  'Phoenix (PHX)',
  'Denver (DEN)',
];
