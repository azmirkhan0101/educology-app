import 'package:dr_dina_educology/modules/home/screens/home_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavController extends GetxController {
  // Observable index for the current tab
  var currentIndex = 0.obs;

  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen()
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}