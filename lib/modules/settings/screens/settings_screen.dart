import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/settings/controllers/settings_controller.dart';
import 'package:dr_dina_educology/modules/profile/widgets/profile_menu_tile.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/button_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    bool isStaff = controller.role == Role.teacher || controller.role == Role.assistant;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(text: AppStrings.settings,
        fontSize: isTab ? 12.sp : 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          //==========CONNECT ZOOM IF STAFF AND IF ZOOM IS NOT CONNECTED=========
          if( isStaff )
          Obx((){
            if( controller.profileController.profileModel.value?.isZoomConnected ?? false ){
              return SizedBox.shrink();
            }
            return ProfileMenuTile(
                title: AppStrings.connectZoom,
                iconPath: "",
                isZoomIcon: true,
                onTap: (){
                  controller.connectZoom();
                }
            );
          }),
          ProfileMenuTile(
              title: AppStrings.changePassword,
              iconPath: Assets.icons.changePassword,
              onTap: (){
                Get.toNamed(AppRoutes.changePassword);
              }
              ),
          ProfileMenuTile(
              title: AppStrings.aboutUs,
              iconPath: Assets.icons.aboutUs,
              onTap: (){
                Get.toNamed(
                    AppRoutes.info,
                  arguments: InfoPageType.aboutUs
                );
              }
          ),
          ProfileMenuTile(
              title: AppStrings.termsConditions,
              iconPath: Assets.icons.terms,
              onTap: (){
                Get.toNamed(AppRoutes.info,
                  arguments: InfoPageType.termsAndConditions
                );
              }
          ),
          ProfileMenuTile(
              title: AppStrings.privacyPolicy,
              iconPath: Assets.icons.privacy,
              onTap: (){
                Get.toNamed(AppRoutes.info,
                  arguments: InfoPageType.privacyPolicy
                );
              }
          ),
          ProfileMenuTile(
              title: AppStrings.deleteAccount,
              iconPath: Assets.icons.deleteAccount,
              isDelete: true,
              onTap: (){
                showDeleteDialog();
              }
          ),
        ],
      ),
    );
  }

  //DELETE ACCOUNT DIALOG
  Future<void> showDeleteDialog() async{
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
                text: AppStrings.deleteAccount,
                fontColor: AppColors.secondaryDarkBlue,
                fontWeight: FontWeight.bold,
              ),
              const TextWidget(
                text: AppStrings.doYouWantToDeleteYourAccount,
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
                    label: AppStrings.delete,
                    fontSize: 14,
                    backgroundColor: CupertinoColors.destructiveRed,
                    onPressed: (){
                      controller.deleteAccount();
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
