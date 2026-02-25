import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  const AnnouncementDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black87)),
        title: const Text(
          'Announcement',
          style: TextStyle(color: Color(0xFF344E6D), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Announcement Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _UserHeader(
                    name: 'Rakibul Hasan',
                    date: '19 Nov, 2026 | 12:00PM',
                    imageUrl: 'https://i.pravatar.cc/150?u=rakibul',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Dear Students, \nPlease be informed that the class will be conducted as per the regular schedule. Attendance is mandatory. Kindly be punctual and bring all required materials." * 4,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(height: 100), // Spacing to match the image layout
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(height: 1),

            // Interaction Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.chat_bubble_outline, size: 20, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('02', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showCommentDialog();
                    },
                    icon: const Icon(Icons.add, size: 20, color: Colors.black54),
                    label: const Text('Add Comment', style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
            ),

            // Bottom List Items
            const _CommentItem(
              name: 'Mr. Rahman',
              date: '19 Nov, 2026 | 12:00PM',
              message: 'Hi Adam! Have you had the opportunity to view the media files that were sent over?',
            ),
            const SizedBox(height: 12),
            const _CommentItem(
              name: 'Mr. Rahman',
              date: '19 Nov, 2026 | 12:00PM',
              message: 'Hi Adam! Have you had the opportunity to view the media files that were sent over?',
            ),
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

/// Custom Widget for User Header (Avatar + Name + Date)
class _UserHeader extends StatelessWidget {
  final String name;
  final String date;
  final String imageUrl;

  const _UserHeader({
    required this.name,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF689F7D), // Matching the green tint in the image
                fontSize: 14,
              ),
            ),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

/// Custom Widget for the Bottom List Items (Comments)
class _CommentItem extends StatelessWidget {
  final String name;
  final String date;
  final String message;

  const _CommentItem({
    required this.name,
    required this.date,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _UserHeader(
                name: name,
                date: date,
                imageUrl: 'https://i.pravatar.cc/150?u=rahman',
              ),
              const Icon(Icons.more_vert, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}