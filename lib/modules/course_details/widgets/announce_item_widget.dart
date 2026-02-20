import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/cached_image_widget.dart';

class AnnounceItemWidget extends StatelessWidget {
  final String userName;
  final String profileImageUrl;
  final String dateTime;
  final String message;
  final int commentCount;

  const AnnounceItemWidget({
    super.key,
    required this.userName,
    required this.profileImageUrl,
    required this.dateTime,
    required this.message,
    required this.commentCount
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar and Name/Date
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Colors.grey.shade200,
                    child: CachedImageWidget(imageUrl: "", iconSize: 30),
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryGreen, // Subtle green from image
                      ),
                    ),
                    Text(
                      '$dateTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Body: The Message
            Text(
              message,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF4A4A4A),
              ),
            ),

            const Divider(thickness: 1, color: Color(0xFFEEEEEE)),

            // Footer: Comments
            Row(
              children: [
                const Icon(Icons.comment_outlined, size: 16, color: Colors.black87),
                const SizedBox(width: 8),
                Text(
                  commentCount.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}