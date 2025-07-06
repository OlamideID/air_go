import 'package:flutter/material.dart';

class FlightDetailMapSection extends StatelessWidget {
  const FlightDetailMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/flight_map.png', // Add your map image here
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback gradient background if image fails to load
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFFE0F2FE), const Color(0xFFBAE6FD)],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.map,
                    size: 48,
                    color: Color(0xFF0EA5E9),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}