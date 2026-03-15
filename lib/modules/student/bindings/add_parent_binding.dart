import 'package:dr_dina_educology/modules/student/controllers/add_parent_controller.dart';
import 'package:get/get.dart';

class AddParentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddParentController>((){
      return AddParentController();
    }, fenix: true);
  }
}