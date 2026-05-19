import 'package:dr_dina_educology/core/helpers/pagination_helper.dart';
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

  //STUDENT ID IF ROLE IS STUDENT
  String? studentId;

  //CLASSES
  final PaginationHelper<ClassModel> classesHelper = PaginationHelper<ClassModel>();
  ScrollController classesScrollController = ScrollController();

  //HOMEWORK
  final PaginationHelper<HomeworkExamModel> homeworkHelper = PaginationHelper<HomeworkExamModel>();
  ScrollController homeworksScrollController = ScrollController();

  //EXAM
  final PaginationHelper<HomeworkExamModel> examHelper = PaginationHelper<HomeworkExamModel>();
  ScrollController examsScrollController = ScrollController();

  //ANNOUNCEMENT
  final PaginationHelper<AnnounceModel> announcementHelper = PaginationHelper<AnnounceModel>();
  ScrollController announcementsScrollController = ScrollController();

  @override
  void onInit() {
    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    courseName = Get.arguments['courseName'];
    subject = Get.arguments['subject'];
    status = Get.arguments['status'];
    if( role == Role.student ){
      studentId = Get.arguments['studentId'];
    }

    tabController = TabController(length: 4, vsync: this);
    initPaginationHelpers();

    tabController.addListener(_onTabChanged);

    if (role == Role.teacher || role == Role.assistant) {
      getCourseStats(courseId: courseId);
    }

    //GET CLASSES IF EMPTY
    if (classesHelper.items.isEmpty) {
      getClasses();
    }

    super.onInit();
  }

  //INIT PAGINATION HELPERS
  void initPaginationHelpers() {
    List<dynamic>? extractor(data) => data['data']['result'] as List<dynamic>?;
    classesHelper.init(
        endPoint: (page) => ApiEndpoints.getClasses(courseId: courseId, page: page),
        fromJson: (json) => ClassModel.fromJson(json),
        listExtractor: (data) => extractor(data),
      scrollController: classesScrollController
    );

    homeworkHelper.init(
        endPoint: (page) => ApiEndpoints.getHomeworks(courseId: courseId, page: page),
        fromJson: (json) => HomeworkExamModel.fromJson(json),
        listExtractor: (data) => extractor(data),
      scrollController: homeworksScrollController
    );

    examHelper.init(
        endPoint: (page) => ApiEndpoints.getExams(courseId: courseId, page: page),
        fromJson: (json) => HomeworkExamModel.fromJson(json),
        listExtractor: (data) => extractor(data),
      scrollController: examsScrollController
    );

    announcementHelper.init(
        endPoint: (page) => ApiEndpoints.getAnnouncements(courseId: courseId, page: page),
        fromJson: (json) => AnnounceModel.fromJson(json),
        listExtractor: (data) => extractor(data),
      scrollController: announcementsScrollController
    );

  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
    //0 - class, 1 - homework, 2 - exam, 3 - announcement

    switch (tabIndex.value) {
      case 0:
        if (classesHelper.items.isEmpty && !classesHelper.isLoading.value) {
          getClasses();
        }
        break;

      case 1:
        if (homeworkHelper.items.isEmpty && !homeworkHelper.isLoading.value) {
          getHomeworks();
        }
        break;

      case 2:
        if (examHelper.items.isEmpty && !examHelper.isLoading.value) {
          getExams();
        }
        break;

      case 3:
        if (announcementHelper.items.isEmpty && !announcementHelper.isLoading.value) {
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
    await classesHelper.fetch(isRefresh: true, shouldPrint: true);
  }

  //GET HOMEWORKS
  Future<void> getHomeworks() async {
    await homeworkHelper.fetch(isRefresh: true);
  }

  //GET EXAMS
  Future<void> getExams() async {
    await examHelper.fetch(isRefresh: true);
  }

  //GET ANNOUNCEMENTS
  Future<void> getAnnouncements() async {
    await announcementHelper.fetch(isRefresh: true);
  }
}