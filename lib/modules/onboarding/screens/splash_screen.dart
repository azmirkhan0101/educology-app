import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {


    WidgetsBinding.instance.addPostFrameCallback((_){
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(AppRoutes.onBoardingOne);
      });
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                  Assets.icons.splashBlurTop,
                height: 237.h,
                width: 237.w,
              ),
            ],
          ),
          Center(
            child: SvgPicture.asset(
              Assets.icons.appLogo
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                  Assets.icons.splashBlurBottom,
                colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
                height: 237.h,
                width: 237.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
