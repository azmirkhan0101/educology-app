import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/modules/content_details/controllers/content_details_controller.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class ContentDetailsScreen extends StatelessWidget {
  ContentDetailsScreen({super.key});

  final ContentDetailsController controller = Get.find<ContentDetailsController>();

  @override
  Widget build(BuildContext context) {

    Role role = controller.role;
    bool isTeacher = role == Role.teacher || role == Role.assistant;
    bool isStudent = role == Role.student;
    bool isExam = controller.contentDetailsType == ContentDetailsType.exam
        || controller.contentDetailsType == ContentDetailsType.homeWork;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          controller.appTitle,
          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Text(
              '1st Exam Algebra – Linear Equations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5B71),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Due Date: 12 Nov, 25  10:00 AM',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            // Teacher Row
            Row(
              children: [
                 ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                   child: Container(
                     height: 35.h,
                     width: 35.w,
                     color: AppColors.greyB2,
                     child: CachedImageWidget(imageUrl: Dummy.profileImageUrl),
                   ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr. Rahman',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreen),
                      ),
                      Text('19 Nov, 2026 | 12:00PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Missing', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Submit Button
            if( isExam && isTeacher )
            ButtonWidget(
                label: AppStrings.checkAnswer,
              gradient: AppColors.primaryButtonGradient,
              prefixIcon: Icons.question_answer_rounded,
              fontSize: 14,
              buttonHeight: 45,
              onPressed: (){
                  Get.toNamed(AppRoutes.checkAnswer);
              },
            ),
            if( isExam && isStudent )
              ButtonWidget(
                label: AppStrings.submitAnswer,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.file_upload_outlined,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: (){
                  //Get.toNamed(AppRoutes.checkAnswer);
                },
              ),
            if( !isExam && isStudent )
              ButtonWidget(
                label: AppStrings.joinClass,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.timer_outlined,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: (){
                  //Get.toNamed(AppRoutes.checkAnswer);
                },
              ),
            if( !isExam && isTeacher )
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 2,
              children: [
                Expanded(
                  child: ButtonWidget(
                    buttonHeight: 45,
                    label: AppStrings.startClass,
                    gradient: AppColors.primaryButtonGradient,
                    prefixIcon: Icons.timer_outlined,
                    fontSize: 13,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    padding: EdgeInsets.zero,
                    buttonHeight: 45,
                    label: AppStrings.attendance,
                    fontSize: 13,
                    prefixIcon: Icons.calendar_today_outlined,
                    prefixIconColor: AppColors.darkGold,
                    prefixIconSize: 18,
                    backgroundColor: AppColors.white,
                    borderColor: AppColors.darkGold,
                    textColor: AppColors.darkGold,
                    borderWidth: 2,
                    iconColor: AppColors.darkGold,
                    onPressed: (){
                      Get.toNamed(AppRoutes.takeAttendance);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Text(
              AppStrings.hereInPdfHasYourQuestion ,style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 20),
            // PDF Attachment Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(Assets.icons.document),
                title: const Text('exam.pdf', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('2 MB'),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // Comment Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.comment_outlined, size: 20),
                    SizedBox(width: 5),
                    Text('02'),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    showCommentDialog();
                  },
                  icon: const Icon(Icons.add, size: 20, color: Colors.grey),
                  label: const Text('Add Comment', style: TextStyle(color: Colors.grey)),
                )
              ],
            ),

            // Comment List
            const CommentTile(),
            const CommentTile(),
          ],
        ),
      ),
    );
  }

  void showCommentDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Write Comment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              // Text Input Field
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "write comment here",
                  hintStyle: const TextStyle(color: AppColors.grey4E),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFF0F0F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Submit Button
              ButtonWidget(
                label: AppStrings.submit,
              gradient: AppColors.primaryButtonGradient,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  color: AppColors.greyB2,
                  child: CachedImageWidget(imageUrl: Dummy.profileImageUrl),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mr. Rahman', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreen, fontSize: 13)),
                  Text('19 Nov, 2026 | 12:00PM', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Hi Adam! Have you had the opportunity to view the media files that were sent over?',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}