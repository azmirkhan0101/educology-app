import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class AboutUsController extends GetxController{

  @override
  void onInit() {

    if( aboutUs.isEmpty ){
      getAboutUs();
    }

    super.onInit();
  }

  final ApiService apiService = Get.find<ApiService>();

  //PRIVACY POLICY
  RxString aboutUs = "".obs;
  RxBool isAboutUsLoading = false.obs;

  //GET PRIVACY POLICY
  Future<void> getAboutUs() async {

    if( aboutUs.value.isNotEmpty ){
      return;
    }

    if( isAboutUsLoading.value ){
      return;
    }

    isAboutUsLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: false,
        endPoint: ApiEndpoints.aboutUs
    );
    isAboutUsLoading.value = false;

    if (response.statusCode == 200) {
      aboutUs.value = response.data['data']['aboutUs'];
    }
  }
}