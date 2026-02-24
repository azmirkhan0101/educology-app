import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckAnswerScreen extends StatelessWidget {
  const CheckAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text(
          'Homework/ Exam',
          style: TextStyle(color: Color(0xFF2D4E68), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 4, // Number of items in the list
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemBuilder: (context, index) {
          // Hardcoded "Late" status for the second item as per your image
          bool isLate = index == 1;
          return SubmissionCard(isLate: isLate);
        },
      ),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  final bool isLate;

  const SubmissionCard({super.key, required this.isLate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image
            ),
            const SizedBox(width: 12),
            // Name and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mr. Rahman',
                    style: TextStyle(
                      color: Color(0xFF6DA382),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    '19 Nov, 2026 | 12:00PM',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Status Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isLate ? 'Late' : 'In Time',
                style: TextStyle(
                  color: isLate ? Colors.red : const Color(0xFF2D4E68),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF345169),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('View Answer', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.provideMark);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF345169)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Provide Mark', style: TextStyle(color: Color(0xFF345169))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}