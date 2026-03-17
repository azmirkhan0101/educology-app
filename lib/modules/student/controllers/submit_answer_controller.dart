import 'dart:io';

import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubmitAnswerController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  RxBool isUploading = false.obs;

  File? pdfFile;

  late String courseId;
  late String taskId;

  @override
  void onInit() {

    courseId = Get.arguments?['courseId'] ?? "";
    taskId = Get.arguments?['taskId'] ?? "";

    super.onInit();
  }

  //============================GET ANSWERS======================
  Future<void> submitAnswer() async {
    if (isUploading.value) {
      return;
    }

    if( pdfFile == null ){
      showSnackBar(title: "Failed", message: "Please upload your answer", backgroundColor: AppColors.errorRed);
      return;
    }


    Map<String, dynamic> payLoad = {
      "task" : taskId,
      "course" : courseId
    };

    print("Payloaddddddddddddddddddd: $payLoad");

    isUploading.value = true;
    ApiResponse response = await apiService.multipartRequest(
        method: "POST",
        isAuthRequired: true,
        endPoint: ApiEndpoints.submitAnswer,
      fields: payLoad,
      pdfFile: pdfFile,
      pdfKey: "answerPdf"
    );
    isUploading.value = false;

    if (response.statusCode == 201) {
      Get.back();
      showSnackBar(title: "Answer submitted", message: "Answer submitted successfully", backgroundColor: AppColors.greenPrimary);
    }else{
      showSnackBar(title: "Error", message: response.data?['message'] ?? "Something went wrong", backgroundColor: AppColors.errorRed);
    }
  }
}
