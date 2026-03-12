import 'package:dr_dina_educology/modules/content_details/controllers/announce_details_controller.dart';
import 'package:get/get.dart';

class AnnounceDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AnnounceDetailsController>((){
      return AnnounceDetailsController();
    }, fenix: true);

  }
}