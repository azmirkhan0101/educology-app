import 'package:dr_dina_educology/modules/student/controllers/submit_answer_controller.dart';
import 'package:get/get.dart';

class SubmitAnswerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SubmitAnswerController>((){
      return SubmitAnswerController();
    }, fenix: true);
  }
}