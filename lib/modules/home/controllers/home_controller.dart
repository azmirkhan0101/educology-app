import 'package:dr_dina_educology/core/helpers/pagination_helper.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/home/staff_course_stats.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/home/course_model.dart';

class HomeController extends GetxController {
  //GET DATA BASED ON USER ROLE
  final RoleService roleService = Get.find<RoleService>();
  final ApiService apiService = Get.find<ApiService>();
  final ProfileController profileController =
      Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put<ProfileController>(ProfileController());

  late Role role;

  //COURSE COUNTS FOR TEACHER AND ASSISTANT
  Rxn<StaffCourseStats> staffCourseStats = Rxn<StaffCourseStats>(null);

  //COURSES
  PaginationHelper courseHelper = PaginationHelper<CourseModel>();
  ScrollController coursesScrollController = ScrollController();

  //CHILDREN FOR PARENT
  RxList<StaffModel> children = <StaffModel>[].obs;
  Rxn<StaffModel> selectedChild = Rxn<StaffModel>(null);

  @override
  void onInit() {
    role = roleService.getUpdatedRole();

    refreshHome();

    super.onInit();
  }

  //INIT COURSE HELPER
  void initCourseHelper({
    required bool isParent,
    required String Function(int) apiEndPoint
}){
    courseHelper.init(
        endPoint: (page) => apiEndPoint(page),
        fromJson: (json) => CourseModel.fromJson(json),
        listExtractor: (data) => isParent
            ? data['data']['enrolledCourses'] as List<dynamic>?
            : data['data']['result'] as List<dynamic>?
    );
  }

  //====================REFRESH========================
  Future<void> refreshHome() async {
    if (role == Role.teacher || role == Role.assistant) {
      getCourseCounts();
    }
    if (role != Role.parent) {
      initCourseHelper(
          isParent: false,
          apiEndPoint: (page) => ApiEndpoints.myAssignCourses(page: page)
      );
      getCourses();
    } else {
      getChildren();
    }
  }

  //GET COURSE COUNTS - TEACHER AND ASSISTANT
  Future<void> getCourseCounts() async {
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.staffCourseStats,
    );
    if (response.statusCode == 200) {
      final tempStats = response.data['data'];
      if (tempStats != null) {
        staffCourseStats.value = StaffCourseStats.fromJson(tempStats);
      }
    }
  }

  //GET MY ASSIGN COURSES - TEACHER, ASSISTANT AND STUDENT
  Future<void> getCourses() async{
    await courseHelper.fetch(isRefresh: true);
  }

  //REFRESH CHILD COURSES FOR PARENT ON DROPDOWN SELECTION
  Future<void> refreshChildCourses() async {
    if (selectedChild.value == null) {
      return;
    }
    initCourseHelper(
        isParent: true,
        apiEndPoint: (page) => ApiEndpoints.childCourses(page: page,childId: selectedChild.value!.id),
    );
    getCourses();
  }

  //GET CHILDREN FOR PARENT
  Future<void> getChildren() async {
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.myChildren,
    );
    if (response.statusCode == 200) {
      final tempList = response.data['data'] as List<dynamic>?;
      if (tempList is List && tempList.isNotEmpty) {
        children.value = tempList.map((e) {
          return StaffModel.fromJson(e);
        }).toList();
      }

      //SET THE FIRST CHILD AS SELECTED CHILD
      if (children.isNotEmpty) {
        selectedChild.value = children[0];
      }
      refreshChildCourses();
    }
  }
}
