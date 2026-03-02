import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/pin_field_widget.dart';
import '../controllers/otp_verify_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});

  final OtpVerifyController controller = Get.find<OtpVerifyController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // physics ensures it only scrolls if content actually overflows
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                // Force the container to be at least the height of the screen
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Title Section
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Verify your ",
                              style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "email",
                              style: TextStyle(
                                color: AppColors.secondaryDarkBlue,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        AppStrings.weveSentAnEmail,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.grey4E, fontSize: 15),
                      ),

                      const SizedBox(height: 40),

                      // OTP Input
                      PinFieldWidget(
                          controller: controller.otpController, length: 6
                      ),

                      const SizedBox(height: 10),
                      Obx(() {
                        return Visibility(
                          visible: controller.isTimerCounting.value,
                          child: Text(
                            "00:${controller.seconds.value}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                      }),
                      //const Text("00:07", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),

                      // Resend Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Didn't get the code?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              if (!controller.isTimerCounting.value) {
                                controller.resendOtp();
                              }
                            },
                            child: const Text(
                              "Resend",
                              style: TextStyle(
                                color: Color(0xFF3B566E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //THE PUSH: This Spacer works because of IntrinsicHeight
                      const Spacer(),
                      // Bottom Section
                      Obx((){
                        return ButtonWidget(
                          label: AppStrings.confirmCode,
                          isLoading: controller.isOtpVerifying.value,
                          gradient: AppColors.primaryButtonGradient,
                          onPressed: () {
                            if( controller.isSignup ){
                              controller.verifySignupOtp();
                            }else{
                              controller.verifyForgotPasswordOtp();
                            }
                          },
                        );
                      }),
                      const SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: "Note: ",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "If you have not received the email in your inbox, please check your spam or junk folder.",
                            ),
                          ],
                        ),
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
}
