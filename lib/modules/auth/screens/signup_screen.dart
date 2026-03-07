import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/modules/auth/controllers/sign_up_controller.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/app_validator.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../profile/widgets/photo_edit_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    controller.setFormKey(signUpFormKey);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 30,
        leading: IconButton(
            onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back)
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: signUpFormKey,
          child: Column(
            children: [
              SvgPicture.asset(
                Assets.icons.appLogo,
                height: 150.h,
                width: 280.w,
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
              //=========================PHOTO WIDGET=============================
              PhotoEditWidget(
                imageUrl: "",
                onImagePicked: (image){
                  controller.profileImage.value = image;
                },
              ),
              const SizedBox(height: 15,),
              //=========================NAME=====================================
              // Form Fields
              Row(
                spacing: 3,
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: AppStrings.name,
                      hintText: AppStrings.firstName,
                      controller: controller.firstNameController,
                      validator: (value){
                        if( value == null || value.isEmpty ){
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      label: "",
                      hintText: AppStrings.lastName,
                      controller: controller.lastNameController,
                      validator: (value){
                        if( value == null || value.isEmpty ){
                          return "name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                 AppStrings.phone,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 8),
              //=========================PHONE====================================
              IntlPhoneField(
                validator: (phone){
                  if( phone == null || phone.number.isEmpty ){
                    return "Phone number is required";
                  }
                  try{
                    if( !phone.isValidNumber() ){
                      return "Invalid phone number";
                    }
                  }catch(e){
                    return "Invalid phone number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    fillColor: const Color(0xFFF9F9F9),
                    filled: true,
                    labelText: 'Phone Number',
                    labelStyle: TextStyle( fontSize: 16.sp),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    maintainHintSize: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: const Color(0xFFE4E4E4), width: 1.w),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.errorRed, width: 1),
                  ),
                ),
                initialCountryCode: 'EG',
                onChanged: (phone) {
                  controller.contactNumber = phone.completeNumber;
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
                  if( !isPasswordValid(password: controller.passwordController.text.trim() ) ){
                    return "Password must be at least 8 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              //=========================CONFIRM PASSWORD=====================================
              // Password Field
              CustomTextField(
                label: AppStrings.confirmPassword,
                hintText: AppStrings.enterYourPassword.tr,
                controller: controller.confirmPasswordController,
                isPassword: true,
                validator: (value){
                  if( controller.passwordController.text.trim() != controller.confirmPasswordController.text.trim() ){
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Terms and Privacy Checkbox
              Obx(() => Row(
                children: [
                  Checkbox(
                    value: controller.isAgreed.value,
                    onChanged: (checked){
                      controller.isAgreed.value = checked!;
                    },
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
                              Get.toNamed(AppRoutes.termsConditions);
                          }
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: AppColors.secondaryDarkBlue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                              ..onTap = (){
                              Get.toNamed(AppRoutes.privacyPolicy);
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
              //========================Sign Up==================================
              Obx((){
                return ButtonWidget(
                  label: AppStrings.signUp,
                  gradient: AppColors.primaryButtonGradient,
                  isLoading: controller.isSignupLoading.value,
                  onPressed: (){
                    if( signUpFormKey.currentState!.validate() && controller.isAgreed.value ){
                      controller.signup();
                    }
                  },
                );
              }),
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
      ),
    );
  }
}