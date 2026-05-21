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
    String? token;

    if (Platform.isIOS) {
      String? apnsToken;
      for( int i = 0; i < 5; i++ ){
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();

        if( apnsToken != null ){
          break;
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    try{
      token = await FirebaseMessaging.instance.getToken();
    }catch(e){
      print("FCM error: $e");
    }

    print("FCM Token: $token");

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
    } else if (response.statusCode == 403) {
      //NOT VERIFIED OR ACCOUNT IS BLOCKED
      String? message = response.data?["message"];
      //OTP verification is required before logging in!
      //Your account is blocked by admin!
      if (message != null && message == "OTP verification is required before logging in!") {
        storage.write(requireVerificationKey, true);
        storage.write(emailKey, emailController.text.trim());
        Map<String, dynamic> arguments = {
          emailKey: emailController.text.trim(),
          isSignupKey: true,
          isLoginKey: true
        };
        Get.offAndToNamed(AppRoutes.verifyEmail, arguments: arguments);
      }else{
        Get.offAndToNamed(AppRoutes.accountApproval);
      }
    } else if (response.statusCode == 423) {//ACCOUNT IS NOT APPROVED YET BY ADMIN
      Get.offAndToNamed(AppRoutes.accountApproval);
    }
    print("${response.statusCode} ${response.data}");
    showApiSnackBar(statusCode: response.statusCode, data: response.data);
  }

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

      UserStatus status = model.status;
      if( status == UserStatus.blocked ){
        return;
      }
      if( status == UserStatus.pending ) {
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
      }
    } else if (response.statusCode == 401) {
      storage.erase();
      //ACCESS TOKEN INVALID
    }else if (response.statusCode == 403) {//ACCOUNT IS NOT VERIFIED
      Get.offAndToNamed(AppRoutes.accountApproval);
    }else{
      storage.erase();
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
