import 'package:dr_dina_educology/modules/home/screens/home_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// GetPage(
// name: AppRoutes.mainNav,
// page: (){
// return MainNavScreen();
// }
// ),


class MainNavController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}