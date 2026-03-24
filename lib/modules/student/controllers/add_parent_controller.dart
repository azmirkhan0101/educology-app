import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class AddParentController extends GetxController {

  final ApiService apiService = Get.find<ApiService>();
  final ProfileController profileController = Get.isRegistered<ProfileController>() ? Get.find<ProfileController>() : Get.put(ProfileController());

  RxBool isParentsLoading = false.obs;
  RxBool isUploading = false.obs;
  RxList<StaffModel> parents = <StaffModel>[].obs;
  //FILTER FOR SEARCH
  RxList<StaffModel> filteredParents = <StaffModel>[].obs;
  RxString selectedParentId = "".obs;

  @override
  void onInit() {
    if (parents.isEmpty) {
      getAllParents();
    }

    super.onInit();
  }

  //GET ALL PARENTS
  Future<void> getAllParents() async {
    if (isParentsLoading.value) {
      return;
    }

    isParentsLoading.value = true;
    ApiResponse response = await apiService.networkRequest(
      method: "GET",
      isAuthRequired: true,
      endPoint: ApiEndpoints.getAllParents,
    );
    isParentsLoading.value = false;
    if (response.statusCode == 200) {
      final tempList = response.data['data']['result'] as List<dynamic>?;
      if (tempList is List && tempList.isNotEmpty) {
        parents.value = tempList.map((e) => StaffModel.fromJson(e)).toList();
        filteredParents.assignAll(parents);
      }
    }
  }

  //=====================ADD PARENT=========================
  Future<void> addParent() async {
    if (isUploading.value) {
      return;
    }

    if( selectedParentId.value.isEmpty ){
      showSnackBar(
          title: "Failed!",
          message: "Please select a parent",
          backgroundColor: AppColors.warningYellow
      );
      return;
    }

    isUploading.value = true;
    Map<String, dynamic> payLoad = {"parentId": selectedParentId.value};

    ApiResponse response = await apiService.networkRequest(
      method: "PATCH",
      isAuthRequired: true,
      endPoint: ApiEndpoints.addParent,
      body: payLoad,
    );
    isUploading.value = false;
    if (response.statusCode == 200) {
      profileController.getProfile();
      Get.back();
      showSnackBar(
          title: "Added!",
          message: "Your parent has been added successfully",
          backgroundColor: AppColors.greenPrimary
      );
    }
  }


  void filterParents(String query) {
    if (query.isEmpty) {
      filteredParents.assignAll(parents);
    } else {
      filteredParents.assignAll(
        parents.where((parent) {
          final name = parent.fullName.toLowerCase();
          final phone = parent.contact.toLowerCase();
          return name.contains(query.toLowerCase()) || phone.contains(query.toLowerCase());
        }).toList()
      );
    }
  }
}
