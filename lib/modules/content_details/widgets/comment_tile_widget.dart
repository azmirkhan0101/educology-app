import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/replies_section.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/user_comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/comment/comment_model.dart';

class CommentTileWidget extends StatelessWidget {

  final CommentModel comment;
  final VoidCallback onReply;
  final RxBool isExpanded = false.obs;
  final bool isMyComment;
  final VoidCallback? onReportTap;
  final Function(int index)? onReplyReportTap;

  CommentTileWidget({
    super.key,
    required this.comment,
    required this.onReply,
    required this.isMyComment,
    this.onReportTap,
    this.onReplyReportTap
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

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
          UserCommentWidget(
            comment: comment.comment,
            userImageUrl: comment.user?.image ?? "",
            userName: comment.user?.fullName ?? "",
            dateTime: comment.createdAt,
            isMyComment: isMyComment,
            onReportTap: onReportTap,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryButtonGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                  onPressed: () {
                    onReply();
                  },
                  child: Text(
                    "Add reply",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isTab ? 10.sp : null
                    ),
                  ),
                ),
              ),
              if(comment.replies.isNotEmpty)
                Obx((){
                  return TextButton(
                    onPressed: (){
                      isExpanded.toggle();
                    },
                    child: TextWidget(
                      text: isExpanded.value ? "Hide replies" : "View replies",
                      fontColor: AppColors.primaryGold,
                      fontWeight: FontWeight.w700,
                      fontSize: isTab ? 10.sp : null,
                    ),
                  );
                }),
            ],
          ),
          if(comment.replies.isNotEmpty)
            Obx((){
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded.value && comment.replies.isNotEmpty
                    ? Column(
                  children: [
                    const Divider().paddingSymmetric(vertical: 8),
                    RepliesSection(
                      replies: comment.replies,
                      isMyComment: isMyComment,
                      onReplyReportTap :(index){
                        onReplyReportTap?.call(index);
                      },
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
              );
            }),
        ],
      ),
    );
  }
}
