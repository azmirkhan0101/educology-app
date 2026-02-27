import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class VerifyAccountController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();

  final storage = GetStorage();
  RxBool isVerificationLoading = false.obs;

  String? email(){
    return storage.read( emailKey );
  }

  //VERIFY NOW CLICK -> SEND SIGNUP OTP ( SAME AS RESEND SIGNUP OTP )
  void sendVerificationOtp() async{

    if( isVerificationLoading.value ){
      return;
    }

    isVerificationLoading.value = true;
    Map<String, String> payLoad = {
      "email": email()!
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: ApiEndpoints.otpResend,
      body: payLoad
    );
    isVerificationLoading.value = false;

    if( response.statusCode == 200 ){
      Get.snackbar(
          "OTP sent!",
          "an OTP has been sent to your email."
      );
      Map<String, dynamic> arguments = {
        emailKey : email()!,
        isSignupKey : true
      };
      Get.offNamed( AppRoutes.verifyEmail, arguments: arguments );
    }else if( response.statusCode == 400 ){
      Get.snackbar(
          "OTP already sent",
          "Check your mail and enter the otp."
      );
      Map<String, dynamic> arguments = {
        emailKey : email()!,
        isSignupKey : true
      };
      Get.offNamed( AppRoutes.verifyEmail, arguments: arguments );
    }else if( response.statusCode == 408 ){
      timeOutSnackBar();
    }else if( response.statusCode == 503 ){
      noInternetSnackBar();
    }else{
      errorSnackBar();
    }
  }

}