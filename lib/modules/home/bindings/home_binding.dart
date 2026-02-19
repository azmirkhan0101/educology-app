import 'package:dr_dina_educology/modules/home/controllers/course_details_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<CourseDetailsController>((){
      return CourseDetailsController();
    });
  }

}