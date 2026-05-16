import 'package:dr_dina_educology/modules/settings/controllers/info_controller.dart';
import 'package:get/get.dart';

class InfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InfoController>((){
      return InfoController();
    }, fenix: true);
  }
}