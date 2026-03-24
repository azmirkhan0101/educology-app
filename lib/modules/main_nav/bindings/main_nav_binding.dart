import 'package:dr_dina_educology/modules/home/controllers/notification_controller.dart';
import 'package:dr_dina_educology/modules/main_nav/controllers/main_nav_controller.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:dr_dina_educology/modules/profile/controllers/settings_controller.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class MainNavBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainNavController>((){
      return MainNavController();
    }, fenix: true);
    Get.lazyPut<HomeController>((){
      return HomeController();
    }, fenix: true);
    Get.lazyPut<NotificationController>((){
      return NotificationController();
    }, fenix: true);
    Get.lazyPut<SettingsController>((){
      return SettingsController();
    }, fenix: true);
    Get.lazyPut<ProfileController>((){
      return ProfileController();
    }, fenix: true);
  }

}