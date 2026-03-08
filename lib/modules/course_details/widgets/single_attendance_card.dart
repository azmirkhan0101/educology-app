import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

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

    AttendanceStatus attendanceStatus = AttendanceStatus.values.firstWhere((element) => element.label == status);

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
              style: const TextStyle(color: AppColors.grey4E, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              classTime,
              style: const TextStyle(color: AppColors.grey4E, fontSize: 13),
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
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}