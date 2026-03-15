import 'package:dr_dina_educology/modules/teacher/controllers/take_attendance_controller.dart';
import 'package:get/get.dart';

class TakeAttendanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TakeAttendanceController>((){
      return TakeAttendanceController();
    }, fenix: true);
  }
}