import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/app_pages.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      // Gradient background to match the image
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Get.offAndToNamed(AppRoutes.onBoardingThree);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Color(0xFF647c90), fontSize: isTab ? 12.sp : 15),
                ),
              ),
            ),
            SizedBox(height: 60.h,),
            // Central SVG Image
            SvgPicture.asset(
              Assets.icons.onboardingTwo,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            SizedBox(height: 30.h,),
            //const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                   Text(
                    AppStrings.attendClasses,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTab ? 14.sp : 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF34547B),
                    ),
                  ),
                  const SizedBox(height: 15),
                   Text(
                    AppStrings.classStudentManagement,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTab ? 12.sp : 15,
                      color: Color(0xFF5E6D7E),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                   Text(
                    AppStrings.manageClasses,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTab ? 12.sp : 15,
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
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Page Indicator Dots
                            Row(
                              children: [
                                _buildDot(isActive: false),
                                _buildDot(isActive: true),
                                _buildDot(isActive: false),
                              ],
                            ),

                            // Floating Action Button
                            GestureDetector(
                              onTap: () {
                                Get.offAndToNamed(AppRoutes.onBoardingThree);
                              },
                              child: Container(
                                padding:  EdgeInsets.all( isTab ? 20 : 12),
                                decoration: const BoxDecoration(
                                    gradient: AppColors.primaryButtonGradient,
                                    shape: BoxShape.circle,
                                    //color: Color(0x00D4A36E),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      )
                                    ]
                                ),
                                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
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