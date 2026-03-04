import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class TermsController extends GetxController{

  @override
  void onInit() {

    if( terms.isEmpty ){
      getTerms();
    }

    super.onInit();
  }

  final ApiService apiService = Get.find<ApiService>();

  //PRIVACY POLICY
  RxString terms = "".obs;
  RxBool isTermsLoading = false.obs;

  //GET PRIVACY POLICY
  Future<void> getTerms() async {

    if( terms.value.isNotEmpty ){
      return;
    }

    if( isTermsLoading.value ){
      return;
    }

    isTermsLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
        method: "GET",
        isAuthRequired: false,
        endPoint: ApiEndpoints.termsAndConditions
    );
    isTermsLoading.value = false;

    if (response.statusCode == 200) {
      terms.value = response.data['data']['termsCondition'];
    }
  }
}