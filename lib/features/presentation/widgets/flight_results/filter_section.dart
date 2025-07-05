import 'package:flight_test/features/presentation/providers/flight_provider.dart';
import 'package:flutter/material.dart';

class SortFilterSection extends StatelessWidget {
  final dynamic notifier;
  final VoidCallback onFilterPressed;

  const SortFilterSection({
    super.key,
    required this.notifier,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Sort & Filter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: onFilterPressed,
          ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  final dynamic notifier;

  const FilterBottomSheet({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            context,
            'Price: Low to High',
            SortOption.priceLowToHigh,
          ),
          _buildSortOption(
            context,
            'Price: High to Low',
            SortOption.priceHighToLow,
          ),
          _buildSortOption(
            context,
            'Duration: Short to Long',
            SortOption.durationShortToLong,
          ),
          _buildSortOption(
            context,
            'Duration: Long to Short',
            SortOption.durationLongToShort,
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    String title,
    SortOption sortOption,
  ) {
    return ListTile(
      title: Text(title),
      onTap: () {
        notifier.sortFlights(sortOption);
        Navigator.pop(context);
      },
    );
  }

  static void show(BuildContext context, dynamic notifier) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterBottomSheet(notifier: notifier),
    );
  }
}