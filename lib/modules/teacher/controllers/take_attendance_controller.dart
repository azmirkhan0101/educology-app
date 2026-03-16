import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/data/models/take_attendance/attendance_submit_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/attendance/attendance_stat_model.dart';
import '../../../data/models/take_attendance/attendance_form_model.dart';

class TakeAttendanceController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();

  RxBool isFormLoading = false.obs;
  RxBool isUploading = false.obs;
  RxInt totalStudents = 0.obs;
  Rxn<AttendanceStatModel> attendanceStat = Rxn<AttendanceStatModel>(null);
  RxList<AttendanceFormModel> attendanceForm = <AttendanceFormModel>[].obs;

  //ATTENDANCE SUBMIT LIST
  List<AttendanceSubmitModel> takeAttendanceSubmitList = [];

  late String classId;
  late String courseId;

  @override
  void onInit() {

    classId = Get.arguments['classId'];
    courseId = Get.arguments['courseId'];
    if( attendanceForm.isEmpty ){
      getStudentsAttendanceForm();
    }

    super.onInit();
  }

  //ADD ATTENDANCE TO LIST
  void addAttendanceSubmitList({required String status, required String studentId}){
    String statusEnum = AttendanceSubmitStatus.values.firstWhere((element) => element.label == status).label2;
    String dateString = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());
    AttendanceSubmitModel submitModel = AttendanceSubmitModel(
        courseId: courseId,
        classId: classId,
        studentId: studentId,
        date: dateString,
        time: time,
        status: statusEnum
    );
    takeAttendanceSubmitList.add(submitModel);
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
        attendanceForm.value = tempAttendanceList.map((e) => AttendanceFormModel.fromJson(e)).toList();
      }
    }
  }

  //UPLOAD ATTENDANCE
  Future<void> uploadAttendance() async{

    if( isUploading.value ){
      return;
    }

    isUploading.value = true;

    List<Map<String, dynamic>> mapList = takeAttendanceSubmitList.map((e){
      return e.toJson();
    }).toList();

    Map<String, dynamic> payLoad = {
      "attendances": mapList
    };

    print(payLoad);

    ApiResponse response = await apiService.networkRequest(
      method: "POST",
      isAuthRequired: true,
      endPoint: ApiEndpoints.takeAttendance,
      body: payLoad
    );
    isUploading.value = false;

    String? message = response.data?["message"];

    if( response.statusCode == 200 ){
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