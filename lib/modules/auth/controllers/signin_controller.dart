import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../data/models/profile/profile_model.dart';
import '../../../routes/app_pages.dart';

class SigninController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  final storage = GetStorage();
  RxBool isSigninLoading = false.obs;

  GlobalKey<FormState>? formKey;

  void setFormKey(GlobalKey<FormState> key) {
    formKey = key;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEmailValid() {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(emailController.text.trim());
  }

  bool isPasswordValid() {
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~?%^()_\-+=<>.,;:{}\[\]|/]).{8,}$',
    );
    return regex.hasMatch(passwordController.text.trim());
  }

  //VALIDATE EMAIL PASSWORD AND THEN LOGIN -> if verified -> go to home -> else -> go to verified screen
  Future<void> signin() async {
    if (isSigninLoading.value) {
      return;
    }

    isSigninLoading.value = true;
    late String? token;

    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    Map<String, dynamic> credentials = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "fcmToken": token ?? "",
    };

    final ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: false,
      endPoint: ApiEndpoints.login,
      body: credentials,
    );

    //GET PROFILE USING TOKEN -> THEN GO TO HOME
    if( response.statusCode != 200 ){
      isSigninLoading.value = false;
    }

    if (response.statusCode == 200) {
      //LOGIN SUCCESSFUL
      saveTokens(response.data);
      getProfileData();
    } else if (response.statusCode == 400) {
      //WRONG PASSWORD
      showSnackBar(
        title: "Incorrect password!",
        message: "The password you entered is incorrect.",
        backgroundColor: AppColors.errorRed,
      );
    } else if (response.statusCode == 403) {
      //NOT VERIFIED OR ACCOUNT IS BLOCKED
      String? message = response.data?["message"];
      //OTP verification is required before logging in!
      //Your account is blocked by admin!
      if (message != null && message == "OTP verification is required before logging in!") {
        showSnackBar(
          title: "Verification required!",
          message: message ?? "Your account is not verified. Please verify your email.",
          backgroundColor: AppColors.warningYellow,
        );
        storage.write(requireVerificationKey, true);
        storage.write(emailKey, emailController.text.trim());
        Map<String, dynamic> arguments = {
          emailKey: emailController.text.trim(),
          isSignupKey: true,
          isLoginKey: true
        };
        Get.offAndToNamed(AppRoutes.verifyEmail, arguments: arguments);
      }else if( message != null && message == "Your account is blocked by admin!" ){
        showSnackBar(
          title: "Account blocked!",
          message: message ?? "Your account is blocked by admin.",
          backgroundColor: AppColors.errorRed,
        );
      }else{
        Get.offAndToNamed(AppRoutes.accountApproval);
      }
    } else if (response.statusCode == 404) {
      //NO ACCOUNT FOUND IN THAT EMAIL
      showSnackBar(
        title: "Account not found!",
        message: response.data?['message'] ??
            "No account found matching this email. Try creating an account.",
        backgroundColor: AppColors.errorRed,
      );
    }else if (response.statusCode == 423) {//ACCOUNT IS NOT APPROVED YET BY ADMIN
      Get.offAndToNamed(AppRoutes.accountApproval);
    } else if (response.statusCode == 408) {
      //TIMEOUT
      timeOutSnackBar();
    } else if (response.statusCode == 503) {
      //NO INTERNET
      noInternetSnackBar();
    } else {
      showSnackBar(
        title: "Login Failed!",
        message: "Please try again.",
        backgroundColor: AppColors.errorRed,
      );
    }
  }

  //TOD0: IMPLEMENT SAME APPROACH IN OTP VERIFY CONTROLLER
  Future<void> getProfileData() async {

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getProfile
    );

    isSigninLoading.value = false;

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
      print("Role nameeeeeeeeeeeeeeee: ${role.name}");

      UserStatus status = model.status;
      print("Status nameeeeeeeeeeeeeeee: ${status.name}");
      if( status == UserStatus.blocked ){
        showSnackBar(
          title: "Account blocked!",
          message: "Your account is blocked by admin.",
          backgroundColor: AppColors.errorRed,
        );
        return;
      }
      if( status == UserStatus.pending ) {
        showSnackBar(
          title: "Account not approved!",
          message: "Your account is not approved by admin.",
          backgroundColor: AppColors.warningYellow,
        );
        //storage.write(requireVerificationKey, true);
        storage.write(emailKey, emailController.text.trim());
        Map<String, dynamic> arguments = {
          emailKey: emailController.text.trim(),
          isSignupKey: true,
        };
        Get.offAndToNamed(AppRoutes.accountApproval, arguments: arguments);
        return;
      }
      if( status == UserStatus.inProgress ){
        Get.offAllNamed(AppRoutes.mainNav);
        showSnackBar(
          title: "Login Successful!",
          message: "Welcome back!",
          backgroundColor: AppColors.greenPrimary,
        );
      }
    } else if (response.statusCode == 401) {
      storage.erase();
      //ACCESS TOKEN INVALID
      showSnackBar(
        title: "Session Expired!",
        message: "Please try again.",
        backgroundColor: AppColors.errorRed,
      );
    }else if (response.statusCode == 403) {//ACCOUNT IS NOT VERIFIED
      String? message = response.data?["message"];
      showSnackBar(
        title: "Not verified!",
        message: message ?? "Your account is not approved by admin.",
        backgroundColor: AppColors.warningYellow,
      );
      Get.offAndToNamed(AppRoutes.accountApproval);
    }else{
      storage.erase();
      showSnackBar(
        title: "Error!",
        message: "Something went wrong. Please try again",
        backgroundColor: AppColors.errorRed,
      );
    }
  }

  //SAVE TOKENS IN STORAGE
  void saveTokens(Map<String, dynamic> response) {
    final accessToken = response["data"]["accessToken"];
    final refreshToken = response["data"]["refreshToken"];

    storage.write(accessTokenKey, accessToken);
    storage.write(refreshTokenKey, refreshToken);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
