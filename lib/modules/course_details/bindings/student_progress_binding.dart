import 'package:get/get.dart';

import '../controllers/student_progress_controller.dart';

class StudentProgressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StudentProgressController>(() => StudentProgressController());
  }
}