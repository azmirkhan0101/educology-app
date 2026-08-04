import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/course_overview/student_status_model.dart';

class ProvideOfflineMarkController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  RxBool isUploading = false.obs;
  RxBool isSearching = false.obs;

  String? courseId;
  String? taskId;
  String? studentId;

  // Search and Selected Student State
  TextEditingController searchController = TextEditingController();
  RxList<StudentStatusModel> searchedStudents = <StudentStatusModel>[].obs;
  Rxn<StudentStatusModel> selectedStudent = Rxn<StudentStatusModel>();
  RxString searchQuery = "".obs;

  File? pdfFile;
  RxString pdfFileName = "".obs;
  int? mark;
  int? totalMarks;

  TextEditingController marksController = TextEditingController();
  TextEditingController totalMarksController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  @override
  void onInit() {
    courseId = Get.arguments?['courseId'] ?? "";
    taskId = Get.arguments?['taskId'] ?? "";

    debounce(
      searchQuery,
          (query) => searchStudents(query: query),
      time: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  //============================ SEARCH STUDENTS ======================
  Future<void> searchStudents({required String query}) async {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty || courseId == null) {
      searchedStudents.clear();
      return;
    }

    isSearching.value = true;

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.studentStatusList(
        courseId: courseId!,
        search: trimmedQuery,
      ),
      shouldPrint: true,
    );

    isSearching.value = false;

    if (response.statusCode == 200 && response.data != null) {
      try {
        final List studentListJson = response.data['data']['studentList'] ?? [];
        searchedStudents.value = studentListJson
            .map((json) => StudentStatusModel.fromJson(json))
            .toList();
      } catch (e) {
        searchedStudents.clear();
      }
    } else {
      searchedStudents.clear();
    }
  }

  //============================ SELECT STUDENT ======================
  void selectStudent(StudentStatusModel student) {
    selectedStudent.value = student;
    studentId = student.id; // Correct student _id from StudentStatusModel
    searchedStudents.clear();
    searchController.clear();
  }

  //============================ REMOVE SELECTED STUDENT =============
  void clearSelectedStudent() {
    selectedStudent.value = null;
    studentId = null;
  }

  //============================ UPLOAD MARK ==========================
  Future<void> uploadMark() async {
    if (isUploading.value) {
      return;
    }

    if (studentId == null || studentId!.isEmpty) {
      showSnackBar(
        title: "Missing Field",
        message: "Please search and select a student.",
        backgroundColor: AppColors.errorRed,
      );
      return;
    }

    if (pdfFile == null) {
      showSnackBar(
        title: "Missing Field",
        message: "Please attach correct answer PDF.",
        backgroundColor: AppColors.errorRed,
      );
      return;
    }

    mark = int.tryParse(marksController.text) ?? 0;
    totalMarks = int.tryParse(totalMarksController.text) ?? 0;

    Map<String, dynamic> payLoad = {
      "task": taskId,
      "student": studentId,
      "course": courseId,
      "marks": mark,
      "totalMarks": totalMarks,
      "feedback": feedbackController.text.trim()
    };

    print(jsonEncode(payLoad));

    isUploading.value = true;
    ApiResponse response = await apiService.multipartRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.provideOfflineMark,
      fields: payLoad,
      pdfFile: pdfFile,
      pdfKey: "correctAnswerPdf",
    );
    isUploading.value = false;

    showApiSnackBar(statusCode: response.statusCode, data: response.data);

    if (response.statusCode == 200) {
      studentId = null;
      Get.back();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    marksController.dispose();
    totalMarksController.dispose();
    feedbackController.dispose();
    pdfFile = null;
    pdfFileName.value = "";
    mark = null;
    totalMarks = null;
    super.onClose();
  }
}