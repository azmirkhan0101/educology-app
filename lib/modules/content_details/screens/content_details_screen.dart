import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/modules/content_details/controllers/content_details_controller.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentDetailsScreen extends StatelessWidget {
  ContentDetailsScreen({super.key});

  final ContentDetailsController controller = Get.find<ContentDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          controller.appTitle,
          style: TextStyle(color: Color(0xFF2E5B71), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header Section
            const Text(
              '1st Exam Algebra – Linear Equations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5B71),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Due Date: 12 Nov, 25  10:00 AM',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Teacher Row
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image
                  radius: 20,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr. Rahman',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
            const SizedBox(height: 30),
            // Submit Button
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 5,
              children: [
                Expanded(
                  child: ButtonWidget(
                    buttonHeight: 45,
                    label: AppStrings.startClass,
                    gradient: AppColors.primaryButtonGradient,
                    prefixIcon: Icons.timer,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    buttonHeight: 45,
                    label: AppStrings.attendance,
                    fontSize: 14,
                    prefixIcon: Icons.calendar_today_outlined,
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

            const SizedBox(height: 25),
            const Text(
              'Here In pdf has your question. Check this question. And provide your Answer in a pdf with in due time. After due time any one cannot submit there answer',
              style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 20),
            // PDF Attachment Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.blue),
                ),
                title: const Text('RKAKL2021.Pdf', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('2 MB'),
              ),
            ),

            const SizedBox(height: 40),
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
              const CircleAvatar(radius: 15, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mr. Rahman', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 13)),
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