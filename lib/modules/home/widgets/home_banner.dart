import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/extensions.dart';

class HomeBanner extends StatelessWidget {

  final bool isParent;

  const HomeBanner({super.key, required this.isParent});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

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
              Text(
                'Welcome to Educology',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTab ? 14.sp : 14,
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
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: isTab ? 10.sp : 12,
                ),
              ),
            ],
          ),

          // Image Section
          Expanded(
            child: Image.asset(
              'assets/images/home_banner.png',
              height: isTab ? 170 : 105.h,
              width: isTab ? 170 : 105.w,
              fit: isTab ? BoxFit.contain : BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}