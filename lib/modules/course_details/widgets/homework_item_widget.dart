import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeworkExamItemWidget extends StatelessWidget {
  final String title;
  final StaffModel staff;
  final DateTime startDate;
  final String startTime;
  final int commentCount;
  final DateTime endDate;
  final String endTime;
  final bool isStudent;
  final String? status;
  final VoidCallback? onClick;

  const HomeworkExamItemWidget({
    super.key,
    required this.title,
    required this.staff,
    required this.startDate,
    required this.startTime,
    required this.commentCount,
    required this.isStudent,
    required this.status,
    required this.endDate,
    required this.endTime,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {

    TaskStatus taskStatus = TaskStatus.values.firstWhereOrNull((element) => element.label2 == status) ?? TaskStatus.active;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryDarkBlue,
                    ),
                  ),
                  if( isStudent )
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: taskStatus.taskStatusColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: TextWidget(text: taskStatus.label, fontSize: 8, fontColor: Colors.white,),
                  )
                ],
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
                      child: CachedImageWidget(imageUrl: staff.image, iconSize: 30),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryGreen,
                        ),
                      ),
                      Text(
                        "${DateFormat("dd MMM yyyy").format(startDate)} | $startTime",
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
                          text: "${DateFormat("dd MMM yyyy").format(endDate)} | $endTime",
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
