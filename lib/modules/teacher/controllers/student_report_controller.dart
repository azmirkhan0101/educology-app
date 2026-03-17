import 'package:dr_dina_educology/modules/teacher/controllers/report_exporter.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_snackbar.dart';
import '../../../data/models/student_report/student_report_model.dart';

class StudentReportController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  RxBool isStudentReportLoading = false.obs;
  RxList<StudentReportModel> studentReportList = <StudentReportModel>[].obs;
  late String courseId;

  @override
  void onInit() {
    courseId = Get.arguments ?? "";

    if (studentReportList.isEmpty) {
      getStudentReport();
    }

    super.onInit();
  }

  //EXPORT REPORT AS PDF
  Future<void> exportToPdf() async {
    if (studentReportList.isEmpty) {
      showSnackBar(
        title: "No data found",
        message: "No report data found to export.",
        backgroundColor: AppColors.warningYellow,
      );
      return;
    }
    AnalyticsExporter exporter = AnalyticsExporter();
    exporter.exportToPDF(studentReportList);
  }

  //GET STUDENT REPORT
  Future<void> getStudentReport() async {
    isStudentReportLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.studentReport(courseId: courseId),
    );
    isStudentReportLoading.value = false;

    if (response.statusCode == 200) {
      final tempData = response.data['data'] as List<dynamic>?;
      if (tempData is List && tempData.isNotEmpty) {
        studentReportList.value = tempData
            .map((e) => StudentReportModel.fromJson(e))
            .toList();
      } else {
        studentReportList.value = [];
      }
    }
  }
}
