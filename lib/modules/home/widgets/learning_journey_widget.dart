import 'package:flutter/material.dart';

class LearningJourneyWidget extends StatelessWidget {
  const LearningJourneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom colors based on the image
    const Color primaryBlue = Color(0xFF2E5B7D);
    const Color textGrey = Color(0xFF666666);
    const Color noteBackground = Color(0xFFF3FAF7);
    const Color noteBorder = Color(0xFFC5B081);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your learning journey will begin soon.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your account has been created successfully, but you haven\'t been enrolled in any courses yet.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: textGrey, height: 1.5),
          ),
          const SizedBox(height: 10),
          const Text(
            'Courses are added by the admin. Once you are assigned to a course, it will appear here automatically.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: textGrey, height: 1.5),
          ),
          const SizedBox(height: 10),

          // The "Helpful Note" section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: noteBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: noteBorder, width: 1),
            ),
            child: Column(
              children: [
                const Text(
                  'Helpful Note',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'If you think this is a mistake, please contact your school or administrator.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: textGrey, height: 1.4),
                ),
                const SizedBox(height: 8),
                const Text('Email', style: TextStyle(fontSize: 12, color: textGrey)),
                const Text(
                  'info@carerfinderau.com',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
                const SizedBox(height: 8),
                const Text('Phone', style: TextStyle(fontSize: 12, color: textGrey)),
                const Text(
                  '(880)1634425785',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}