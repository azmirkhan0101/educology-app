import 'package:dr_dina_educology/modules/profile/controllers/privacy_controller.dart';
import 'package:get/get.dart';

class PrivacyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PrivacyController>((){
      return PrivacyController();
    }, fenix: true);
  }
}