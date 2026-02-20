import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailsController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  RxInt tabIndex = 0.obs;

  @override
  void onInit() {

    tabController = TabController(length: 4, vsync: this);

    tabController.addListener( _onTabChanged );

    super.onInit();
  }


  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    tabIndex.value = tabController.index;
  }
}