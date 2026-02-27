import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();

  RxBool isFaqLoading = false.obs;
  //PRIVACY POLICY
  RxString privacyPolicy = "".obs;
  RxBool isPrivacyPolicyLoading = false.obs;
  //TERMS CONDITIONS
  RxString termsConditions = "".obs;
  RxBool isTermsAndConditionsLoading = false.obs;

  //CHANGE PASSWORD
  RxBool isChangePasswordLoading = false.obs;
  final storage = GetStorage();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  //GET PRIVACY POLICY
  Future<void> getPrivacyPolicy() async {

    if( privacyPolicy.value.isNotEmpty ){
      return;
    }

    if( isPrivacyPolicyLoading.value ){
      return;
    }

    isPrivacyPolicyLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: false,
        endPoint: ApiEndpoints.privacyPolicy
    );
    isPrivacyPolicyLoading.value = false;

    if (response.statusCode == 200) {
      privacyPolicy.value = response.data['data']['privacyPolicy'];
    }
  }

  //GET TERMS AND CONDITIONS
  Future<void> getTermsAndConditions() async {

    if( termsConditions.value.isNotEmpty || isTermsAndConditionsLoading.value ){
      return;
    }

    isTermsAndConditionsLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
    method: "GET",
    isAuthRequired: false,
    endPoint: ApiEndpoints.termsAndConditions
    );
    isTermsAndConditionsLoading.value = false;

    if (response.statusCode == 200) {
      termsConditions.value = response.data['data']['termsCondition'];
    }
  }

  //CHANGE PASSWORD
  Future<void> changePassword() async{

    if( isChangePasswordLoading.value ){
      return;
    }

    isChangePasswordLoading.value = true;
    Map<String, String> payLoad = {
      "oldPassword" : currentPassword.text.trim(),
      "newPassword" : newPassword.text.trim()
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: true,
        endPoint: ApiEndpoints.changePassword,
      body: payLoad
    );
    isChangePasswordLoading.value = false;

    if( response.statusCode == 200 ){
      saveTokens( response.data );
      currentPassword.clear();
      newPassword.clear();
      confirmPassword.clear();
      Get.back();
      showSnackBar(title: "Password changed!", message: "Your password has been changed successfully.", backgroundColor: AppColors.greenPrimary);
    }else if( response.statusCode == 400 ){
      showSnackBar(title: "Failed!", message: "New password cannot be the same as the old password.", backgroundColor: AppColors.errorRed);
    }else if( response.statusCode == 401 ){
      showSnackBar(title: "Unauthorized!", message: "You are not authorized.", backgroundColor: AppColors.errorRed);
    }else if( response.statusCode == 403 ){
      showSnackBar(title: "Wrong password!", message: "Your current password is wrong.", backgroundColor: AppColors.errorRed);
    }else if (response.statusCode == 408) {//TIME OUT
      timeOutSnackBar();
    }else if (response.statusCode == 503) {//NO INTERNET
      noInternetSnackBar();
    } else {
      errorSnackBar();
    }
  }

  //DELETE ACCOUNT
  Future<void> deleteAccount() async {

    showDeletingAlert();
    ApiResponse response = await apiService.networkRequest(
        method: "DELETE",
        isAuthRequired: true,
        endPoint: ApiEndpoints.deleteAccount
    );
    if( response.statusCode == 200 ){
      await storage.erase();
      if( Get.isDialogOpen ?? false ){
        Get.back();
      }
      Get.offAllNamed( AppRoutes.onBoardingOne );
      showDeleteSuccessAlert();
    }else{
      if( Get.isDialogOpen ?? false ){
        Get.back();
      }
      errorSnackBar();
    }
  }

  //DELETING ALERT
  Future<void> showDeletingAlert() async{
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(child: CircularProgressIndicator(color: AppColors.greenPrimary,),),
            SizedBox(
              height: 15.h,
            ),
            Text("Deleting...", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),)
          ],
        ),
      )
    );
  }

  //DELETe SUCCESS ALERT
  Future<void> showDeleteSuccessAlert() async{
    Get.dialog(
        AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Success", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),),
              SizedBox(
                height: 15.h,
              ),
              Text("Your account has been deleted!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),),
              SizedBox(height: 12.h,),
              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.greenPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () async{
                    Get.back();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  //SAVE TOKENS IN STORAGE
  void saveTokens(Map<String, dynamic> response) {

    final accessToken = response["data"]["accessToken"];
    final refreshToken = response["data"]["refreshToken"];

    storage.write( accessTokenKey, accessToken);
    storage.write( refreshTokenKey, refreshToken);
  }

  @override
  void onClose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
