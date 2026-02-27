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
import '../../../routes/app_pages.dart';

class SigninController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  final storage = GetStorage();
  RxBool isLoginLoading = false.obs;

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
  Future<void> login() async {
    if (isLoginLoading.value) {
      return;
    }

    isLoginLoading.value = true;
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

    isLoginLoading.value = false;

    if (response.statusCode == 200) {
      //LOGIN SUCCESSFUL
      storage.write(requireVerificationKey, false);
      saveTokens(response.data);
      showSnackBar(
        title: "Logged in!",
        message: "You have successfully logged in.",
        backgroundColor: AppColors.greenPrimary,
      );
      Get.offAllNamed(AppRoutes.home);
    } else if (response.statusCode == 400) {
      //WRONG PASSWORD
      showSnackBar(
        title: "Incorrect password!",
        message: "The password you entered is incorrect.",
        backgroundColor: AppColors.errorRed,
      );
    } else if (response.statusCode == 403) {
      //NOT VERIFIED OR ACCOUNT IS BLOCKED
      String? message = response.data["message"];
      if (message != null && message == "Your account is blocked by admin!") {
        showSnackBar(
          title: "Account blocked!",
          message: "Your account is blocked by admin.",
          backgroundColor: AppColors.errorRed,
        );
        return;
      }
      showSnackBar(
        title: "Verification required!",
        message: "Your account is not verified. Please verify your email.",
        backgroundColor: AppColors.errorRed,
      );
      storage.write(requireVerificationKey, true);
      storage.write(emailKey, emailController.text.trim());
      Map<String, dynamic> arguments = {
        emailKey: emailController.text.trim(),
        isSignupKey: true,
      };
      Get.offAndToNamed(AppRoutes.accountApproval, arguments: arguments);
    } else if (response.statusCode == 404) {
      //NO ACCOUNT FOUND IN THAT EMAIL
      showSnackBar(
        title: "Account not found!",
        message:
            "No account found matching this email. Try creating an account.",
        backgroundColor: AppColors.errorRed,
      );
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
