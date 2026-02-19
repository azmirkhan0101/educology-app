import 'package:flutter/material.dart';

class ClassItemWidget extends StatelessWidget {
  final String title;
  final String liveTime;
  final String instructorName;
  final String postDate;
  final String instructorImageUrl;
  final int commentCount;

  const ClassItemWidget({
     super.key,
    required this.title,
    required this.liveTime,
    required this.instructorName,
    required this.postDate,
    required this.instructorImageUrl,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
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
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(instructorImageUrl),
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
              padding: EdgeInsets.symmetric(vertical: 8.0),
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
    );
  }
}