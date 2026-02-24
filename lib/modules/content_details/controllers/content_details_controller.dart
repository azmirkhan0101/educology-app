import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

class ContentDetailsController extends GetxController{

  late Map<String, dynamic> arguments;
  late String appTitle;
  late ContentDetailsType contentDetailsType;

  @override
  void onInit() {

    arguments = Get.arguments;
    contentDetailsType = arguments["contentDetailsType"];
    appTitle = contentDetailsType.label;

    super.onInit();
  }
}