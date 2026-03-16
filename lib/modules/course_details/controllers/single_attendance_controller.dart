import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/attendance/attendance_stat_model.dart';
import 'package:dr_dina_educology/data/models/attendance/single_attendance_model.dart';
import 'package:get/get.dart';

class SingleAttendanceController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();
  final RoleService roleService = Get.find<RoleService>();

  RxInt totalCompletedClass = 0.obs;
  Rxn<AttendanceStatModel> attendanceStat = Rxn<AttendanceStatModel>(null);
  RxList<SingleAttendanceModel> attendanceList = <SingleAttendanceModel>[].obs;
  RxBool isLoading = false.obs;

  late String courseId;
  late String studentId;
  late Role role;

  @override
  void onInit() {

    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    studentId = Get.arguments['studentId'];

    getSingleStudentAttendance(
      isStudent: role == Role.student
    );

    super.onInit();
  }

  //GET SINGLE STUDENT ATTENDANCE
Future<void> getSingleStudentAttendance({required bool isStudent}) async{

    isLoading.value = true;

    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: isStudent ? ApiEndpoints.myAttendance(courseId: courseId) :
        ApiEndpoints.singleStudentAttendance(courseId: courseId, studentId: studentId)
    );
    isLoading.value = false;

    if( response.statusCode == 200 ){
      totalCompletedClass.value = response.data?['data']?['totalCompletedClass'] ?? 0;
      attendanceStat.value = AttendanceStatModel.fromJson(response.data?['data']?['stats'] ?? {});
      final tempAttendanceList = response.data?['data']?['attendanceList'] as List<dynamic>?;
      if( tempAttendanceList is List && tempAttendanceList.isNotEmpty ){
        attendanceList.value = tempAttendanceList.map((e) => SingleAttendanceModel.fromJson(e)).toList();
      }
    }
}
}