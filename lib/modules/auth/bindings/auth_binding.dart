import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';
import '../controllers/signin_controller.dart';
import '../controllers/reset_password_controller.dart';
import '../controllers/otp_verify_controller.dart';
import '../controllers/sign_up_controller.dart';
import '../controllers/verify_account_controller.dart';

class AuthBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController(), fenix: true);
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(), fenix: true);
    Get.lazyPut<VerifyAccountController>(() => VerifyAccountController(), fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(), fenix: true);
  }
}