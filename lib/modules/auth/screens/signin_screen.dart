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
import '../../../core/utils/app_validator.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SigninController controller = Get.find<SigninController>();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    controller.setFormKey(signInFormKey);

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
        child: Form(
          key: signInFormKey,
          child: Column(
            children: [
              // Logo Section
              SvgPicture.asset(
                Assets.icons.appLogo,
                height: 150.h,
                width: 200.w,
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

              //=========================EMAIL====================================
              CustomTextField(
                label: AppStrings.email,
                hintText: AppStrings.enterYourEmail.tr,
                controller: controller.emailController,
                validator: (value){
                  if( value == null || value.isEmpty ){
                    return "Email is required";
                  }
                  if( !isEmailValid(email: controller.emailController.text.trim()) ){
                    return "Enter valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              //=========================PASSWORD=====================================
              CustomTextField(
                label: AppStrings.password,
                hintText: AppStrings.enterYourPassword.tr,
                controller: controller.passwordController,
                isPassword: true,
                validator: (value){
                  if( value == null || value.isEmpty ){
                    return "Password is required";
                  }
                  if( !isPasswordValid(password: controller.passwordController.text.trim()) ){
                    return "Enter valid password";
                  }
                  return null;
                },
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
              //========================Sign In==================================
              Obx((){
                return ButtonWidget(
                  label: AppStrings.signIn,
                  isLoading: controller.isSigninLoading.value,
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: (){
                    if( signInFormKey.currentState!.validate() ){
                      controller.signin();
                    }
                  },
                );
              }),
              const SizedBox(height: 18),
              // Sign In Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.roleSelection);
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
      ),
    );
  }
}