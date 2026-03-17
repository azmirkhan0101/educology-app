import 'package:dr_dina_educology/core/services/api_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/api_response.dart';
import 'package:get/get.dart';

import '../../../data/models/answer/answer_model.dart';

class CheckAnswerController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  RxBool isLoading = false.obs;
  RxList<AnswerModel> answers = <AnswerModel>[].obs;

  late String taskId;
  late bool isExam;

  @override
  void onInit() {

    taskId = Get.arguments?['taskId'] ?? "";
    isExam = Get.arguments?['isExam'] ?? true;

    if (answers.isEmpty) {
      getAnswers();
    }

    super.onInit();
  }

  //============================GET ANSWERS======================
  Future<void> getAnswers() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: true,
        endPoint: ApiEndpoints.getTaskAnswer(taskId: taskId, isExam: isExam)
    );
    isLoading.value = false;

    if (response.statusCode == 200) {
      final tempAnswers = response.data['data']['result'] as List<dynamic>?;
      if( tempAnswers is List && tempAnswers.isNotEmpty ){
        answers.value = tempAnswers.map((e){
          return AnswerModel.fromJson(e);
        }).toList();
      }
    }
  }
}
