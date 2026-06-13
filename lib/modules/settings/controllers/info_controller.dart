import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_response.dart';

class InfoController extends GetxController{

  final ApiService apiService = Get.find<ApiService>();

  late InfoPageType pageType;
  //INFO
  RxString info = "".obs;
  RxBool isInfoLoading = false.obs;

  @override
  void onInit() {

    pageType = Get.arguments as InfoPageType;

    if( info.isEmpty ){
      getInfo();
    }

    super.onInit();
  }

  //GET INFO - ABOUT US, PRIVACY POLICY, TERMS
  Future<void> getInfo() async {

    if( info.value.isNotEmpty || isInfoLoading.value){
      return;
    }
    isInfoLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: false,
        endPoint: pageType.endPoint
    );
    isInfoLoading.value = false;

    if (response.statusCode == 200) {
      info.value = response.data['data'][pageType.parseKey];
    }
  }

  @override
  void onClose() {

    info.value = "";
    isInfoLoading.value = false;

    super.onClose();
  }
}