import 'package:get/get.dart';

import '../controllers/single_attendance_controller.dart';

class SingleAttendanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SingleAttendanceController>((){
      return SingleAttendanceController();
    }, fenix: true);
  }
}