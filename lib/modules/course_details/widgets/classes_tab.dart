import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/data/models/class/class_model.dart';
import 'package:dr_dina_educology/data/models/content_details/content_details_model.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'class_item_widget.dart';

class ClassesTab extends StatelessWidget {

  final ScrollController scrollController;
  final bool isMoreLoading;
  final bool showAddButton;
  final bool isLoading;
  final List<ClassModel> classes;
  final VoidCallback onRefresh;
  final VoidCallback onAddClass;

  const ClassesTab({
    super.key,
    required this.scrollController,
    required this.isMoreLoading,
    required this.showAddButton,
    required this.isLoading,
    required this.classes,
    required this.onRefresh,
    required this.onAddClass
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primaryGold,
      onRefresh: () async {
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
                  onAddClass();
                },
              ),
            ),
          isLoading
              ? SizedBox(height: 100,
              child: const Center(child: CircularProgressIndicator(
                color: AppColors.primaryGold,)))
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
              : Expanded(child: mainBody(context)),
        ],
      ),
    );
  }

  //MAIN BODY
  Widget mainBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final ClassModel model = classes[index];

                return ClassItemWidget(
                  title: model.title,
                  startDate: model.startDate,
                  startTime: model.startTime,
                  createdAt: model.createdAt,
                  staff: model.teacher,
                  commentCount: model.comments.length,
                  onClick: () {
                    Get.toNamed(
                      AppRoutes.contentDetails,
                      arguments: {
                        "contentDetailsType": ContentDetailsType.cClass,
                        "contentDetailsModel": ContentDetailsModel.fromClassModel(
                            model)
                      },
                    );
                  },
                );
              },
            ),
        ),
        if (isMoreLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CircularProgressIndicator(color: AppColors.primaryGold)),
          )
      ],
    );
  }
}
