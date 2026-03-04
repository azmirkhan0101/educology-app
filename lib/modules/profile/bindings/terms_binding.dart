import 'package:dr_dina_educology/modules/profile/controllers/privacy_controller.dart';
import 'package:dr_dina_educology/modules/profile/controllers/terms_controller.dart';
import 'package:get/get.dart';

class TermsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TermsController>((){
      return TermsController();
    }, fenix: true);
  }
}