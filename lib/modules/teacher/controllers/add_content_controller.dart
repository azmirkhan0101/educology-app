import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

class AddContentController extends GetxController{

  late Map<String, dynamic> arguments;
  late String appTitle;
  late AddContentType contentType;

  @override
  void onInit() {

    arguments = Get.arguments;
    contentType = arguments["contentType"];
    appTitle = contentType.label;

    super.onInit();
  }
}