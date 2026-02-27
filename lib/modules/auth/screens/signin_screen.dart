import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/auth/controllers/signin_controller.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SigninController controller = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        toolbarHeight: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Logo Section
            SvgPicture.asset(
              Assets.icons.appLogo,
              height: 190.h,
              width: 225.w,
            ),
            const SizedBox(height: 5),

            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Welcome to ",
                          style: TextStyle(
                              color: AppColors.secondaryGreen,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      TextSpan(
                          text: "educology",
                          style: TextStyle(
                              color: AppColors.secondaryDarkBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                )
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.signInToAccessYourAccount,
              style: TextStyle(color: AppColors.grey4E, fontSize: 15),
            ),
            const SizedBox(height: 12),

            // Form Fields
            _buildTextField(label: AppStrings.email, hint: AppStrings.enterYourEmail),
            const SizedBox(height: 10),
            // Password Field
            CustomTextField(
              controller: controller.passwordController,
              hintText: AppStrings.password,
              isPassword: true,
              suffixIcon: Assets.icons.eyeHide,
              obscureCharacter: "*",
              hintStyle: const TextStyle(color: AppColors.grey4E, fontSize: 15),
              inputTextStyle: const TextStyle(color: AppColors.grey4E, fontSize: 15),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Colors.black,
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Get.toNamed(AppRoutes.forgotPassword);
                },
                child: TextWidget(
                    text: AppStrings.forgotPassword,
                  fontSize: 14,
                  fontColor: AppColors.grey92,
                ),
              ),
            ),
            const SizedBox(height: 25,),
            //Sign Up Button
            ButtonWidget(
              label: AppStrings.signIn,
              gradient: AppColors.primaryButtonGradient,
              onPressed: (){
                Get.toNamed(AppRoutes.accountApproval);
              },
            ),
            const SizedBox(height: 18),
            // Sign In Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signUp);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: AppColors.secondaryDarkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper method for text fields to keep code clean
  Widget _buildTextField({
    required String label,
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}