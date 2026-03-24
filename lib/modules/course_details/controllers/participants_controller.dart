import 'package:dr_dina_educology/data/models/course_overview/student_status_model.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class ParticipantsController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();
  Rxn<StaffModel> teacherModel = Rxn<StaffModel>(null);
  Rxn<StaffModel> assistantModel = Rxn<StaffModel>(null);
  RxList<StudentStatusModel> participantsList = <StudentStatusModel>[].obs;
  //FILTER FOR SEARCH
  RxList<StudentStatusModel> filteredParticipantsList = <StudentStatusModel>[].obs;
  RxBool isLoading = false.obs;

  late String courseId;

  @override
  void onInit() {

    courseId = Get.arguments;

    if( participantsList.isEmpty ){
      getStudentStatusList();
    }

    super.onInit();
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
      final tempTeacher = response.data['data']['instructorInfo']['teacher'];
      final tempAssistant = response.data['data']['instructorInfo']['assistant'];
      if( tempTeacher != null ){
        teacherModel.value = StaffModel.fromJson(tempTeacher);
      }
      if( tempAssistant != null ){
        assistantModel.value = StaffModel.fromJson(tempAssistant);
      }
      final tempStats = response.data['data']['studentList'];
      if ( tempStats is List && tempStats.isNotEmpty ) {
        participantsList.value = tempStats.map((e) => StudentStatusModel.fromJson(e)).toList();
        filteredParticipantsList.assignAll(participantsList);
      }
    }
  }

  void filterParticipants(String query) {
    if (query.isEmpty) {
      filteredParticipantsList.assignAll(participantsList);
    } else {
      filteredParticipantsList.assignAll(
          participantsList.where((parent) {
            final name = parent.fullName.toLowerCase();
            final phone = parent.contact.toLowerCase();
            return name.contains(query.toLowerCase()) || phone.contains(query.toLowerCase());
          }).toList()
      );
    }
  }
}