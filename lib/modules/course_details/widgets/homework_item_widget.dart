import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeworkItemWidget extends StatelessWidget {
  final String title;
  final String authorName;
  final String authorImageUrl;
  final String postDate;
  final String commentCount;
  final String dueDate;
  final VoidCallback? onClick;

  const HomeworkItemWidget({
    super.key,
    required this.title,
    required this.authorName,
    required this.authorImageUrl,
    required this.postDate,
    required this.commentCount,
    required this.dueDate,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryDarkBlue,
                ),
              ),
              const SizedBox(height: 6),

              // Author Row
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      color: Colors.grey.shade200,
                      child: CachedImageWidget(imageUrl: authorImageUrl, iconSize: 30),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryGreen,
                        ),
                      ),
                      Text(
                        postDate,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 3),

              // Divider
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 3),

              // Footer Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Comment Count
                  Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        size: 20,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        commentCount.toString().padLeft(2, '0'),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Due Date
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.secondaryDarkBlue,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: 'Due Date: '),
                        TextSpan(
                          text: dueDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.secondaryDarkBlue
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
