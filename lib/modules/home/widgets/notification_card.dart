import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isRead;
  final DateTime time;
  final VoidCallback onClick;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.isRead,
    required this.time,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    String displayTitle = title
    // Handle Capitalized versions
        .replaceAll('EXAM', 'Assessment')
        .replaceAll('HOMEWORK', 'Task')
        .replaceAll('CLASS', 'Module')
        .replaceAll('Exam', 'Assessment')
        .replaceAll('Homework', 'Task')
        .replaceAll('Class', 'Module')
        .replaceAll('Student', 'Learner')
    // Handle lowercase versions just in case
        .replaceAll('exam', 'assessment')
        .replaceAll('homework', 'task')
        .replaceAll('class', 'module');

    String displayDescription = description
        .replaceAll('parent', 'supervisor')
        .replaceAll('EXAM', 'Assessment')
        .replaceAll('HOMEWORK', 'Task')
        .replaceAll('CLASS', 'Module')
        .replaceAll('Exam', 'Assessment')
        .replaceAll('Homework', 'Task')
        .replaceAll('Class', 'Module')
        .replaceAll('exam', 'assessment')
        .replaceAll('homework', 'task')
        .replaceAll('class', 'module');

    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : const Color(0xFFF1FDF9), // Light mint background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(Assets.icons.notificationListIcon, height: isTab ? 35 : null, width: isTab ? 35 : null,),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: displayTitle, fontColor: AppColors.secondaryDarkBlue, fontWeight: FontWeight.bold, fontSize: isTab ? 12.sp : null,),
                  const SizedBox(height: 4),
                  Text(
                    displayDescription,
                    style: TextStyle(color: Color(0xFF546E7A), fontSize: isTab ? 10.sp : 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd MMM hh:mm a').format(time),
                    style: TextStyle(fontSize: isTab ? 8.sp : null, color: Color(0xFF4DB6AC), fontWeight: FontWeight.w500),
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