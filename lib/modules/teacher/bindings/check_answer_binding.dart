import 'package:get/get.dart';

import '../controllers/check_answer_controller.dart';

class CheckAnswerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut((){
      return CheckAnswerController();
    }, fenix: true);
  }
}