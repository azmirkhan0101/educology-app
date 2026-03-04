import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class PrivacyController extends GetxController{

  @override
  void onInit() {

    if( privacyPolicy.isEmpty ){
      getPrivacyPolicy();    }

    super.onInit();
  }

  final ApiService apiService = Get.find<ApiService>();

  //PRIVACY POLICY
  RxString privacyPolicy = "".obs;
  RxBool isPrivacyPolicyLoading = false.obs;

  //GET PRIVACY POLICY
  Future<void> getPrivacyPolicy() async {

    if( privacyPolicy.value.isNotEmpty ){
      return;
    }

    if( isPrivacyPolicyLoading.value ){
      return;
    }

    isPrivacyPolicyLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: false,
        endPoint: ApiEndpoints.privacyPolicy
    );
    isPrivacyPolicyLoading.value = false;

    if (response.statusCode == 200) {
      privacyPolicy.value = response.data['data']['privacyPolicy'];
    }
  }
}