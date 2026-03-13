import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/cached_image_widget.dart';

class StaffInfoWidget extends StatelessWidget {

  final StaffModel staff;
  final DateTime createdAt;

  const StaffInfoWidget({
    super.key,
    required this.staff,
    required this.createdAt
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 35.h,
            width: 35.w,
            color: AppColors.greyB2,
            child: CachedImageWidget(
              imageUrl: staff.image,
              iconSize: 30.r,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                staff.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryGreen,
                ),
              ),
              Text(
                DateFormat("dd MMM yyyy | hh:mm a").format(
                  createdAt.toLocal(),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade200,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: const Text('Missing', style: TextStyle(color: Colors.grey, fontSize: 12)),
        // ),
      ],
    );
  }
}
