import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/extensions.dart';

class SingleAttendanceCard extends StatelessWidget {
  final String className;
  final String classTime;
  final String status;

  const SingleAttendanceCard({
    super.key,
    required this.className,
    required this.classTime,
    required this.status
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    AttendanceStatus attendanceStatus = AttendanceStatus.values.firstWhere((element) => element.label2 == status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.greyEB.withValues(alpha: 0.5),
        border: Border(bottom: BorderSide(color: AppColors.greyEB)),
      ),
      child: Row(
        spacing: 3,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              maxLines: 2,
              className,
              style: TextStyle(color: AppColors.grey4E, fontSize: isTab ? 10.sp : 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              classTime,
              style: TextStyle(color: AppColors.grey4E, fontSize: isTab ? 9.sp : 13),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              attendanceStatus.label,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: attendanceStatus.statusColor,
                fontWeight: FontWeight.w500,
                fontSize: isTab ? 10.sp : 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}