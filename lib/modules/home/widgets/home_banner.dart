import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBanner extends StatelessWidget {

  final bool isParent;

  HomeBanner({super.key, required this.isParent}){}

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height and width can be adjusted based on your layout needs
      width: double.infinity,
      //height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Large rounded corners
        gradient: const LinearGradient(
          // Precise gradient from deep slate-blue to a muted forest green
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF33526A), // Deep slate blue
            //Color(0xFF6A8E7F), // Muted green transition
            Color(0xFF64937D), // Forest green
          ],
        ),
      ),
      child: Row(
        children: [
          // Text Section
          Column(
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
                isParent ?
                    "Stay connected with your child’s\nlearning journey. Track class\nactivities, attendance, tasks, and\nacademic progress—all in one place." :
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

          // Image Section
          Expanded(
            child: Image.asset(
              'assets/images/home_banner.png',
              height: 105.h,
              width: 105.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}