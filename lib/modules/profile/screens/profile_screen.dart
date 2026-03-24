import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:dr_dina_educology/modules/profile/widgets/add_parent_tile.dart';
import 'package:dr_dina_educology/modules/profile/widgets/profile_menu_tile.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/widgets/button_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {

    bool isStudent = controller.role == Role.student;

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
          //===================PROFILE IMAGE========================
          Container(
            padding: EdgeInsets.all(2),
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: AppColors.greyEB,
              borderRadius: BorderRadius.circular(15)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx((){
                return CachedImageWidget(
                    imageUrl: controller.profileImageUrl.value
                );
              }),
            ),
          ),
            SizedBox(height: 10,),
            //===================NAME======================
            Obx((){
              return TextWidget(
                text: controller.profileModel.value?.fullName ?? "",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.secondaryDarkBlue,
              );
            }),
            SizedBox(height: 10,),
            //========================EMAIL=====================
            Row(
              spacing: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    Assets.icons.email,
                  colorFilter: ColorFilter.mode(AppColors.secondaryGreen, BlendMode.srcIn),
                ),
                Obx((){
                  return TextWidget(
                    text: controller.profileModel.value?.email ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.secondaryGreen,
                  );
                }),
              ],
            ),
            SizedBox(height: 8,),
            Center(child: TextWidget(text: controller.profileModel.value?.about ?? "")),
            SizedBox(height: 15,),
            //========================ADD PARENT TILE IF STUDENT==========================
            if( isStudent )
              Obx((){
                return AddParentTile(
                    title: AppStrings.myParent,
                    iconPath: Assets.icons.myParent,
                    parent: controller.profileModel.value?.parent,
                    onTap: (){
                      Get.toNamed(AppRoutes.addParent);
                    }
                );
              }),
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
            // ProfileMenuTile(
            //     title: AppStrings.settings,
            //     iconPath: Assets.icons.settings,
            //     onTap: (){
            //       Get.toNamed(AppRoutes.settings);
            //     }
            // ),
            ProfileMenuTile(
                title: AppStrings.logout,
                iconPath: Assets.icons.logout,
                onTap: (){
                  showLogOutDialog();
                }
            ),
            SizedBox( height: 60,)
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
                    onPressed: (){
                      controller.logOut();
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
