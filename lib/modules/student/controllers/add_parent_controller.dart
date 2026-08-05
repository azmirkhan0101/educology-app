import 'package:dr_dina_educology/core/helpers/pagination_helper.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/show_snackbar.dart';
import 'package:dr_dina_educology/data/models/staff/staff_model.dart';
import 'package:dr_dina_educology/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/utils/api_endpoints.dart';
import '../../../core/utils/api_response.dart';

class AddParentController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final ProfileController profileController =
  Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  RxBool isUploading = false.obs;

  // Track filtered items for screen display and active search queries
  RxList<StaffModel> filteredParents = <StaffModel>[].obs;
  RxString selectedParentId = "".obs;
  RxString searchQuery = "".obs;

  // PAGINATION HELPER
  final parentListHelper = PaginationHelper<StaffModel>();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    initParentHelper();

    // Sync filteredParents directly with helper items when they update
    ever(parentListHelper.items, (List<StaffModel> items) {
      filteredParents.assignAll(items);
    });

    // Debounce the search input by 500ms to avoid unnecessary API requests while typing
    debounce(searchQuery, (String query) {
      getParentList();
    }, time: const Duration(milliseconds: 500));

    if (parentListHelper.items.isEmpty) {
      getParentList();
    }

    super.onInit();
  }

  // INITIALIZE PAGINATION HELPER
  void initParentHelper() {
    parentListHelper.init(
      // The closure dynamically reads the latest searchQuery.value during evaluation
        endPoint: (page) => ApiEndpoints.getAllParents(
          page: page,
          search: searchQuery.value,
        ),
        fromJson: (json) => StaffModel.fromJson(json),
        listExtractor: (data) => data['data']['result'] as List<dynamic>?,
        scrollController: scrollController
    );
  }

  // GET PARENTS LIST
  Future<void> getParentList() async {
    await parentListHelper.fetch(isRefresh: true);
  }

  // =====================ADD PARENT=========================
  Future<void> addParent() async {
    if (isUploading.value) {
      return;
    }

    if (selectedParentId.value.isEmpty) {
      showSnackBar(
          title: "Failed!",
          message: "Please select a parent",
          backgroundColor: AppColors.warningYellow);
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
          backgroundColor: AppColors.greenPrimary);
    }
  }

  void filterParents(String query) {
    searchQuery.value = query; // Updating the observable triggers the debounce worker
  }
}