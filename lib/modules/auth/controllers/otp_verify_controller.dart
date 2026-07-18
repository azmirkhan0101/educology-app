import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../data/models/profile/profile_model.dart';
import '../../../routes/app_pages.dart';

class OtpVerifyController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();

  final storage = GetStorage();

  late String email;
  late bool isSignup;
  late bool isLogin;//FOR LOGIN ATTEMPT WITHOUT VERIFICATION
  @override
  void onInit() {
    email = Get.arguments[emailKey];
    isSignup = Get.arguments[isSignupKey];
    isLogin = (Get.arguments?[isLoginKey] as bool?) ?? false;

    if( isLogin ){
      resendOtp();
    }
    startTimer();
    super.onInit();
  }

  RxBool isOtpVerifying = false.obs;
  Timer? timer;
  RxInt seconds = 60.obs;
  RxBool isTimerCounting = true.obs;

  final TextEditingController otpController = TextEditingController();

  //TIMER
  void startTimer(){
    isTimerCounting.value = true;
    timer?.cancel();
    seconds.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer2) {
      if( seconds.value > 0 ){
        seconds--;
      }else{
        timer?.cancel();
        isTimerCounting.value = false;
      }
    });
  }


  //VERIFY SIGNUP OTP
  Future<void> verifySignupOtp() async{

    if( isOtpVerifying.value ){
      return;
    }

    if( otpController.text.trim().isEmpty || otpController.text.trim().length < 6 ){
      showSnackBar(title: "OTP required!", message: "Please enter the otp and try again.", backgroundColor: AppColors.warningYellow);
      return;
    }

    isOtpVerifying.value = true;
    Map<String, String> payLoad = {
      "email": email,
      "otp": otpController.text.trim()
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: ApiEndpoints.verifySignupOtp,
      body: payLoad
    );

    if( response.statusCode != 200 ){
      isOtpVerifying.value = false;
    }

    if( response.statusCode == 200 ){
      storage.write( requireVerificationKey, false );
      await saveTokens( response.data );
      //GET PROFILE, SAVE ROLE AND GO TO MAIN NAV
      getProfileData();
    }else if( response.statusCode == 423 ){//NOT APPROVED BY ADMIN
      Get.offAndToNamed( AppRoutes.accountApproval );
      }

    showApiSnackBar(statusCode: response.statusCode, data: response.data );
  }

  Future<void> getProfileData() async {

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getProfile
    );

    isOtpVerifying.value = false;

    if (response.statusCode == 200) {
      storage.write(requireVerificationKey, false);
      //FETCHED PROFILE DATA
      ProfileModel model = ProfileModel.fromJson(
          response.data['data']
      );
      //SAVE PROFILE DATA IN STORAGE
      storage.write(profileModelKey, model.toJson());
      Role role = model.role;
      storage.write(roleKey, role.name);

      UserStatus status = model.status;
      if( status == UserStatus.blocked ){
        return;
      }
      if( status == UserStatus.pending ) {
        //storage.write(requireVerificationKey, true);
        storage.write(emailKey, "");
        Map<String, dynamic> arguments = {
          emailKey: "",
          isSignupKey: true,
        };
        Get.offAndToNamed(AppRoutes.accountApproval, arguments: arguments);
        return;
      }
      if( status == UserStatus.inProgress ){
        Get.offAllNamed(AppRoutes.mainNav);
      }
    } else if (response.statusCode == 401) {
      await storage.erase();
      await secureStorage.deleteAll();
      //ACCESS TOKEN INVALID
    }else if (response.statusCode == 403) {//ACCOUNT IS NOT VERIFIED
      Get.offAndToNamed(AppRoutes.accountApproval);
    }else{
      await storage.erase();
      await secureStorage.deleteAll();
    }
  }


  //VERIFY FORGOT PASSWORD OTP
Future<void> verifyForgotPasswordOtp() async{
  
  if( isOtpVerifying.value ){
    return;
  }

  if( otpController.text.trim().isEmpty || otpController.text.trim().length < 6 ){
    showSnackBar(title: "OTP required!", message: "Please enter the otp and try again.", backgroundColor: AppColors.warningYellow);
    return;
  }

  isOtpVerifying.value = true;
  Map<String, String> payLoad = {
    "email": email,
    "otp": otpController.text.trim()
  };
  ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: false,
      endPoint: ApiEndpoints.otpVerifyForgotPassword,
    body: payLoad
  );
  isOtpVerifying.value = false;

  if( response.statusCode == 200 ){
    Get.offAndToNamed( AppRoutes.resetPassword, arguments: email );
  }
  showApiSnackBar(statusCode: response.statusCode, data: response.data );
}

//SEND OTP
  Future<void> resendOtp() async{

    otpController.clear();

    Map<String, String> payLoad = {
      "email" : email
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: isSignup ? ApiEndpoints.otpResend : ApiEndpoints.otpForgotPassword,
      body: payLoad
    );

    if( response.statusCode == 200 ){
      startTimer();
    }
    showApiSnackBar(statusCode: response.statusCode, data: response.data);
  }

  // SAVE TOKENS IN STORAGE (Now requires async/await)
  Future<void> saveTokens(Map<String, dynamic> response) async {
    final accessToken = response["data"]["accessToken"];
    final refreshToken = response["data"]["refreshToken"];

    await secureStorage.write(key: accessTokenKey, value: accessToken);
    await secureStorage.write(key: refreshTokenKey, value: refreshToken);
  }
}