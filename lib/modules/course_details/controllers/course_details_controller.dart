import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailsController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  RxInt tabIndex = 0.obs;
  final RoleService roleService = Get.find<RoleService>();
  late Role role;

  @override
  void onInit() {

    role = roleService.getUpdatedRole();
    tabController = TabController(length: 4, vsync: this);

    tabController.addListener( _onTabChanged );

    super.onInit();
  }


  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
  }
}