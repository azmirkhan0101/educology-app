import 'package:get/get.dart';

import '../controllers/content_details_controller.dart';

class ContentDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContentDetailsController>((){
      return ContentDetailsController();
    }, fenix: true);

  }
}