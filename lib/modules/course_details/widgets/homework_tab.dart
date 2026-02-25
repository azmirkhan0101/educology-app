import 'package:dr_dina_educology/modules/course_details/widgets/homework_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../routes/app_pages.dart';

class HomeworkTab extends StatelessWidget {

  final bool showAddButton;
  final bool isStudent;

  const HomeworkTab({super.key, required this.showAddButton, required this.isStudent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if( showAddButton )
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ButtonWidget(
            label: AppStrings.addHomework,
            prefixIcon: Icons.add,
            gradient: AppColors.primaryButtonGradient,
            buttonHeight: 45,
            onPressed: (){
              Get.toNamed(AppRoutes.addContent, arguments: {"contentType" : AddContentType.homeWork});
            },
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: Dummy.profileImageUrl,
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM",
              isStudent: isStudent,
              onClick: (){
        Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.homeWork});
        },
              ),
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: Dummy.profileImageUrl,
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM",
                isStudent: isStudent,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.homeWork});
                },
              ),
              HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: Dummy.profileImageUrl,
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM",
                isStudent: isStudent,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.homeWork});
                },
              ),HomeworkItemWidget(
                  title: "HW 1",
                  authorName: "Azmir Khan",
                  authorImageUrl: Dummy.profileImageUrl,
                  postDate: "20 Feb 2026 | 10:00 AM",
                  commentCount: "3",
                  dueDate: "20 Feb 2026 | 10:00 AM",
                isStudent: isStudent,
                onClick: (){
                  Get.toNamed(AppRoutes.contentDetails, arguments: {"contentDetailsType" : ContentDetailsType.homeWork});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
