import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../profile/widgets/photo_edit_widget.dart';

// --- Controller for state management ---
class SignupController extends GetxController {
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;
  var isAgreed = false.obs;

  void togglePassword() => isObscurePassword.toggle();
  void toggleConfirmPassword() => isObscureConfirmPassword.toggle();
  void toggleAgreement(bool? value) => isAgreed.value = value ?? false;
}

// --- Main Screen ---
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // AppBar(
            //   forceMaterialTransparency: true,
            //   toolbarHeight: 30,
            //   leading: IconButton(
            //       onPressed: (){
            //         Get.back();
            //   }, icon: Icon(Icons.arrow_back)
            //   ),
            // ),
            // Logo Section
            SvgPicture.asset(
              Assets.icons.appLogo, // Ensure path is correct
              height: 190.h,
              width: 225.w,
            ),
            const SizedBox(height: 5),

            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Create an ",
                          style: TextStyle(
                              color: AppColors.secondaryGreen,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      TextSpan(
                          text: "account",
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
              AppStrings.fillIn,
              style: TextStyle(color: AppColors.grey4E, fontSize: 16),
            ),
            const SizedBox(height: 12),

            PhotoEditWidget(
              imageUrl: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              onImagePicked: (image){

              },
            ),
            const SizedBox(height: 15,),
            // Form Fields
            _buildTextField(label: AppStrings.name, hint: AppStrings.enterYourName),
            const SizedBox(height: 10),
            _buildTextField(label: AppStrings.email, hint: AppStrings.enterYourEmail),
            const SizedBox(height: 10),
            _buildTextField(label: AppStrings.phone, hint: AppStrings.enterYourPhoneNumber), // Fixed hint from image
            const SizedBox(height: 10),

            // Password Field
            Obx(() => _buildTextField(
              label: AppStrings.newPassword,
              hint: AppStrings.enterYourPassword,
              isPassword: true,
              obscureText: controller.isObscurePassword.value,
              onToggle: controller.togglePassword,
            )),
            const SizedBox(height: 10),

            // Confirm Password Field
            Obx(() => _buildTextField(
              label: AppStrings.confirmPassword,
              hint: AppStrings.enterYourPassword,
              isPassword: true,
              obscureText: controller.isObscureConfirmPassword.value,
              onToggle: controller.toggleConfirmPassword,
            )),
            const SizedBox(height: 15),

            // Terms and Privacy Checkbox
            Obx(() => Row(
              children: [
                Checkbox(
                  value: controller.isAgreed.value,
                  onChanged: controller.toggleAgreement,
                  activeColor: const Color(0xFF2D5669),
                ),
                 Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree with this ',
                      children: [
                        TextSpan(
                          text: 'Terms of Use',
                          style: TextStyle(color: AppColors.secondaryDarkBlue, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                            ..onTap = (){
                            //TODO: SHOW TERMS
                        }
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: AppColors.secondaryDarkBlue, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                            ..onTap = (){
                            //TODO: SHOW POLICY
                            }
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 18),
            // Sign Up Button
            ButtonWidget(
                label: AppStrings.signUp,
              gradient: AppColors.primaryButtonGradient,
              onPressed: (){
                  Get.toNamed(AppRoutes.verifyEmail);
              },
            ),
            const SizedBox(height: 18),
            // Sign In Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.signIn);
                  },
                  child: const Text(
                    'Sign In',
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