import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  TextEditingController emailController = TextEditingController();
  RxBool isForgotPasswordLoading = false.obs;

  //SEND OTP
  Future<void> sendOtp() async{
    if (isForgotPasswordLoading.value) {
      return;
    }

    isForgotPasswordLoading.value = true;
    Map<String, String> payLoad = {
      "email" : emailController.text.trim()
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: ApiEndpoints.otpForgotPassword,
      body: payLoad
    );
    isForgotPasswordLoading.value = false;

    if( response.statusCode == 200 ){
      Map<String, dynamic> arguments = {
        emailKey : emailController.text.trim(),
        isSignupKey : false
      };
      Get.offAndToNamed( AppRoutes.verifyEmail, arguments: arguments );
    }
    showApiSnackBar(statusCode: response.statusCode, data: response.data);
  }

  @override
  void onClose() {

    emailController.dispose();

    super.onClose();
  }
}
