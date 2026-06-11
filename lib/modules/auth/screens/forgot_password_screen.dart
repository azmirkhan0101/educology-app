import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/auth/controllers/forgot_password_controller.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/app_validator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_text_field.dart';

// --- Main Screen ---
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

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
            //padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: forgotPasswordFormKey,
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
                                          fontSize: isTab ? 12.sp : 24,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  TextSpan(
                                      text: "password?",
                                      style: TextStyle(
                                          color: AppColors.secondaryDarkBlue,
                                          fontSize: isTab ? 12.sp : 24,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                                ]
                            )
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: AppStrings.enterYourEmailAddress,
                          fontSize: isTab ? 10.sp : 14,
                        ),
                        const SizedBox(height: 20),
                        //=========================EMAIL====================================
                        CustomTextField(
                          label: AppStrings.email,
                          keyboardType: TextInputType.emailAddress,
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
                        const SizedBox(height: 25,),
                        const Spacer(),
                        const SizedBox(height: 30,),
                        //========================BUTTON==================================
                        Obx((){
                          return ButtonWidget(
                            label: AppStrings.getVerificationCode,
                            buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                            isLoading: controller.isForgotPasswordLoading.value,
                            gradient: AppColors.primaryButtonGradient,
                            onPressed: (){
                              if( forgotPasswordFormKey.currentState!.validate() ){
                                controller.sendOtp();
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
            ),
          );
        },
      ),
    );
  }

}