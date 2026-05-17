import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/api_service.dart';
import '../../../core/services/role_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {


  final RoleService roleService = Get.find<RoleService>();

  @override
  void onInit() {

    role = roleService.getUpdatedRole();

    super.onInit();
  }

  final ApiService apiService = Get.find<ApiService>();
  final ProfileController profileController = Get.find<ProfileController>();
  late Role role;

  //CHANGE PASSWORD
  RxBool isChangePasswordLoading = false.obs;
  final storage = GetStorage();
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  //======================CONNECT ZOOM=====================
  Future<void> connectZoom() async {
    String? id = profileController.profileModel.value?.id;
    if (id == null) {
      showSnackBar(title: "Id not found!", message: "User id not found.", backgroundColor: AppColors.warningYellow);
      return;
    }

    //LIVE URL
    final String authUrl = 'https://zoom.us/oauth/authorize'
        '?response_type=code'
        '&client_id=0amFVARESkaqpI3ui42ohA'
        '&redirect_uri=https://lms-orpin-five.vercel.app/api/v1/zoom/callback'
        '&state=$id';

    //The Custom Scheme registered in your Android/iOS native files
    //TRACK: educology://zoom-success
    final String callbackScheme = 'educology';

    try {
      //Open the secure in-app browser and wait for the OS to redirect back
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackScheme
      );

      if (result.contains('zoom-success')) {
        //TODO: GET PROFILE, CHECK RESPONSE
        profileController.getProfile();
        Get.snackbar(
          'Success!',
          'Zoom account connected successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor.withOpacity(0.1),
        );
      } else {
        Get.snackbar(
          'Failed',
          'Could not connect Zoom account.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Cancelled',
        'Zoom connection was cancelled.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //======================CHANGE PASSWORD=====================
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
    String? message = response.data?["message"];

    if( response.statusCode == 200 ){
      saveTokens( response.data );
      currentPassword.clear();
      newPassword.clear();
      confirmPassword.clear();
      Get.back();
      showSnackBar(title: "Password changed!", message: message ?? "Your password has been changed successfully.", backgroundColor: AppColors.greenPrimary);
    }else if( response.statusCode == 400 ){
      showSnackBar(title: "Failed!", message: message ?? "New password cannot be the same as the old password.", backgroundColor: AppColors.warningYellow);
    }else if( response.statusCode == 401 ){
      showSnackBar(title: "Unauthorized!", message: message ?? "You are not authorized.", backgroundColor: AppColors.errorRed);
    }else if( response.statusCode == 403 ){
      showSnackBar(title: "Wrong password!", message: message ?? "Your current password is wrong.", backgroundColor: AppColors.warningYellow);
    }else if (response.statusCode == 408) {//TIME OUT
      timeOutSnackBar();
    }else if (response.statusCode == 503) {//NO INTERNET
      noInternetSnackBar();
    } else {
      errorSnackBar();
    }
  }

  //======================DELETE ACCOUNT=====================
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

  //======================DELETING ALERT=====================
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

  //======================DELETE SUCCESS ALERT=====================
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

  //======================SAVE TOKENS IN STORAGE=====================
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
