import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/cached_image_widget.dart';

class UserCommentWidget extends StatelessWidget {
  final String comment;
  final String userImageUrl;
  final String userName;
  final DateTime dateTime;
  final VoidCallback? onReportTap; // Added callback parameter
  final bool isMyComment;

  const UserCommentWidget({
    super.key,
    required this.comment,
    required this.userImageUrl,
    required this.userName,
    required this.dateTime,
    this.onReportTap, // Added here
    required this.isMyComment
  });

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //================USER HEADER====================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added to push the menu button to the right
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: isTab ? 70 : 35.h,
                      width: isTab ? 70 : 35.w,
                      color: AppColors.greyEB,
                      child: CachedImageWidget(
                          imageUrl: userImageUrl,
                          iconSize: 26.r
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryGreen,
                            fontSize: isTab ? 10.sp : 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          DateFormat("dd MMM, yyyy | hh:mm a").format(dateTime.toLocal()),
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: isTab ? 9.sp : 11
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //================ THREE DOT MENU ====================
            if( !isMyComment )
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                size: isTab ? 32.r : 24.r, // Scale nicely across mobile/tablet
                color: Colors.grey.shade600,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(), // Removes default padding around the icon button
              onSelected: (value) {
                if (value == 'report' && onReportTap != null) {
                  onReportTap!();
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.report_outlined, color: Colors.red.shade700, size: isTab ? 22.r : 18.r),
                      const SizedBox(width: 8),
                      Text(
                        'Report',
                        style: TextStyle(
                          fontSize: isTab ? 12.sp : 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          comment,
          style: TextStyle(color: Colors.grey, fontSize: isTab ? 10.sp : 14),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}