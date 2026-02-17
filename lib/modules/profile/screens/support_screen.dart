import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: TextWidget(
            text: AppStrings.support,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_sharp)
        ),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icons.appLogo,
            height: 125.h,
              width: 190.w,
            ),
            SvgPicture.asset(
              Assets.icons.supportGraphics,
              height: 240.h,
              width: 263.w,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: AppColors.secondaryDarkBlue,),
                    SizedBox(width: 10,),
                    TextWidget(
                      text: AppStrings.email,
                      fontSize: 14,
                      fontColor: AppColors.secondaryDarkBlue,
                    )
                  ],
                ),
                TextWidget(
                  text: "azmir.azamkhan@gmail.com",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.secondaryDarkBlue,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: AppColors.secondaryDarkBlue,),
                    SizedBox(width: 10,),
                    TextWidget(
                      text: AppStrings.phone,
                      fontSize: 14,
                      fontColor: AppColors.secondaryDarkBlue,
                    )
                  ],
                ),
                TextWidget(
                  text: "+8801609-537568",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.secondaryDarkBlue,
                ),
              ],
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
      ),
    );
  }
}
