import 'package:dr_dina_educology/modules/auth/controllers/otp_verify_controller.dart';
import 'package:get/get.dart';

class OtpVerifyBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController(), fenix: true);
  }
}