import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/course_details/course_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';

class CourseDetailsController extends GetxController with GetSingleTickerProviderStateMixin{

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

  @override
  void onInit() {

    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    courseName = Get.arguments['courseName'];
    subject = Get.arguments['subject'];
    status = Get.arguments['status'];

    tabController = TabController(length: 4, vsync: this);

    tabController.addListener( _onTabChanged );

    if( role == Role.teacher || role == Role.assistant ){
      getCourseStats(courseId: courseId);
    }

    super.onInit();
  }


  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
  }


  //GET STATISTICS
Future<void> getCourseStats({required String courseId}) async{

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.overallCourseStats(courseID: courseId)
    );

    if( response.statusCode == 200 ){
      final tempData = response.data['data'] as Map<String, dynamic>?;
      if( tempData != null ) {
        courseStat.value = CourseStatModel.fromJson(tempData);
      }
    }
}
}