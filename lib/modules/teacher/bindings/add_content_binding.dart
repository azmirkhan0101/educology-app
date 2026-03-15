import 'package:dr_dina_educology/modules/teacher/controllers/add_content_controller.dart';
import 'package:get/get.dart';

class AddContentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddContentController>((){
      return AddContentController();
    }, fenix: true);
  }
}