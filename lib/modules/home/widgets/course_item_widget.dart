import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CourseItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String status;
  final int enrolledCount;

  const CourseItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.status,
    required this.enrolledCount,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 95.w,
                color: AppColors.greyB2,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.menu_book_sharp, size: 70.r, color: Colors.white),
                  ),
                ),
              )
            ),
            const SizedBox(width: 12),

            // Right: Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C5364), // Dark blue-grey
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F5FE), // Light blue background
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF0277BD), // Darker blue text
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    'Total Enrolled Student : $enrolledCount',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryGreen, //Muted green
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}