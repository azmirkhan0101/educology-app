import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {

  String? _selectedRole;
  Role? role;

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              // Logo Section
              SvgPicture.asset(
                  Assets.icons.appLogo,
                  height: 150.h,
                width: 280.w,
              ),
              const SizedBox(height: 12),

              // Header Text
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          color: AppColors.secondaryGreen,
                          fontSize: isTab ? 18.sp : 26,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      TextSpan(
                          text: "educology",
                          style: TextStyle(
                              color: AppColors.secondaryDarkBlue,
                              fontSize: isTab ? 18.sp : 26,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                  )
              ),
              const SizedBox(height: 8),
               Text(
                AppStrings.manageYourClasses,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isTab ? 12.sp :  14, color: AppColors.grey4E),
              ),
              const SizedBox(height: 12),

               Text(
                AppStrings.selectYourRole,
                style: TextStyle(
                  fontSize: isTab ? 12.sp :  18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A6D65),
                ),
              ),
              const SizedBox(height: 20),

              // Role Options List
              Expanded(
                child: ListView(
                  children: [
                    _buildRoleCard('a Student', Assets.icons.student, (){
                      role = Role.student;
                    }),
                    _buildRoleCard('a Parent', Assets.icons.parents, (){
                      role = Role.parent;
                    }),
                    _buildRoleCard('a Teacher', Assets.icons.teacher, (){
                      role = Role.teacher;
                    }),
                    _buildRoleCard('an Assistant', Assets.icons.assistant, (){
                      role = Role.assistant;
                    }),
                  ],
                ),
              ),

              // Next Button
              ButtonWidget(
                  label: AppStrings.next,
                gradient: AppColors.primaryButtonGradient,
                isEnabled: _selectedRole != null,
                buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                onPressed: () async{
                    Get.toNamed(AppRoutes.signUp, arguments: role);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(String title, String assetPath, VoidCallback onSelect) {
    bool isSelected = _selectedRole == title;
    bool isTab = context.isTab;

    return GestureDetector(
      onTap: (){
        onSelect.call();
        setState(() => _selectedRole = title);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A6D65) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: isTab ? 90 : 60,
              height: isTab ? 90 : 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                  child: SvgPicture.asset(assetPath, fit: BoxFit.contain)),
            ),
            const SizedBox(width: 16),
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "I'm $title",
                    style: TextStyle(
                      fontSize: isTab ? 12.sp : 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF4A6D65) : Colors.grey[700],
                    ),
                  ),
                  Text(
                    'Sign in / Sign up as $title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: isTab ? 10.sp : 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}