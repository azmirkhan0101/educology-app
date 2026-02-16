import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../routes/app_pages.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // Gradient background to match the image
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100.h,),
            // Central SVG Image
            SvgPicture.asset(
              Assets.icons.onboardingThree,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            SizedBox(height: 30.h,),
            //const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    AppStrings.trackProgress,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34547B),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    AppStrings.submitHomework,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5E6D7E),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    AppStrings.everythingYouNeed,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5E6D7E),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            // Text Content Section
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.onboardingGradient
                  ),
              child: Column(
                children: [
                  Spacer(),
                  // Bottom Navigation (Dots + Floating Action Button)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page Indicator Dots
                        Row(
                          children: [
                            _buildDot(isActive: false),
                            _buildDot(isActive: false),
                            _buildDot(isActive: true),
                          ],
                        ),

                        // Floating Action Button
                        GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(AppRoutes.roleSelection);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryButtonGradient,
                                borderRadius: BorderRadius.circular(100),
                                //color: Color(0x00D4A36E),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ]
                            ),
                            child: Row(
                              spacing: 8.w,
                              children: [
                                const Text( AppStrings.getStarted, style: TextStyle( fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold),),
                            Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      //color: Color(0x00D4A36E),
                                  ),
                                  child: const Icon(Icons.arrow_forward, color: AppColors.primaryGold, size: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  // Helper widget for the pagination dots
  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 24 : 8, // Expanded width for the active dot
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF33526A) : AppColors.grey78,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}