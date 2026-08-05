import 'dart:io';

import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/modules/content_details/controllers/content_details_controller.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:get/get.dart';

class SubmitAnswerController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final CourseDetailsController courseDetailsController =
      Get.find<CourseDetailsController>();
  final ContentDetailsController contentDetailsController =
      Get.find<ContentDetailsController>();
  RxBool isUploading = false.obs;

  File? pdfFile;

  late String courseId;
  late String taskId;
  late int index;
  late ContentDetailsType contentDetailsType;
  late bool isSubmitted;
  late String submissionID;

  @override
  void onInit() {
    isSubmitted = Get.arguments?['isSubmitted'] ?? false;
    submissionID = Get.arguments?['submissionId'] ?? "";
    courseId = Get.arguments?['courseId'] ?? "";
    taskId = Get.arguments?['taskId'] ?? "";
    index = Get.arguments?['index'] ?? 0;
    contentDetailsType = Get.arguments?['contentType'];

    super.onInit();
  }

  //============================SUBMIT ANSWER======================
  Future<void> submitAnswer() async {
    if (isUploading.value) {
      return;
    }

    if (pdfFile == null) {
      showSnackBar(
        title: "Failed",
        message: "Please upload your answer",
        backgroundColor: AppColors.errorRed,
      );
      return;
    }

    Map<String, dynamic> payLoad = {"task": taskId, "course": courseId};

    isUploading.value = true;
    ApiResponse response = await apiService.multipartRequest(
      method: "PATCH",
      isAuthRequired: true,
      endPoint: ApiEndpoints.submitAnswer,
      fields: payLoad,
      pdfFile: pdfFile,
      pdfKey: "answerPdf",
    );
    isUploading.value = false;

    if (response.statusCode == 201) {
      if (contentDetailsType == ContentDetailsType.exam) {
        courseDetailsController.markExamAsDone(index: index);
      } else {
        courseDetailsController.markHomeWorkAsDone(index: index);
      }
      contentDetailsController.markTaskAsDone();
      Get.back();
    }

    showApiSnackBar(statusCode: response.statusCode, data: response.data);
  }

  @override
  void onClose() {
    pdfFile = null;
    super.onClose();
  }
}
