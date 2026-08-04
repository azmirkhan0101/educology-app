import 'package:dr_dina_educology/modules/teacher/controllers/provide__offline_mark_controller.dart';
import 'package:get/get.dart';

class ProvideOfflineMarkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut((){
      return ProvideOfflineMarkController();
    }, fenix: true);
  }
}