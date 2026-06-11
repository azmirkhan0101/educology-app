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

  const UserCommentWidget({
    super.key,
    required this.comment,
    required this.userImageUrl,
    required this.userName,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //================USER====================
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: isTab ? 70 : 35.h,
                width:  isTab ? 70 : 35.w,
                color: AppColors.greyEB,
                child: CachedImageWidget(
                    imageUrl: userImageUrl,
                    iconSize: 26.r
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryGreen,
                    fontSize: isTab ? 10.sp : 13,
                  ),
                ),
                Text(
                  DateFormat("dd MMM, yyyy | hh:mm a").format(dateTime.toLocal()),
                  style: TextStyle(color: Colors.grey.shade500, fontSize: isTab ? 9.sp : 11),
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
        SizedBox(height: 4),
      ],
    );
  }
}
