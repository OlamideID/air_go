import 'package:flutter/material.dart';

class FlightStatusWidgets {
  static Widget buildInitialState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Enter search criteria',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  static Widget buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Searching flights...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  static Widget buildErrorState(String? errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error: ${errorMessage ?? "Something went wrong"}',
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  static Widget buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight_takeoff, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No flights found', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}