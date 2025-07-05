import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReturnDateSelector extends StatelessWidget {
  final DateTime? selectedReturnDate;
  final VoidCallback onTap;

  const ReturnDateSelector({
    super.key,
    required this.selectedReturnDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Color(0xFF64748B),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Text(
                    selectedReturnDate != null
                        ? 'Return: ${DateFormat('MMM dd, yyyy').format(selectedReturnDate!)}'
                        : 'Return Date',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedReturnDate != null
                          ? Colors.black87
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ],
    );
  }
}