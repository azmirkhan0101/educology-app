import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/modules/home/screens/home_screen.dart';
import 'package:dr_dina_educology/modules/home/screens/notification_screen.dart';
import 'package:dr_dina_educology/modules/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/screens/settings_screen.dart';
import '../controllers/main_nav_controller.dart';
import '../widgets/custom_bottom_nav.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Obx((){
          return IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeScreen(),
              NotificationScreen(),
              SettingsScreen(),
              ProfileScreen()
            ],
          );
        }),
        bottomNavigationBar: CustomBottomNav(),
    );
  }
}