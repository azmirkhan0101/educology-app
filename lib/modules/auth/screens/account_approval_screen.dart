import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';

class AccountApprovalScreen extends StatelessWidget {
  const AccountApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
          padding: EdgeInsets.symmetric( horizontal: 20),
          child: Column(
        children: [
          const SizedBox(height: 35,),
          SvgPicture.asset(
            Assets.icons.appLogo,
            height: 190.h,
            width: 225.w,
          ),
          const Spacer(),
          SvgPicture.asset(
            Assets.icons.accountPending,
            height: 120.h,
            width: 120.w,
          ),
          const SizedBox(height: 40,),
          TextWidget(
              text: AppStrings.accountPendingApproval,
            fontWeight: FontWeight.bold,
            fontSize: isTab ? 12.sp : 20,
          ),
          const SizedBox(height: 10,),
          TextWidget(
            text: AppStrings.yourAccountIs,
            fontSize: isTab ? 10.sp : 14,
            fontColor: AppColors.grey78,
          ),
          TextWidget(
            text: AppStrings.youWillBeAbleToAccess,
            fontSize: isTab ? 10.sp : 14,
            fontColor: AppColors.grey78,
          ),
          const Spacer(),
          ButtonWidget(
            label: AppStrings.gotIt,
            buttonWidth: isTab ? context.fullWidth * 0.3 : null,
          gradient: AppColors.primaryButtonGradient,
            onPressed: (){
              Get.toNamed(AppRoutes.signIn);
            },
          ),
          const SizedBox(height: 50,)
        ],
      )),
    );
  }
}
