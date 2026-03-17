import 'package:dr_dina_educology/modules/teacher/controllers/provide_mark_controller.dart';
import 'package:get/get.dart';

class ProvideMarkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut((){
      return ProvideMarkController();
    }, fenix: true);
  }
}