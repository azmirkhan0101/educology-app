import 'package:dr_dina_educology/modules/profile/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>((){
      return SettingsController();
    }, fenix: true);
  }
}