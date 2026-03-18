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
  RxList<ClassModel> classes = <ClassModel>[].obs;
  RxBool isClassesLoading = false.obs;
  RxBool isClassesMoreLoading = false.obs;
  int classesCurrentPage = 1;
  bool classesHasMorePages = true;
  ScrollController classesScrollController = ScrollController();

  //HOMEWORK
  RxList<HomeworkExamModel> homeworks = <HomeworkExamModel>[].obs;
  RxBool isHomeworkLoading = false.obs;
  RxBool isHomeworkMoreLoading = false.obs;
  int homeworksCurrentPage = 1;
  bool homeworksHasMorePages = true;
  ScrollController homeworksScrollController = ScrollController();

  //EXAM
  RxList<HomeworkExamModel> exams = <HomeworkExamModel>[].obs;
  RxBool isExamLoading = false.obs;
  RxBool isExamMoreLoading = false.obs;
  int examsCurrentPage = 1;
  bool examsHasMorePages = true;
  ScrollController examsScrollController = ScrollController();

  //ANNOUNCEMENT
  RxList<AnnounceModel> announcements = <AnnounceModel>[].obs;
  RxBool isAnnouncementLoading = false.obs;
  RxBool isAnnouncementMoreLoading = false.obs;
  int announcementsCurrentPage = 1;
  bool announcementsHasMorePages = true;
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

    tabController.addListener(_onTabChanged);

    if (role == Role.teacher || role == Role.assistant) {
      getCourseStats(courseId: courseId);
    }

    //GET CLASSES IF EMPTY
    if (classes.isEmpty) {
      getClasses(refresh: true);
    }

    classesScrollController.addListener((){
      if( classesScrollController.position.pixels > classesScrollController.position.maxScrollExtent * 0.9 ){
        getClasses(refresh: false);
      }
    });

    homeworksScrollController.addListener((){
      if( homeworksScrollController.position.pixels > homeworksScrollController.position.maxScrollExtent * 0.9 ){
        getHomeworks(refresh: false);
      }
    });

    examsScrollController.addListener((){
      if( examsScrollController.position.pixels > examsScrollController.position.maxScrollExtent * 0.9 ){
        getExams(refresh: false);
      }
    });

    announcementsScrollController.addListener((){
      if( announcementsScrollController.position.pixels > announcementsScrollController.position.maxScrollExtent * 0.9 ){
        getAnnouncements(refresh: false);
      }
    });

    super.onInit();
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
    //0 - class, 1 - homework, 2 - exam, 3 - announcement

    switch (tabIndex.value) {
      case 0:
        if (classes.isEmpty && !isClassesLoading.value) {
          getClasses(refresh: true);
        }
        break;

      case 1:
        if (homeworks.isEmpty && !isHomeworkLoading.value) {
          getHomeworks(refresh: true);
        }
        break;

      case 2:
        if (exams.isEmpty && !isExamLoading.value) {
          getExams(refresh: true);
        }
        break;

      case 3:
        if (announcements.isEmpty && !isAnnouncementLoading.value) {
          getAnnouncements(refresh: true);
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
  Future<void> getClasses({bool refresh = true}) async {

    if( isClassesLoading.value ){
      return;
    }

    if( refresh ){
      classesCurrentPage = 1;
      classesHasMorePages = true;
      isClassesLoading.value = true;
    }else{
      if( isClassesMoreLoading.value || !classesHasMorePages ){
        return;
      }
      isClassesMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getClasses(courseId: courseId, page: classesCurrentPage),
    );
    isClassesLoading.value = false;
    isClassesMoreLoading.value = false;
    if (response.statusCode == 200) {
      final fetchedClasses =
          (response.data['data']['result'] as List<dynamic>?)
              ?.map((e) => ClassModel.fromJson(e))
              .toList() ??
          [];

      if( refresh ){
        classes.value = fetchedClasses;
      }else{
        classes.addAll(fetchedClasses);
      }
      if( fetchedClasses.length < 10 ){
        classesHasMorePages = false;
      }else{
        classesCurrentPage++;
      }

    }
  }

  //GET HOMEWORKS
  Future<void> getHomeworks({bool refresh = true}) async {

    if( refresh ){
      homeworksCurrentPage = 1;
      homeworksHasMorePages = true;
      isHomeworkLoading.value = true;
    }else{
      if( isHomeworkMoreLoading.value || !homeworksHasMorePages ){
        return;
      }
      isHomeworkMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getHomeworks(courseId: courseId, page: homeworksCurrentPage),
    );
    isHomeworkLoading.value = false;
    isHomeworkMoreLoading.value = false;
    if (response.statusCode == 200) {
      final fetchedHomeworks =
          (response.data['data']['result'] as List<dynamic>?)
              ?.map((e) => HomeworkExamModel.fromJson(e))
              .toList() ??
          [];

      if( refresh ){
        homeworks.value = fetchedHomeworks;
      }else{
        homeworks.addAll(fetchedHomeworks);
      }
      if( fetchedHomeworks.length < 10 ) {
        homeworksHasMorePages = false;
      }else{
        homeworksCurrentPage++;
      }
    }
  }

  //GET EXAMS
  Future<void> getExams({bool refresh = true}) async {

    if( refresh ){
      examsCurrentPage = 1;
      examsHasMorePages = true;
      isExamLoading.value = true;
    }else{
      if( isExamMoreLoading.value || !examsHasMorePages ){
        return;
      }
      isExamMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getExams(courseId: courseId, page: examsCurrentPage),
    );
    isExamLoading.value = false;
    isExamMoreLoading.value = false;
    if (response.statusCode == 200) {
      final fetchedExams =
          (response.data['data']['result'] as List<dynamic>?)?.map((e) {
            return HomeworkExamModel.fromJson(e);
          }).toList() ??
          [];
      if( refresh ){
        exams.value = fetchedExams;
      }else {
        exams.addAll(fetchedExams);
      }
      if( fetchedExams.length < 10 ){
        examsHasMorePages = false;
      }else{
        examsCurrentPage++;
      }
    }
  }

  //GET ANNOUNCEMENTS
  Future<void> getAnnouncements({bool refresh = true}) async {

    if( refresh ){
      announcementsCurrentPage = 1;
      announcementsHasMorePages = true;
      isAnnouncementLoading.value = true;
    }else{
      if( isAnnouncementMoreLoading.value || !announcementsHasMorePages ){
        return;
      }
      isAnnouncementMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getAnnouncements(courseId: courseId, page: announcementsCurrentPage),
    );
    isAnnouncementLoading.value = false;
    isAnnouncementMoreLoading.value = false;
    if (response.statusCode == 200) {
      final fetchedAnnouncements =
          (response.data['data']['result'] as List<dynamic>?)?.map((e) {
            return AnnounceModel.fromJson(e);
          }).toList() ??
          [];
      if( refresh ){
        announcements.value = fetchedAnnouncements;
      }else {
        announcements.addAll(fetchedAnnouncements);
      }
      if( fetchedAnnouncements.length < 10 ){
        announcementsHasMorePages = false;
      }else{
        announcementsCurrentPage++;
      }
    }
  }
}
