import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/custom_text_field.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_validator.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(text: AppStrings.changePassword,
        fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                    key: formKey,
                    child: Column(
                      children: [
                        // Logo Section
                        const SizedBox(height: 35),
                        const TextWidget(text: AppStrings.passwordMustBe,
                          fontSize: 14,
                        ),
                        const SizedBox(height: 32),
                        //=======================CURRENT PASSWORD===================
                        CustomTextField(
                          label: AppStrings.currentPassword,
                          controller: controller.currentPassword,
                          hintText: AppStrings.enterYourPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if( value == null || value.isEmpty ){
                              return "Password is required";
                            }
                            if( !isPasswordValid(password: controller.currentPassword.text.trim()) ){
                              return "Enter valid password";
                            }
                            return null;
                          },
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                      //========================NEW PASSWORD======================
                      CustomTextField(
                        label: AppStrings.newPassword,
                        controller: controller.newPassword,
                        hintText: AppStrings.enterYourPassword,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        validator: (value){
                          if( value == null || value.isEmpty ){
                            return "Password is required";
                          }
                          if( !isPasswordValid(password: controller.newPassword.text.trim()) ){
                            return "Enter valid password";
                          }
                          return null;
                        },
                      ),
                        const SizedBox(height: 10),
                        //========================CONFIRM PASSWORD==================
                        CustomTextField(
                          label: AppStrings.confirmPassword,
                          controller: controller.confirmPassword,
                          hintText: AppStrings.enterYourPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                          if (controller.newPassword.text !=
                              controller.confirmPassword.text) {
                            return "Passwords not matched";
                          }
                          return null;
                        },
                          isPassword: true,
                        ),
                        const SizedBox(height: 25,),
                        const Spacer(),
                        // Sign Up Button
                        Obx((){
                          return ButtonWidget(
                            label: AppStrings.update,
                            isLoading: controller.isChangePasswordLoading.value,
                            gradient: AppColors.primaryButtonGradient,
                            onPressed: (){
                              if( formKey.currentState!.validate() ) {
                                controller.changePassword();
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
}