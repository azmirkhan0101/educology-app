import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/assets_gen/assets.gen.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final int count;
  final String subject;
  final String timeAgo;

  const NotificationCard({
    super.key,
    this.title = "New Homework Submission",
    this.count = 3,
    this.subject = "Grade 10 – Mathematics",
    this.timeAgo = "16 minutes ago",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FDF9), // Light mint background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.icons.notificationListIcon),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: title, fontColor: AppColors.secondaryDarkBlue, fontWeight: FontWeight.bold,),
                const SizedBox(height: 4),
                Text(
                  '$count students submitted homework for "$subject"',
                  style: const TextStyle(color: Color(0xFF546E7A), fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(color: Color(0xFF4DB6AC), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}