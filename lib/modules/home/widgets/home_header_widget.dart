import 'package:dr_dina_educology/core/assets_gen/fonts.gen.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/modules/main_nav/controllers/main_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/app_pages.dart';

class HomeHeaderWidget extends StatelessWidget {

  final String? profileImageUrl;
  final String? userName;
  final MainNavController controller = Get.isRegistered<MainNavController>() ? Get.find<MainNavController>() : Get.put(MainNavController());

  HomeHeaderWidget({
    super.key,
    required this.profileImageUrl,
    required this.userName
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              //Get.toNamed(AppRoutes.profile);
              controller.changeIndex(3);
            },
            child: Row(
              children: [
                Container(
                  width: isTab ? 70 : 45.w,
                  height: isTab ? 70 : 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.secondaryGreen, width: 2)
                  ),
                  child: ClipOval( child: buildProfileImage() ),
                ),
                const SizedBox(width: 12),
                // Welcome text and user name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Welcome Back!',
                        style: TextStyle(fontSize: isTab ? 12.sp : 13, color: AppColors.secondaryGreen, fontFamily: FontFamily.poppins)
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      userName == null || userName!.isEmpty ? "User"  : userName!,
                      style: TextStyle(fontSize: isTab ? 12.sp : 18, fontWeight: FontWeight.bold, fontFamily: FontFamily.poppins)
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Notification icon
          GestureDetector(
            onTap: (){
              //Get.toNamed(AppRoutes.notification);
              controller.changeIndex(1);
            },
            child: Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x199E9E9E),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(Assets.icons.notification,),
            ),
          ),
        ],
      ),
    );
  }


  //BUILD PROFILE IMAGE
  Widget buildProfileImage() {
    if ( profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return CachedImageWidget(
          imageUrl: profileImageUrl!,
        iconSize: 30,
      );
    }
    //return Icon(Icons.business, size: 50.r, color: Colors.grey);
    return Icon(Icons.person, size: 30.r, color: Colors.grey);
  }
}
