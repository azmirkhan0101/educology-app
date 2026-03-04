import 'package:dr_dina_educology/modules/profile/controllers/about_us_controller.dart';
import 'package:get/get.dart';

class AboutUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>((){
      return AboutUsController();
    }, fenix: true);
  }
}