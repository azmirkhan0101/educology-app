import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/data/models/student_progress/student_progress_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class StudentProgressController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();
  final RoleService roleService = Get.find<RoleService>();

  Rxn<StaffModel> studentModel = Rxn<StaffModel>(null);
  Rxn<StaffModel> parentModel = Rxn<StaffModel>(null);
  Rxn<StudentProgressModel> studentProgress = Rxn<StudentProgressModel>(null);
  RxString alertMessage = "".obs;
  late String courseId;
  late String studentId;
  late Role role;

  @override
  void onInit() {

    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    studentId = Get.arguments['studentId'];

    if( studentProgress.value == null ){
      getStudentProgress(isParent: role == Role.parent);
    }

    super.onInit();
  }

  Future<void> getStudentProgress({required bool isParent}) async{
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: isParent ? ApiEndpoints.childProgress(courseId: courseId, childId: studentId) :ApiEndpoints.singleStudentProgress(courseId: courseId, studentId: studentId)
    );

    if( response.statusCode == 200 ){
      studentModel.value = StaffModel.fromJson(response.data['data']['studentInfo']);
      parentModel.value = StaffModel.fromJson(response.data['data']['parentInfo']);
      studentProgress.value = StudentProgressModel.fromJson(response.data['data']['academicStats']);
      alertMessage.value = response.data?['data']['alertMessage'] as String? ?? "";
    }

  }
}