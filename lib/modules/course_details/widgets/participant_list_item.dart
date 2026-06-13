import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/extensions.dart';

class ParticipantListItem extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final String? studentStatus;
  final bool showDivider;

  const ParticipantListItem({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.studentStatus,
    this.showDivider = true
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    StudentStatus? status;

    if( studentStatus != null ){
      status = StudentStatus.values.firstWhere((element) => element.label3 == studentStatus);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: showDivider ? Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)) : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: isTab ? 70 : 35.h,
              width:  isTab ? 70 : 35.w,
              color: Colors.grey.shade200,
              child: CachedImageWidget(imageUrl: imageUrl, iconSize: 26),
            ),
          ),
          const SizedBox(width: 8),

          // 2. Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: isTab ? 10.sp : 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff5A8A70),
                  ),
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(fontSize: isTab ? 9.sp : 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // 3. Status Indicator
          if( status != null )
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                status.iconPath,
                fit: BoxFit.cover,
                width: isTab ? 15 : 10,
                height: isTab ? 15 : 10,
              ),
              const SizedBox(width: 6),
              Text(
                status.label2,
                style: TextStyle(
                  fontSize: isTab ? 9.sp : 12,
                  color: status.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
