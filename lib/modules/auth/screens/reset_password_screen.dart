import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_validator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPasswordController controller = Get.find<ResetPasswordController>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;
    controller.setFormKey(resetPasswordFormKey);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: isTab ? 40 : null,),
          onPressed: () => Get.back(),
        ),
      ),
      body: LayoutBuilder(
          builder: (context, constraints){
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: resetPasswordFormKey,
                    child: Column(
                      children: [
                        // Logo Section
                        const SizedBox(height: 35),

                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Reset your ",
                                      style: TextStyle(
                                          color: AppColors.secondaryGreen,
                                          fontSize: isTab ? 14.sp : 24,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  TextSpan(
                                      text: "Password",
                                      style: TextStyle(
                                          color: AppColors.secondaryDarkBlue,
                                          fontSize: isTab ? 14.sp : 24,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                                ]
                            )
                        ),
                        const SizedBox(height: 8),
                        TextWidget(text: AppStrings.passwordMustHave,
                          fontSize: isTab ? 12.sp : 14,
                        ),
                        const SizedBox(height: 32),

                        //=========================NEW PASSWORD=====================================
                        CustomTextField(
                          label: AppStrings.newPassword,
                          hintText: AppStrings.enterYourPassword.tr,
                          controller: controller.passwordController,
                          isPassword: true,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            } else if( !isPasswordValid(password: controller.passwordController.text.trim() ) ){
                              return "Password must be at least 8 characters long";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        //=========================NEW PASSWORD=====================================
                        CustomTextField(
                          label: AppStrings.confirmPassword,
                          hintText: AppStrings.enterYourPassword.tr,
                          controller: controller.confirmPasswordController,
                          isPassword: true,
                            validator: (value) {
                              if (controller.passwordController.text !=
                                  controller.confirmPasswordController.text) {
                                return "Passwords not matched";
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 25,),
                        const Spacer(),
                        //========================Sign In==================================
                        Obx((){
                          return ButtonWidget(
                            label: AppStrings.confirm,
                            buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                            isLoading: controller.isPasswordChanging.value,
                            gradient: AppColors.primaryButtonGradient,
                            onPressed: (){
                              if( controller.formKey!.currentState!.validate() ){
                                controller.resetPassword();
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  //SHOW PASSWORD RESET DIALOG
  Future<void> showNotBirthDayDialog() async{
    Get.dialog(
        AlertDialog(
          backgroundColor: AppColors.greyB2,
          content: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(100)
                  ),
                  child: Icon(Icons.done, color: AppColors.white, fontWeight: FontWeight.bold, size: 28,),
                ),
              ),
              const TextWidget(
                text: AppStrings.passwordChanged,
              fontColor: AppColors.secondaryDarkBlue,
                fontWeight: FontWeight.bold,
              ),
              const TextWidget(
                text: AppStrings.yourPasswordHasBeenChanged,
                fontColor: AppColors.grey4E,
                fontSize: 14,
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          actions: [
            ButtonWidget(label: AppStrings.backToSignIn,
            gradient: AppColors.primaryButtonGradient,
              onPressed: (){
              Get.back();
              Get.offAllNamed(AppRoutes.signIn);
              },
            )
          ],
        )
    );
  }
}