import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_gen/assets.gen.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isDelete;
  final bool isZoomIcon;

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isDelete = false,
    this.isZoomIcon = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: isDelete ? AppColors.red10Percent : const Color(0xFFF1FDF8), // Light mint background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        leading: isZoomIcon ? ClipRRect(borderRadius: BorderRadius.circular(50),
          child: Container(
            color: AppColors.secondaryDarkBlue,
            height: 22.h,
            width: 22.w,
            child: Icon(Icons.videocam_rounded, color: Colors.white, size: 15.r,),
          ),
        ) : SvgPicture.asset( iconPath ),
        title: TextWidget(text: title, textAlignment: TextAlign.left,),
        trailing: SvgPicture.asset(Assets.icons.rightTriangle),
        onTap: onTap,
      ),
    );
  }
}