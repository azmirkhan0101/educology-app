import 'package:get/get.dart';

import '../controllers/course_overview_controller.dart';

class CourseOverviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CourseOverviewController>((){
      return CourseOverviewController();
    });
  }
}