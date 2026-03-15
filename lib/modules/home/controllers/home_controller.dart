import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/course_details/course_stat_model.dart';
import 'package:dr_dina_educology/data/models/home/staff_course_stats.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/home/course_model.dart';

class HomeController extends GetxController {

  //GET DATA BASED ON USER ROLE
  final RoleService roleService = Get.find<RoleService>();
  final ApiService apiService = Get.find<ApiService>();
  final ProfileController profileController = Get.isRegistered<ProfileController>() ? Get.find<ProfileController>() : Get.put<ProfileController>(ProfileController());

  late Role role;

  //COURSE COUNTS FOR TEACHER AND ASSISTANT
  Rxn<StaffCourseStats> staffCourseStats = Rxn<StaffCourseStats>(null);
  //MY ASSIGN COURSES FOR TEACHER AND ASSISTANT
  RxBool isMyAssignCoursesLoading = false.obs;
  RxList<CourseModel> myAssignCourses = <CourseModel>[].obs;


  @override
  void onInit() {

    role = roleService.getUpdatedRole();

    if( role == Role.teacher || role == Role.assistant ){
      getCourseCounts();
      //getMyAssignCourses();
    }

    if( myAssignCourses.isEmpty ){
      getMyAssignCourses();
    }

    super.onInit();
  }

  //GET COURSE COUNTS - TEACHER AND ASSISTANT
  Future<void> getCourseCounts() async{


    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.staffCourseStats
    );
    if( response.statusCode == 200 ){
      final tempStats = response.data['data'];
      if( tempStats != null ) {
        staffCourseStats.value = StaffCourseStats.fromJson(tempStats);
      }
    }
  }

  //GET MY ASSIGN COURSES - TEACHER AND ASSISTANT
  Future<void> getMyAssignCourses() async {
    if (isMyAssignCoursesLoading.value) {
      return;
    }

    isMyAssignCoursesLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.myAssignCourses
    );
    isMyAssignCoursesLoading.value = false;
    if( response.statusCode == 200 ){
      final tempList = response.data['data']['result'] as List<dynamic>?;
      if( tempList is List && tempList.isNotEmpty ){
        myAssignCourses.value = tempList.map<CourseModel>((e){
          return CourseModel.fromJson(e);
        }).toList();
      }else{
        myAssignCourses.value = [];
      }
    }

  }
}