import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/data/models/course_overview/course_overview_stat.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';

class CourseOverviewController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  Rxn<CourseOverviewStat> courseOverviewStat = Rxn<CourseOverviewStat>(null);

  late String courseId;

  @override
  void onInit() {

    courseId = Get.arguments;
    getCourseStat();

    // if( courseOverviewStat.value != null ){
    //   getCourseStat();
    // }

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
}
