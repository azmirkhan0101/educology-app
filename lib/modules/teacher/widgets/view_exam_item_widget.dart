import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';

class ViewExamItemWidget extends StatelessWidget {
  final String title;
  final String deadline;
  final int marksObtained;
  final int totalMarks;
  final String feedback;
  final String instructorName;
  final String date;
  final String imageUrl;
  final VoidCallback onViewAnswer;

  const ViewExamItemWidget({
    super.key,
    required this.title,
    required this.deadline,
    required this.marksObtained,
    required this.totalMarks,
    required this.feedback,
    required this.instructorName,
    required this.date,
    required this.imageUrl,
    required this.onViewAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title and Status Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C4E68),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Exam",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Submitted on time",
                  style: TextStyle(color: Color(0xFF2E7D32), fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Deadline: $deadline",
            style: const TextStyle(color: Color(0xFF2C4E68), fontWeight: FontWeight.w500),
          ),
          Divider(thickness: 0.8),

          // Marks and Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Marks : $marksObtained/$totalMarks",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C4E68),
                ),
              ),
              ButtonWidget(
                  onPressed: onViewAnswer,
                  label: AppStrings.viewAnswer,
                buttonHeight: 40,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                backgroundColor: const Color(0xFF34546D),
              ),
            ],
          ),
          // Feedback Section
          Text(
            feedback,
            style: const TextStyle(fontSize: 14, color: Color(0xFF2C4E68)),
          ),
          const SizedBox(height: 12),

          // Instructor Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: Colors.grey.shade400,
                  child: CachedImageWidget(
                      imageUrl: imageUrl,
                    iconSize: 30,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instructorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D8A75),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}