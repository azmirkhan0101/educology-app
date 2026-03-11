import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/class/class_model.dart';
import 'package:dr_dina_educology/data/models/course_details/course_stat_model.dart';
import 'package:dr_dina_educology/data/models/homework_exam/homework_exam_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../data/models/announcement/announce_model.dart';

class CourseDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt tabIndex = 0.obs;
  final RoleService roleService = Get.find<RoleService>();
  late Role role;
  final ApiService apiService = Get.find<ApiService>();
  Rxn<CourseStatModel> courseStat = Rxn<CourseStatModel>(null);
  late String courseId;
  late String courseName;
  late String subject;
  late String status;

  //CLASSES
  RxList<ClassModel> classes = <ClassModel>[].obs;
  RxBool isClassesLoading = false.obs;

  //HOMEWORK
  RxList<HomeworkExamModel> homeworks = <HomeworkExamModel>[].obs;
  RxBool isHomeworkLoading = false.obs;

  //EXAM
  RxList<HomeworkExamModel> exams = <HomeworkExamModel>[].obs;
  RxBool isExamLoading = false.obs;

  //ANNOUNCEMENT
  RxList<AnnounceModel> announcements = <AnnounceModel>[].obs;
  RxBool isAnnouncementLoading = false.obs;

  @override
  void onInit() {
    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    courseName = Get.arguments['courseName'];
    subject = Get.arguments['subject'];
    status = Get.arguments['status'];

    tabController = TabController(length: 4, vsync: this);

    tabController.addListener(_onTabChanged);

    if (role == Role.teacher || role == Role.assistant) {
      getCourseStats(courseId: courseId);
    }

    //GET CLASSES IF EMPTY
    if (classes.isEmpty) {
      getClasses();
    }

    super.onInit();
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
    //0 - class, 1 - homework, 2 - exam, 3 - announcement

    switch (tabIndex.value) {
      case 0:
        if (classes.isEmpty && !isClassesLoading.value) {
          getClasses();
        }
        break;

      case 1:
        if (homeworks.isEmpty && !isHomeworkLoading.value) {
          getHomeworks();
        }
        break;

      case 2:
        if (exams.isEmpty && !isExamLoading.value) {
          getExams();
        }
        break;

      case 3:
        if (announcements.isEmpty && !isAnnouncementLoading.value) {
          getAnnouncements();
        }
        break;
    }
  }

  //GET STATISTICS
  Future<void> getCourseStats({required String courseId}) async {
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.overallCourseStats(courseID: courseId),
    );

    if (response.statusCode == 200) {
      final tempData = response.data['data'] as Map<String, dynamic>?;
      if (tempData != null) {
        courseStat.value = CourseStatModel.fromJson(tempData);
      }
    }
  }

  //GET CLASSES
  Future<void> getClasses() async {
    isClassesLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getClasses(courseId: courseId),
    );
    isClassesLoading.value = false;
    if (response.statusCode == 200) {
      classes.value =
          (response.data['data'] as List<dynamic>?)
              ?.map((e) => ClassModel.fromJson(e))
              .toList() ??
          [];
    }
  }

  //GET HOMEWORKS
  Future<void> getHomeworks() async {
    isHomeworkLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getHomeworks(courseId: courseId),
    );
    isHomeworkLoading.value = false;
    if (response.statusCode == 200) {
      homeworks.value =
          (response.data['data']['result'] as List<dynamic>?)
              ?.map((e) => HomeworkExamModel.fromJson(e))
              .toList() ??
          [];
    }
  }

  //GET EXAMS
  Future<void> getExams() async {
    isExamLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getExams(courseId: courseId),
    );
    isExamLoading.value = false;
    if (response.statusCode == 200) {
      exams.value =
          (response.data['data']['result'] as List<dynamic>?)?.map((e) {
            return HomeworkExamModel.fromJson(e);
          }).toList() ??
          [];
    }
  }

  //GET ANNOUNCEMENTS
  Future<void> getAnnouncements() async {
    isAnnouncementLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getAnnouncements(courseId: courseId),
    );
    isAnnouncementLoading.value = false;
    if (response.statusCode == 200) {
      announcements.value =
          (response.data['data']['result'] as List<dynamic>?)?.map((e) {
            return AnnounceModel.fromJson(e);
          }).toList() ??
          [];
    }
  }
}
