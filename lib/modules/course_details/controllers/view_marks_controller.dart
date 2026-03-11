import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/data/models/student_progress/student_progress_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/marks/marks_model.dart';

class ViewMarksController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();
  late String courseId;
  late String studentId;
  RxList<MarksModel> marksList = <MarksModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {

    courseId = Get.arguments['courseId'];
    studentId = Get.arguments['studentId'];

    if( marksList.isEmpty ){
      getAllMarks();
    }

    super.onInit();
  }

  Future<void> getAllMarks() async{
    isLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.singleStudentAllMarks(courseId: courseId, studentId: studentId)
    );
    isLoading.value = false;

    if( response.statusCode == 200 ){
      marksList.value = (response.data['data'] as List<dynamic>?)?.map((e) => MarksModel.fromJson(e)).toList() ?? [];
    }

  }
}