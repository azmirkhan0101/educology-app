import 'dart:io';

import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddContentController extends GetxController {

  ApiService apiService = Get.find<ApiService>();
  final CourseDetailsController courseDetailsController =
      Get.isRegistered<CourseDetailsController>()
      ? Get.find<CourseDetailsController>()
      : Get.put(CourseDetailsController());
  late Map<String, dynamic> arguments;
  late String appTitle;
  late AddContentType contentType;
  late String courseId;

  //CONTENTS
  final TextEditingController titleController = TextEditingController();
  late DateTime startDate;
  final TextEditingController startTimeController = TextEditingController();
  late DateTime deadlineDate;
  final TextEditingController deadlineTimeController = TextEditingController();
  //==============MANUAL LINK ENTRY========================================
  final TextEditingController zoomLinkController = TextEditingController();
  //===================GENERATE ZOOM LINK==================================
  bool isZoomEnabled = false;
  String? detailsHtmlString;
  String? quillRawText;
  //FOR MULTIPLE PDF FILES
  RxList<File> pdfFiles = <File>[].obs;
  //FOR SHOWING NAMES IN UI
  RxList<String> pdfFileNames = <String>[].obs;

  //SINGLE FILE FOR ANNOUNCEMENT
  File? pdfFile;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    contentType = arguments["contentType"];
    courseId = arguments["courseId"];
    appTitle = contentType.label;

    super.onInit();
  }

  //=====================UPLOAD CLASS=====================
  Future<void> uploadClass() async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> payLoad = {
      "course": courseId,
      "title": titleController.text.trim(),
      "date": startDate.toIso8601String(),
      "time": startTimeController.text.trim(),
      "details": detailsHtmlString,
      "link": zoomLinkController.text.trim(),
      "isZoomMeeting": isZoomEnabled
    };

    ApiResponse response = await apiService.multipartRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.uploadClass,
      fields: payLoad,
      multiplePdfFiles: pdfFiles.value,
      pdfKey: "documents"
    );

    if (response.statusCode == 201) {
      courseDetailsController.getClasses();
      Get.back();
      }

    showApiSnackBar(statusCode: response.statusCode, data: response.data);

    isLoading.value = false;
  }

  //=======================UPLOAD HOMEWORK======================
  Future<void> uploadHomeWork() async {
    isLoading.value = true;

    Map<String, dynamic> payLoad = {
      "course": courseId,
      "title": titleController.text.trim(),
      "type": "homework",
      "startDate": DateFormat('yyyy-MM-dd').format(startDate),
      "startTime": startTimeController.text.trim(),
      "endDate": DateFormat('yyyy-MM-dd').format(deadlineDate),
      "endTime": deadlineTimeController.text.trim(),
      "details": detailsHtmlString,
    };

    ApiResponse response = await apiService.multipartRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.uploadExamHomeWork,
      fields: payLoad,
      multiplePdfFiles: pdfFiles.value,
      pdfKey: "documents"
    );

    if (response.statusCode == 201) {
      courseDetailsController.getHomeworks();
      Get.back();
      }
    showApiSnackBar(statusCode: response.statusCode, data: response.data);
    isLoading.value = false;
  }

  //=======================UPLOAD EXAM======================
  Future<void> uploadExam() async {
    isLoading.value = true;

    Map<String, dynamic> payLoad = {
      "course": courseId,
      "title": titleController.text.trim(),
      "type": "exam",
      "startDate": DateFormat("yyyy-MM-dd").format(startDate),
      "startTime": startTimeController.text.trim(),
      "endDate": DateFormat("yyyy-MM-dd").format(deadlineDate),
      "endTime": deadlineTimeController.text.trim(),
      "details": detailsHtmlString,
    };

    ApiResponse response = await apiService.multipartRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.uploadExamHomeWork,
      fields: payLoad,
      multiplePdfFiles: pdfFiles.value,
      pdfKey: "documents"
    );

    String? message = response.data?["message"];

    if (response.statusCode == 201) {
      courseDetailsController.getExams();
      Get.back();
      showSnackBar(
        title: "Uploaded!",
        message: message ?? "Exam uploaded successfully",
        backgroundColor: AppColors.greenPrimary,
      );
    } else {
      showSnackBar(
        title: "Failed!",
        message: message ?? "Something went wrong",
        backgroundColor: AppColors.errorRed,
      );
    }
    isLoading.value = false;
  }

  //=======================UPLOAD ANNOUNCEMENT======================
  Future<void> uploadAnnouncement() async {
    if (isLoading.value) {
      return;
    }

    if (quillRawText == null || quillRawText!.isEmpty) {
      showSnackBar(
        title: "Failed",
        message: "Please add announcement",
        backgroundColor: AppColors.warningYellow,
      );
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> payLoad = {
      "courseId": courseId,
      "details": detailsHtmlString
    };

    ApiResponse response = await apiService.multipartRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.uploadAnnouncement,
      fields: payLoad,
      pdfFile: pdfFile,
      pdfKey: "document"
    );

    String? message = response.data?["message"];

    if (response.statusCode == 201) {
      courseDetailsController.getAnnouncements();
      Get.back();
      showSnackBar(
        title: "Uploaded!",
        message: message ?? "Announcement uploaded successfully",
        backgroundColor: AppColors.greenPrimary,
      );
    } else {
      showSnackBar(
        title: "Failed!",
        message: message ?? "Something went wrong",
        backgroundColor: AppColors.errorRed,
      );
    }
    isLoading.value = false;
  }
}
