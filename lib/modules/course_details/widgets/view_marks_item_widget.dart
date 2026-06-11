import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/extensions.dart';

class ViewMarksItemWidget extends StatelessWidget {
  final String status;
  final String title;
  final String deadline;
  final int marksObtained;
  final String feedback;
  final String instructorName;
  final DateTime postedAt;
  final String imageUrl;
  final VoidCallback onViewAnswer;
  final bool isMarked;

  const ViewMarksItemWidget({
    super.key,
    required this.title,
    required this.deadline,
    required this.marksObtained,
    required this.feedback,
    required this.instructorName,
    required this.postedAt,
    required this.imageUrl,
    required this.onViewAnswer,
    required this.status,
    required this.isMarked
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    AnswerSubmissionStatus submissionStatus = AnswerSubmissionStatus.values
        .firstWhere((element) => element.label2 == status);

    bool showNotSubmitMsg = submissionStatus.label2 == "Not Submitted" || submissionStatus.label2 == "Missing";
    bool showResultNotPublishedMsg = !showNotSubmitMsg && !isMarked;
    bool showMarksSection = !showNotSubmitMsg && isMarked;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(2, 4),
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
                      style: TextStyle(
                        fontSize: isTab ? 12.sp : 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C4E68),
                      ),
                    ),
                    const SizedBox(height: 4),
                     Text(
                      "Exam",
                      style: TextStyle(color: Colors.grey, fontSize: isTab ? 10.sp : 16),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: submissionStatus.statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  submissionStatus.label,
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: isTab ? 9.sp : 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            deadline,
            style: TextStyle(
              fontSize: isTab ? 9.sp : null,
              color: Color(0xFF2C4E68),
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(thickness: 0.8),

          if( showNotSubmitMsg )
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  "You did not attend or submit this exam",
                  style: TextStyle(color: Colors.yellow.shade900, fontSize: isTab ? 9.sp : 14, fontWeight: FontWeight.w500,),
                ),
              ),
            ),
          if( showResultNotPublishedMsg )
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  "Result will be published soon",
                  style: TextStyle(color: AppColors.primaryGold, fontSize: isTab ? 10.sp : 14, fontWeight: FontWeight.w500,),
                ),
              ),
            ),
          if( showMarksSection )
            marksSection(isTab),
        ],
      ),
    );
  }

  //MARKS SECTION
  Widget marksSection(bool isTab) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Marks : $marksObtained",
              style: TextStyle(
                fontSize: isTab ? 10.sp : 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C4E68),
              ),
            ),
            ButtonWidget(
              fontSize: 14,
              onPressed: onViewAnswer,
              label: AppStrings.viewAnswer,
              buttonHeight: 38,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              backgroundColor: const Color(0xFF34546D),
            ),
          ],
        ),
        // Feedback Section
        Text(
          feedback,
          style: TextStyle(fontSize: isTab ? 10.sp : 14, color: Color(0xFF2C4E68)),
        ),
        const SizedBox(height: 12),

        // Instructor Info
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: isTab ? 70 : 35.h,
                width: isTab ? 70 : 35.w,
                color: Colors.grey.shade400,
                child: imageUrl.isNotEmpty
                    ? CachedImageWidget(imageUrl: imageUrl, iconSize: 30)
                : SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructorName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D8A75),
                    fontSize: isTab ? 10.sp : 16,
                  ),
                ),
                Text(
                  DateFormat("dd MMM yyyy hh:mm a").format(postedAt),
                  style: TextStyle(color: Colors.grey, fontSize: isTab ? 10.sp : 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
