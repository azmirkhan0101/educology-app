import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

// --- Controller for state management ---
class ForgotPasswordController extends GetxController {
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;
  var isAgreed = false.obs;

  void togglePassword() => isObscurePassword.toggle();
  void toggleConfirmPassword() => isObscureConfirmPassword.toggle();
  void toggleAgreement(bool? value) => isAgreed.value = value ?? false;
}

// --- Main Screen ---
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            //padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Logo Section
                      SvgPicture.asset(
                        Assets.icons.forgotPassword, // Ensure path is correct
                        height: 100.h,
                        width: 100.w,
                      ),
                      const SizedBox(height: 15),

                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Forgot your ",
                                    style: TextStyle(
                                        color: AppColors.secondaryGreen,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                TextSpan(
                                    text: "password?",
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
                      const TextWidget(
                        text: AppStrings.enterYourEmailAddress,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 12),

                      // Form Fields
                      _buildTextField(label: AppStrings.email, hint: AppStrings.enterYourEmail),
                      const Spacer(),
                      const SizedBox(height: 30,),
                      // Sign Up Button
                      ButtonWidget(
                        label: AppStrings.getVerificationCode,
                        gradient: AppColors.primaryButtonGradient,
                        onPressed: (){
                          Get.toNamed(AppRoutes.verifyEmail);
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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