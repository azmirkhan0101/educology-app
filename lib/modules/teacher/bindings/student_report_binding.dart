import 'package:get/get.dart';

import '../controllers/student_report_controller.dart';

class StudentReportBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StudentReportController>((){
      return StudentReportController();
    }, fenix: true);
  }
}