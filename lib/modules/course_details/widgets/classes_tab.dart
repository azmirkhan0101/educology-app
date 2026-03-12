import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/data/models/class/class_model.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'class_item_widget.dart';

class ClassesTab extends StatelessWidget {
  final bool showAddButton;
  final bool isLoading;
  final List<ClassModel> classes;
  final VoidCallback onRefresh;

  const ClassesTab({
    super.key,
    required this.showAddButton,
    required this.isLoading,
    required this.classes,
    required this.onRefresh
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primaryGold,
      onRefresh: () async{
        onRefresh();
      },
      child: Column(
        children: [
          if (showAddButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ButtonWidget(
                label: AppStrings.addClass,
                prefixIcon: Icons.add,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 45,
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.addContent,
                    arguments: {"contentType": AddContentType.cClass},
                  );
                },
              ),
            ),
          isLoading
              ? SizedBox( height: 100,child: const Center(child: CircularProgressIndicator(color: AppColors.primaryGold,)))
              : classes.isEmpty
              ? SizedBox(
                  height: 180,
                  child: const Center(
                    child: Text(
                      "No classes found.",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              : mainBody(context),
        ],
      ),
    );
  }

  //MAIN BODY
  Widget mainBody(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final ClassModel model = classes[index];

          return ClassItemWidget(
            title: model.title,
            liveTime: model.time,
            instructorName: model.teacher.fullName,
            postDate: model.endDate,
            instructorImageUrl: model.teacher.image,
            commentCount: model.comments.length,
            onClick: () {
              Get.toNamed(
                AppRoutes.contentDetails,
                arguments: {
                  "contentDetailsType": ContentDetailsType.cClass,
                  "classModel": model,
                  "comments": model.comments
                },
              );
            },
          );
        },
      ),
    );
  }
}
