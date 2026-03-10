import 'package:dr_dina_educology/modules/course_details/controllers/view_marks_controller.dart';
import 'package:get/get.dart';

class ViewMarksBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ViewMarksController>((){
      return ViewMarksController();
    });
  }

}