import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:get/get.dart';

class CourseDetailsBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<CourseDetailsController>((){
      return CourseDetailsController();
    });
  }

}