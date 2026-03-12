import 'package:dr_dina_educology/modules/content_details/controllers/announce_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/cached_image_widget.dart';
import '../../../core/widgets/showCommentDialog.dart';
import '../../../data/models/comment/comment_model.dart';
import '../widgets/comment_tile_widget.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  AnnouncementDetailsScreen({super.key});

  final AnnounceDetailsController controller = Get.find<AnnounceDetailsController>();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //=====================Announcement Card======================
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   UserHeader(
                    name: controller.announceModel.teacher.fullName,
                    dateTime: controller.announceModel.createdAt,
                    imageUrl: controller.announceModel.teacher.image,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.announceModel.announce,
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
            //=====================COMMENT COUNT | ADD COMMENT=========================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 20, color: Colors.black54),
                      SizedBox(width: 8),
                      Text(controller.announceModel.comments.length.toString().padLeft(2, '0'), style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showCommentDialog(
                          title: 'Write a comment',
                          subTitle: 'write your comment here...',
                          controller: controller.commentController,
                          onSubmit: (value) {
                            print("Got the comment: $value");
                          },
                      );
                    },
                    icon: const Icon(Icons.add, size: 20, color: Colors.black54),
                    label: const Text('Add Comment', style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
            ),

            //============================COMMENTS LIST SECTION========================
            Expanded(
              child: ListView.builder(
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {

                  final CommentModel comment = controller.comments[index];

                  return CommentTileWidget(
                      comment: comment
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  final String name;
  final DateTime dateTime;
  final String imageUrl;

  const UserHeader({
    required this.name,
    required this.dateTime,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 35.h,
            width: 35.w,
            color: AppColors.greyB2,
            child: CachedImageWidget(
                imageUrl: imageUrl,
                iconSize: 26.r
            ),
          ),
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
              DateFormat("dd MMM, yyyy | hh:mm a").format(dateTime.toLocal()),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}