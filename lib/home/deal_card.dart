import 'package:flutter/material.dart';

class DealCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const DealCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE53935), Color(0xFF1A1A1A)],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(imagePath, height: 90, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
