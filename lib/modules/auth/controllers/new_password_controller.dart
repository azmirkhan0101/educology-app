import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();

  String email = "";

  @override
  void onInit() {
    email = Get.arguments;
    super.onInit();
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RxBool isPasswordChanging = false.obs;
  
  //RESET PASSWORD
  Future<void> resetPassword() async{

    if( isPasswordChanging.value ){
      return;
    }
    isPasswordChanging.value = true;
    Map<String, dynamic> payLoad = {
      "email": email,
      "newPassword": passwordController.text.trim()
    };
    ApiResponse response = await apiService.networkRequest(
        method: "POST",
        isAuthRequired: false,
        endPoint: ApiEndpoints.resetPassword,
      body: payLoad
    );
    isPasswordChanging.value = false;
    if( response.statusCode == 200 ){
      showSnackBar(title: "Done!", message: "Password has been reset.", backgroundColor: AppColors.greenPrimary);
      Get.offAndToNamed( AppRoutes.signIn );
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