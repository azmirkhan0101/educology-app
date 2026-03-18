import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/data/models/course_overview/course_overview_stat.dart';
import 'package:dr_dina_educology/data/models/course_overview/student_status_model.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';

class CourseOverviewController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  Rxn<CourseOverviewStat> courseOverviewStat = Rxn<CourseOverviewStat>(null);
  RxList<StudentStatusModel> studentStatusList = <StudentStatusModel>[].obs;
  RxBool isLoading = false.obs;

  RxString selectedFilter = 'all'.obs;

  List<StudentStatusModel> get filteredStudentList {
    if (selectedFilter.value == 'all') {
      return studentStatusList;
    } else {
      return studentStatusList
          .where((student) => student.status == selectedFilter.value)
          .toList();
    }
  }

  late String courseId;

  @override
  void onInit() {

    courseId = Get.arguments;

    if( courseOverviewStat.value == null ){
      getCourseStat();
    }

    if( studentStatusList.isEmpty ){
      getStudentStatusList();
    }

    super.onInit();
  }

  //GET COURSE OVERVIEW STATS - ON TRACK, FALLING BEHIND....
  Future<void> getCourseStat() async {
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
      endPoint: ApiEndpoints.courseOverviewStats(courseId: courseId)
    );

    if (response.statusCode == 200) {
      final tempStat = response.data['data'];
      if (tempStat != null) {
        courseOverviewStat.value = CourseOverviewStat.fromJson(tempStat);
      }
    }
  }

  //GET STUDENT STATUS LIST
  Future<void> getStudentStatusList() async {
    isLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.studentStatusList(courseId: courseId)
    );
    isLoading.value = false;

    if (response.statusCode == 200) {
      final tempStats = response.data['data']['studentList'] as List<dynamic>?;
      studentStatusList.value = tempStats?.map((e){
        return StudentStatusModel.fromJson(e);
      }).toList() ?? [];
    }
  }
}
