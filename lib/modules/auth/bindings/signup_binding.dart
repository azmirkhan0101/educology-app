import 'package:dr_dina_educology/modules/auth/controllers/sign_up_controller.dart';
import 'package:get/get.dart';

class SignupBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
  }
}