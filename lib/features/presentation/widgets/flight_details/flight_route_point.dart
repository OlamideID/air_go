import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutePoint extends StatelessWidget {
  final IconData icon;
  final String label;
  final String airport;
  final DateTime dateTime;
  final Color color;

  const RoutePoint({super.key, 
    required this.icon,
    required this.label,
    required this.airport,
    required this.dateTime,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                airport,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                DateFormat('MMM dd, yyyy').format(dateTime),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('HH:mm').format(dateTime),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
