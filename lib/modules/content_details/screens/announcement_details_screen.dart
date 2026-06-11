import 'package:dr_dina_educology/modules/content_details/controllers/announce_details_controller.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/document_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/cached_image_widget.dart';
import '../../../core/widgets/showCommentDialog.dart';
import '../../../data/models/comment/comment_model.dart';
import '../widgets/comment_tile_widget.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  AnnouncementDetailsScreen({super.key});

  final AnnounceDetailsController controller =
      Get.find<AnnounceDetailsController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black87, size: isTab ? 30 : null,),
        ),
        title: Text(
          'Announcement',
          style: TextStyle(
            color: Color(0xFF344E6D),
            fontWeight: FontWeight.bold,
            fontSize: isTab ? 12.sp : 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //=====================Announcement Card======================
            Container(
              height: 250.h,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserHeader(
                      name: controller.announceModel.teacher.fullName,
                      dateTime: controller.announceModel.createdAt,
                      imageUrl: controller.announceModel.teacher.image,
                    ),
                    const SizedBox(height: 10),
                    Html(
                      data: controller.announceModel.announce,
                      style: {
                        "body": Style(
                          fontSize: FontSize( isTab ? 10.sp : 14),
                          lineHeight: const LineHeight(1.6),
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        "h1": Style(fontSize: FontSize(22)),
                        "h2": Style(fontSize: FontSize(18)),
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //========================QUESTION PDF SECTION========================
            if (controller.announceModel.document.isNotEmpty)
              DocumentItemWidget(pdfUrl: controller.announceModel.document),
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
                      Icon(
                        Icons.chat_bubble_outline,
                        size: isTab ? 30 : 20,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 8),
                      Obx(() {
                        return Text(
                          controller.comments.value.length.toString().padLeft(
                            2,
                            '0',
                          ),
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: isTab ? 10.sp : null
                          ),
                        );
                      }),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showCommentDialog(
                        isTab: isTab,
                        title: 'Write a comment',
                        subTitle: 'write your comment here...',
                        controller: controller.commentController,
                        onSubmit: (value) {
                          controller.postComment(comment: value);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      size: isTab ? 30 : 20,
                      color: Colors.black54,
                    ),
                    label: Text(
                      'Add Comment',
                      style: TextStyle( fontSize: isTab ? 10.sp : null, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),

            //============================COMMENTS LIST SECTION========================
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final CommentModel comment =
                        controller.comments.value[index];

                    return CommentTileWidget(
                      comment: comment,
                      onReply: () {
                        showCommentDialog(
                          isTab: isTab,
                          title: 'Write a reply',
                          subTitle: 'write your reply here...',
                          controller: controller.commentController,
                          onSubmit: (value) {
                            controller.postReply(
                              commentIndex: index,
                              reply: value,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }),
            ),
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
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: isTab ? 70 : 35.h,
            width: isTab ? 70 : 35.w,
            color: AppColors.greyB2,
            child: CachedImageWidget(imageUrl: imageUrl, iconSize: 26.r),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF689F7D),
                // Matching the green tint in the image
                fontSize: isTab ? 10.sp : 14,
              ),
            ),
            Text(
              DateFormat("dd MMM, yyyy | hh:mm a").format(dateTime.toLocal()),
              style: TextStyle(color: Colors.grey, fontSize: isTab ? 9.sp : 10),
            ),
          ],
        ),
      ],
    );
  }
}
