import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Height and width can be adjusted based on your layout needs
      width: double.infinity,
      //height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Large rounded corners
        gradient: const LinearGradient(
          // Precise gradient from deep slate-blue to a muted forest green
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF435C6C), // Deep slate blue
            Color(0xFF6A8E7F), // Muted green transition
            Color(0xFF5D8471), // Forest green
          ],
        ),
      ),
      child: Row(
        children: [
          // Text Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Educology',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your teaching space is ready.\n'
                      'Manage your classes, lessons, and\n'
                      'student progress from one place.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Image Section
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              // Replace with your actual asset path
              child: Center(
                child: Image.asset(
                  'assets/images/home_banner.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}