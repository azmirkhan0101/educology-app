import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'class_item_widget.dart';

class ClassesTab extends StatelessWidget {

  final bool showAddButton;

  const ClassesTab({
    super.key,
    required this.showAddButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( showAddButton )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ButtonWidget(
              label: AppStrings.addClass,
            prefixIcon: Icons.add,
            gradient: AppColors.primaryButtonGradient,
            buttonHeight: 45,
            onPressed: (){
                Get.toNamed(AppRoutes.addContent, arguments: {"contentType" : AddContentType.cClass});
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ClassItemWidget(
                  title: "Name",
                  liveTime: "20 Dec 2026 | 10:00 AM",
                  instructorName: "Azmir Khan",
                  postDate: "20 Dec 2026 | 10:00 AM",
                  instructorImageUrl: Dummy.profileImageUrl,
                  commentCount: 3,
              onClick: (){
        Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.cClass});
        },
              ),
              ClassItemWidget(
                  title: "Name",
                  liveTime: "20 Dec 2026 | 10:00 AM",
                  instructorName: "Azmir Khan",
                  postDate: "20 Dec 2026 | 10:00 AM",
                  instructorImageUrl: Dummy.profileImageUrl,
                  commentCount: 3,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.cClass});
                },
              ),
              ClassItemWidget(
                  title: "Name",
                  liveTime: "20 Dec 2026 | 10:00 AM",
                  instructorName: "Azmir Khan",
                  postDate: "20 Dec 2026 | 10:00 AM",
                  instructorImageUrl: Dummy.profileImageUrl,
                  commentCount: 3,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.cClass});
                },
              ),
              ClassItemWidget(
                  title: "Name",
                  liveTime: "20 Dec 2026 | 10:00 AM",
                  instructorName: "Azmir Khan",
                  postDate: "20 Dec 2026 | 10:00 AM",
                  instructorImageUrl: Dummy.profileImageUrl,
                  commentCount: 3,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.cClass});
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
