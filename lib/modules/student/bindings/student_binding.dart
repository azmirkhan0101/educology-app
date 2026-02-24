import 'package:dr_dina_educology/modules/student/controllers/add_parent_controller.dart';
import 'package:get/get.dart';

class StudentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddParentController>((){
      return AddParentController();
    }, fenix: true);
  }
}