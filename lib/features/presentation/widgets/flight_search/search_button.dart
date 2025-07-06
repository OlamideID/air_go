import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onPressed;

  const SearchButton({
    super.key,
    required this.isSearching,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: isSearching ? null : onPressed,
        child: isSearching
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Search Flights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
