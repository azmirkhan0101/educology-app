import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>((){
      return HomeController();
    }, fenix: true);

  }

}