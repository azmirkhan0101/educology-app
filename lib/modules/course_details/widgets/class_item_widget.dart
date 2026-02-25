import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassItemWidget extends StatelessWidget {
  final String title;
  final String liveTime;
  final String instructorName;
  final String postDate;
  final String instructorImageUrl;
  final int commentCount;
  final VoidCallback? onClick;

  const ClassItemWidget({
     super.key,
    required this.title,
    required this.liveTime,
    required this.instructorName,
    required this.postDate,
    required this.instructorImageUrl,
    required this.commentCount,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lecture Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF344E64), // Dark blue-grey
                ),
              ),
              const SizedBox(height: 8),
              // Live Class Time
              Text(
                'Live Class starting Time : $liveTime',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 5),
              // Instructor Row
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      color: Colors.grey.shade200,
                      child: CachedImageWidget(
                          imageUrl: instructorImageUrl,
                        iconSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        instructorName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF5A8F7B), // Muted green
                        ),
                      ),
                      Text(
                        postDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
              ),
              // Comments Footer
              Row(
                children: [
                  const Icon(Icons.comment_outlined, size: 20, color: Colors.black87),
                  const SizedBox(width: 8),
                  Text(
                    commentCount.toString().padLeft(2, '0'),
                    style: const TextStyle(fontWeight: FontWeight.w500),
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