import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/course_details/course_stat_model.dart';
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
  RxBool isCoursesLoading = false.obs;
  RxBool isCoursesMoreLoading = false.obs;
  RxList<CourseModel> courses = <CourseModel>[].obs;
  ScrollController coursesScrollController = ScrollController();
  int coursesCurrentPage = 1;
  bool coursesHasMorePages = true;

  //CHILDREN FOR PARENT
  RxList<StaffModel> children = <StaffModel>[].obs;
  Rxn<StaffModel> selectedChild = Rxn<StaffModel>(null);

  @override
  void onInit() {
    role = roleService.getUpdatedRole();

    refreshHome();

    coursesScrollController.addListener(() {
      if (coursesScrollController.position.pixels >
          coursesScrollController.position.maxScrollExtent * 0.9) {
        if (role == Role.parent) {
          getCourses(
              refresh: false,
              isParent: true,
              apiEndPoint: ApiEndpoints.childCourses(page: coursesCurrentPage,childId: selectedChild.value!.id)
          );
        } else {
          getCourses(
            refresh: false,
            isParent: false,
            apiEndPoint: ApiEndpoints.myAssignCourses(page: coursesCurrentPage)
          );
        }
      }
    });

    super.onInit();
  }

  //====================REFRESH========================
  Future<void> refreshHome() async {
    if (role == Role.teacher || role == Role.assistant) {
      getCourseCounts();
    }
    if (role != Role.parent) {
      getCourses(
        refresh: true,
        isParent: false,
        apiEndPoint: ApiEndpoints.myAssignCourses(page: coursesCurrentPage),
      );
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
  Future<void> getCourses({
    bool refresh = true,
    required bool isParent,
    required String apiEndPoint,
  }) async {
    if (isCoursesLoading.value) {
      return;
    }

    if (refresh) {
      coursesCurrentPage = 1;
      coursesHasMorePages = true;
      isCoursesLoading.value = true;
    } else {
      if (isCoursesMoreLoading.value || !coursesHasMorePages) return;
      isCoursesMoreLoading.value = true;
    }

    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: apiEndPoint,
    );
    isCoursesLoading.value = false;
    isCoursesMoreLoading.value = false;

    if (response.statusCode == 200) {
      final List<dynamic>? tempList;
      if (isParent) {
        tempList = response.data['data']['enrolledCourses'] as List<dynamic>?;
      } else {
        tempList = response.data['data']['result'] as List<dynamic>?;
      }
      if (tempList is List && tempList.isNotEmpty) {
        final fetchedCourses = tempList.map<CourseModel>((e) {
          return CourseModel.fromJson(e);
        }).toList();
        if (refresh) {
          courses.value = fetchedCourses;
        } else {
          courses.addAll(fetchedCourses);
        }
        if (fetchedCourses.length < 10) {
          coursesHasMorePages = false;
        } else {
          coursesCurrentPage++;
        }
      } else {
        courses.value = [];
      }
    }
  }

  //REFRESH CHILD COURSES FOR PARENT ON DROPDOWN SELECTION
  Future<void> refreshChildCourses() async {
    if (isCoursesLoading.value || selectedChild.value == null) {
      return;
    }
    getCourses(
      refresh: true,
      isParent: true,
      apiEndPoint: ApiEndpoints.childCourses(page: coursesCurrentPage,childId: selectedChild.value!.id),
    );
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
