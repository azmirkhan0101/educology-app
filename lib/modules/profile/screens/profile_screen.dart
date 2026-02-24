import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/profile/widgets/add_parent_tile.dart';
import 'package:dr_dina_educology/modules/profile/widgets/profile_menu_tile.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/assets_gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/widgets/button_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final storage = GetStorage();
  final RoleService roleService = Get.find<RoleService>();

  @override
  Widget build(BuildContext context) {

    Role role = roleService.role;
    bool isStudent = role == Role.student;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(text: AppStrings.profile,
        fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.all(2),
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: AppColors.primaryGold,
              borderRadius: BorderRadius.circular(15)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedImageWidget(
                imageUrl: Dummy.profileImageUrl
              ),
            ),
          ),
            SizedBox(height: 10,),
            TextWidget(
                text: "Azmir Khan",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontColor: AppColors.secondaryDarkBlue,
            ),
            SizedBox(height: 10,),
            Row(
              spacing: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    Assets.icons.email,
                  colorFilter: ColorFilter.mode(AppColors.secondaryGreen, BlendMode.srcIn),
                ),
                TextWidget(
                  text: "azmir.azamkhan@gmail.com",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.secondaryGreen,
                ),
              ],
            ),
            SizedBox(height: 20,),
            if( isStudent )
            AddParentTile(
                title: AppStrings.myParent,
                iconPath: Assets.icons.myParent,
                parents: [
                  "Hello"
                ],
                onTap: (){
                  Get.toNamed(AppRoutes.addParent);
                }
            ),
            ProfileMenuTile(
                title: AppStrings.editProfile,
                iconPath: Assets.icons.editProfile,
                onTap: (){
                  Get.toNamed(AppRoutes.editProfile);
                }
                ),
            ProfileMenuTile(
                title: AppStrings.support,
                iconPath: Assets.icons.support,
                onTap: (){
                  Get.toNamed(AppRoutes.support);
                }
            ),
            ProfileMenuTile(
                title: AppStrings.settings,
                iconPath: Assets.icons.settings,
                onTap: (){
                  Get.toNamed(AppRoutes.settings);
                }
            ),
            ProfileMenuTile(
                title: AppStrings.logout,
                iconPath: Assets.icons.logout,
                onTap: (){
                  showLogOutDialog();
                }
            ),
            SizedBox( height: 20,)
          ],
        ),
      ),
    );
  }

  //SHOW LOGOUT DIALOG
  Future<void> showLogOutDialog() async{
    Get.dialog(
        AlertDialog(
          backgroundColor: AppColors.greyB2,
          content: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.destructiveRed,
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(100)
                  ),
                  child: Icon(Icons.exit_to_app, color: AppColors.white, fontWeight: FontWeight.bold, size: 28,),
                ),
              ),
              const TextWidget(
                text: AppStrings.logOut,
                fontColor: AppColors.secondaryDarkBlue,
                fontWeight: FontWeight.bold,
              ),
              const TextWidget(
                text: AppStrings.doYouWantToLogOut,
                fontColor: AppColors.grey4E,
                fontSize: 14,
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actions: [
            Row(
              spacing: 4,
              children: [
                Expanded(
                  child: ButtonWidget(
                    buttonHeight: 40,
                    label: AppStrings.cancel,
                    fontSize: 14,
                    backgroundColor: AppColors.secondaryDarkBlue,
                    onPressed: (){
                      Get.back();
                    },
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    buttonHeight: 40,
                    label: AppStrings.logOut,
                    fontSize: 14,
                    gradient: AppColors.primaryButtonGradient,
                    onPressed: () async{
                      await storage.erase();
                      Get.back();
                      Get.offAllNamed(AppRoutes.signIn);
                    },
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
