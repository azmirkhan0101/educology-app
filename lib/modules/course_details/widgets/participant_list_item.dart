import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ParticipantListItem extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final StudentStatus? status;
  final bool showDivider;

  const ParticipantListItem({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.status,
    this.showDivider = true
  });

  @override
  Widget build(BuildContext context) {
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
              height: 35.h,
              width: 35.r,
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff5A8A70),
                  ),
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                status!.iconPath,
                fit: BoxFit.cover,
                width: 10,
                height: 10,
              ),
              const SizedBox(width: 6),
              Text(
                status!.label2,
                style: TextStyle(
                  fontSize: 12,
                  color: status!.primaryColor,
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
