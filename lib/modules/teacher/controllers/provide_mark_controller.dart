import 'dart:io';

import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/modules/teacher/controllers/check_answer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProvideMarkController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  RxBool isUploading = false.obs;
  final CheckAnswerController checkAnswerController = Get.find<CheckAnswerController>();

  File? pdfFile;
  RxString pdfFileName = "".obs;
  int? mark;
  int? totalMarks;
  TextEditingController marksController = TextEditingController();
  TextEditingController totalMarksController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  late String submissionId;
  late int index;

  @override
  void onInit() {

    submissionId = Get.arguments?['submissionId'] ?? "";
    index = Get.arguments['index'] ?? 0;
    pdfFile = Get.arguments['correctedAnswer'] as File?;
    if( pdfFile != null ){
      pdfFileName.value = pdfFile!.path.split('/').last;
    }

    super.onInit();
  }

  //============================GET ANSWERS======================
  Future<void> uploadMark() async {
    if (isUploading.value) {
      return;
    }

    if( pdfFile == null ){
      showSnackBar(title: "Failed", message: "Please upload a file", backgroundColor: AppColors.errorRed);
      return;
    }

    mark = int.tryParse(marksController.text) ?? 0;
    totalMarks = int.tryParse(totalMarksController.text) ?? 0;

    Map<String, dynamic> payLoad = {
      "marks" : mark,
      "totalMarks" : totalMarks,
      "feedback" : feedbackController.text.trim()
    };

    isUploading.value = true;
    ApiResponse response = await apiService.multipartRequest(
        method: "PATCH",
        isAuthRequired: true,
        endPoint: ApiEndpoints.provideMark(submissionId: submissionId),
      fields: payLoad,
      pdfFile: pdfFile,
      pdfKey: "correctAnswerPdf"
    );
    isUploading.value = false;

    if (response.statusCode == 200) {
      checkAnswerController.markAsProvided(index: index);
      Get.back();
      }
    showApiSnackBar(statusCode: response.statusCode, data: response.data);
  }
}
