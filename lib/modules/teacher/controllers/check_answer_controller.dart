import 'package:dr_dina_educology/core/helpers/pagination_helper.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/answer/answer_model.dart';

class CheckAnswerController extends GetxController {

  PaginationHelper<AnswerModel> answerHelper = PaginationHelper<AnswerModel>();
  final ScrollController answerScrollController = ScrollController();
  late String taskId;
  late bool isExam;

  @override
  void onInit() {
    taskId = Get.arguments?['taskId'] ?? "";
    isExam = Get.arguments?['isExam'] ?? true;

    initAnswerHelper();
    getAnswers();

    super.onInit();
  }

  //MARK AS PROVIDED
  void markAsProvided({required int index}){
    answerHelper.items[index].isMarked.value = true;
    answerHelper.items.refresh();
  }

  //INIT ANSWER HELPER
  void initAnswerHelper(){
    answerHelper.init(
        endPoint: (page) => ApiEndpoints.getTaskAnswer(page: page, taskId: taskId, isExam: isExam),
        fromJson: (json) => AnswerModel.fromJson(json),
        listExtractor: (data) => data['data']['result'] as List<dynamic>?,
      scrollController: answerScrollController
    );
  }

  //============================GET ANSWERS======================
  Future<void> getAnswers() async {
    try {
      await answerHelper.fetch(isRefresh: true, shouldPrint: true);
      print("Fetch completed. Items count: ${answerHelper.items.length}");
      
      if (answerHelper.items.isNotEmpty) {
        print("First Item isMarked: ${answerHelper.items[0].isMarked.value}");
      }
    } catch (e) {
      print("Huge error in getAnswers: $e");
    }
  }
}
