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
  String email = "";
  RxBool isForgotPasswordLoading = false.obs;

  @override
  void onInit() {
    email = Get.arguments;
    super.onInit();
  }

  //SEND OTP
  Future<void> sendOtp() async{
    if (isForgotPasswordLoading.value) {
      return;
    }

    isForgotPasswordLoading.value = true;
    Map<String, String> payLoad = {
      "email" : email
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: ApiEndpoints.otpForgotPassword,
      body: payLoad
    );
    isForgotPasswordLoading.value = false;

    if( response.statusCode == 200 ){
      showSnackBar(title: "Otp sent", message: "An otp has been sent to your email.", backgroundColor: AppColors.greenPrimary);
      Map<String, dynamic> arguments = {
        emailKey : email,
        isSignupKey : false
      };
      Get.offAndToNamed( AppRoutes.verifyEmail, arguments: arguments );
    }else if( response.statusCode == 400 ){
      showSnackBar(title: "Invalid email!", message: "Try again with your valid email.", backgroundColor: AppColors.warningYellow);
    }else if( response.statusCode == 404 ){
      showSnackBar(title: "No account found!", message: "No account found with this email.", backgroundColor: AppColors.warningYellow);
    }else if( response.statusCode == 408 ){
      timeOutSnackBar();
    }else if( response.statusCode == 503 ){
      noInternetSnackBar();
    }else{
      errorSnackBar();
    }
  }
}
