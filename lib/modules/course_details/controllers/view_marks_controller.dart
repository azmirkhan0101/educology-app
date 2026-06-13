import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';
import '../../../data/models/marks/marks_model.dart';

class ViewMarksController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();
  final RoleService roleService = Get.find<RoleService>();

  late String courseId;
  late String studentId;
  RxList<MarksModel> marksList = <MarksModel>[].obs;
  RxBool isLoading = false.obs;
  late Role role;

  @override
  void onInit() {

    role = roleService.getUpdatedRole();
    courseId = Get.arguments['courseId'];
    studentId = Get.arguments['studentId'];

    if( marksList.isEmpty ){
      getAllMarks(
          isParent: role == Role.parent,
        isStudent: role == Role.student
      );
    }

    super.onInit();
  }

  Future<void> getAllMarks({required bool isParent, required bool isStudent}) async{
    isLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: isParent ? ApiEndpoints.childAllMarks(courseId: courseId, childId: studentId)
          : isStudent ? ApiEndpoints.myMarks(courseId: courseId)
          : ApiEndpoints.singleStudentAllMarks(courseId: courseId, studentId: studentId),
      shouldPrint: true
    );
    isLoading.value = false;

    if( response.statusCode == 200 ){
      marksList.value = (response.data['data'] as List<dynamic>?)?.map((e) => MarksModel.fromJson(e)).toList() ?? [];
    }

  }
}