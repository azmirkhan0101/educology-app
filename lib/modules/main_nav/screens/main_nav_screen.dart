import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/modules/home/screens/home_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_nav_controller.dart';
import '../widgets/custom_bottom_nav.dart';

class MainNavScreen extends StatelessWidget {

  final MainNavController controller = Get.isRegistered<MainNavController>() ? Get.find<MainNavController>() : Get.put(MainNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Background to match your screenshot
      body: Obx((){
        if( controller.currentIndex.value == 0 ){
          return HomeScreen();
        }else if( controller.currentIndex.value == 3 ){
          return ProfileScreen();
        }else{
          return Center(child: Text("Page not found"));
        }
      }),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}