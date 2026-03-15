import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/attendance/attendance_stat_model.dart';
import '../../../data/models/take_attendance/take_attendance_model.dart';

class TakeAttendanceController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();

  RxBool isFormLoading = false.obs;
  RxBool isUploading = false.obs;
  RxInt totalStudents = 0.obs;
  Rxn<AttendanceStatModel> attendanceStat = Rxn<AttendanceStatModel>(null);
  RxList<TakeAttendanceModel> attendanceForm = <TakeAttendanceModel>[].obs;

  late String classId;

  @override
  void onInit() {

    classId = Get.arguments;
    if( attendanceForm.isEmpty ){
      getStudentsAttendanceForm();
    }

    super.onInit();
  }

  //GET STUDENTS ATTENDANCE FORM
  Future<void> getStudentsAttendanceForm() async{
    if( isFormLoading.value ){
      return;
    }

    isFormLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getAttendanceSheet(classId: classId)
    );
    isFormLoading.value = false;

    if( response.statusCode == 200 ){

      totalStudents.value = ((response.data?['data']?['totalStudents'] as num?) ?? 0).toInt();
      final tempAttendanceList = response.data?['data']?['studentList'] as List<dynamic>?;
      if( tempAttendanceList is List && tempAttendanceList.isNotEmpty ){
        attendanceForm.value = tempAttendanceList.map((e) => TakeAttendanceModel.fromJson(e)).toList();
      }
    }
  }

  //UPLOAD ATTENDANCE
  Future<void> uploadAttendance() async{

    if( isUploading.value ){
      return;
    }

    isUploading.value = true;

    //TODO: MAKE PAYLOAD FROM BACKEND FORMAT
    Map<String, dynamic> payLoad = {
      "course":"69918b0e5c764119a79a4191",
      "class":"6996c0c7484aa9cd689908af",
      "student":"69929d8b736809b04fda47c9",
      "date":"2026-02-17", //YYYY-MM-DD
      "time": "12:00 PM",
      "status":"late"  //on time , late, absent
    };

    ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.takeAttendance,
      body: payLoad
    );
    isUploading.value = false;

    String? message = response.data?["message"];

    if( response.statusCode == 201 ){
      showSnackBar(
          title: "Attendance submitted",
          message: message ?? "Attendance submitted successfully",
          backgroundColor: AppColors.greenPrimary
      );
    }else{
      showSnackBar(
          title: "Failed",
          message: message ?? "Something went wrong",
          backgroundColor: AppColors.errorRed
      );
    }

  }

}