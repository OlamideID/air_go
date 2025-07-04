import 'package:flutter/material.dart';

class DurationIndicator extends StatelessWidget {
  final String duration;

  const DurationIndicator({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 8, bottom: 8),
      height: 30,
      child: Row(
        children: [
          Container(width: 2, height: 30, color: Colors.grey.shade300),
          SizedBox(width: 12),
          Text(
            'Duration: $duration',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }
}