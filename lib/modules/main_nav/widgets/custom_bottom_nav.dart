import 'package:dr_dina_educology/modules/main_nav/controllers/main_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';

class CustomBottomNav extends GetView<MainNavController> {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return GetBuilder<MainNavController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, isTab, Icons.home_rounded, "Home"),
                    _buildNavItem(1, isTab, Icons.notifications_rounded, "Notifications"),
                    _buildNavItem(2, isTab, Icons.settings_rounded, "Settings"),
                    _buildNavItem(3, isTab, Icons.person_rounded, "Profile"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, bool isTab, IconData icon, String label) {

    final bool isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.changeIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: isTab ? 35 : 22,
                color: isSelected
                    ? const Color(0xFF344E67)
                    : Colors.grey[700],
              ),

              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                alignment: Alignment.centerLeft,
                widthFactor: isSelected ? 1 : 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: isSelected ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      label,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: isTab ? 10.sp : 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF344E67),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}