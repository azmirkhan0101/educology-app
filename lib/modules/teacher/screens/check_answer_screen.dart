import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          'Check Answer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 35.h,
                width: 35.w,
                child: CachedImageWidget(imageUrl: Dummy.profileImageUrl),
              ),
            ),
            const SizedBox(width: 6),
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
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    '19 Nov, 2026 | 12:00PM',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Status Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isLate ? 'Late' : 'In Time',
                style: TextStyle(
                  fontSize: 12,
                  color: isLate ? Colors.red : const Color(0xFF2D4E68),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ButtonWidget(label: AppStrings.viewAnswer,
              backgroundColor: AppColors.secondaryDarkBlue,
                buttonHeight: 40,
                fontSize: 14,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: ButtonWidget(label: AppStrings.provideMark,
                backgroundColor: AppColors.white,
                borderColor: AppColors.secondaryDarkBlue,
                textColor: AppColors.secondaryDarkBlue,
                borderWidth: 2,
                buttonHeight: 40,
                fontSize: 14,
                padding: EdgeInsets.zero,
                onPressed: (){
                Get.toNamed(AppRoutes.provideMark);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}