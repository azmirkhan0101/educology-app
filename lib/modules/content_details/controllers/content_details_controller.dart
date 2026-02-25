import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

class ContentDetailsController extends GetxController{

  late Map<String, dynamic> arguments;
  late String appTitle;
  late ContentDetailsType contentDetailsType;
  final RoleService roleService = Get.find<RoleService>();
  late Role role;


  @override
  void onInit() {

    arguments = Get.arguments;
    contentDetailsType = arguments["contentDetailsType"];
    appTitle = contentDetailsType.label;
    role = roleService.getUpdatedRole();

    super.onInit();
  }
}