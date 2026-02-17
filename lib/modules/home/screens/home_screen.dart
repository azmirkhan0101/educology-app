import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_banner.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_header_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          HomeHeaderWidget(profileImageUrl: "", userName: "Azmir Khan"),
          HomeBanner()
        ],
      ),
    );
  }
}
