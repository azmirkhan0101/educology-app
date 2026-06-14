import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/extensions.dart';

class ClassItemWidget extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final String startTime;
  final DateTime createdAt;
  final StaffModel staff;
  final int commentCount;
  final VoidCallback? onClick;

  const ClassItemWidget({
     super.key,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.createdAt,
    required this.staff,
    required this.commentCount,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isTab ? 12.sp : 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF344E64),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Live module starting Time : ${DateFormat("dd MMM yyyy").format(startDate.toLocal())} | $startTime',
                style: TextStyle(
                  fontSize: isTab ? 9.sp : 12,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 5),
              // Instructor Row
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: isTab ? 70 : 35.h,
                      width: isTab ? 70 : 35.w,
                      color: Colors.grey.shade200,
                      child: CachedImageWidget(
                          imageUrl: staff.image,
                        iconSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff.fullName,
                        style: TextStyle(
                          fontSize: isTab ? 10.sp : 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF5A8F7B),
                        ),
                      ),
                      Text(
                        DateFormat("dd MMM yyyy | hh:mm a").format(createdAt.toLocal()),
                        style: TextStyle(
                          fontSize: isTab ? 9.sp : 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
              ),
              // Comments Footer
              Row(
                children: [
                   Icon(Icons.comment_outlined, size: isTab ? 30 : 20, color: Colors.black87),
                  const SizedBox(width: 8),
                  Text(
                    commentCount.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: isTab ? 10.sp : null, fontWeight: FontWeight.w500),
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