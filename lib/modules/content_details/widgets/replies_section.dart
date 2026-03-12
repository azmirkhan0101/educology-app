import 'package:dr_dina_educology/data/models/comment/comment_model.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/user_comment_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class RepliesSection extends StatelessWidget {
  final List<CommentModel> replies;

  const RepliesSection({super.key, required this.replies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.greyEB,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(
            replies.length,
                (index){

              final CommentModel model = replies[index];

          return UserCommentWidget(
            comment: model.comment,
            userImageUrl: model.user!.image,
            userName: model.user!.fullName,
            dateTime: model.createdAt
          );
        }),
      )
    );
  }
}
