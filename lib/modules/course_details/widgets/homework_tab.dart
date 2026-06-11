import 'package:dr_dina_educology/data/models/content_details/content_details_model.dart';
import 'package:dr_dina_educology/data/models/homework_exam/homework_exam_model.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/homework_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../routes/app_pages.dart';

class HomeworkTab extends StatelessWidget {

  final ScrollController scrollController;
  final bool isMoreLoading;
  final bool showAddButton;
  final bool isStudent;
  final bool isLoading;
  final List<HomeworkExamModel> homeworks;
  final VoidCallback onRefresh;
  final VoidCallback onAddHomework;

  const HomeworkTab({
    super.key,
    required this.scrollController,
    required this.isMoreLoading,
    required this.showAddButton,
    required this.isStudent,
    required this.isLoading,
    required this.homeworks,
    required this.onRefresh,
    required this.onAddHomework
  });

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      backgroundColor: Colors.white,
      color: AppColors.primaryGold,
      child: Column(
        children: [
          if (showAddButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ButtonWidget(
                label: AppStrings.addHomework,
                prefixIcon: Icons.add,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 45,
                buttonWidth: isTab ? context.fullWidth * 0.3 : null,
                onPressed: () {
                  onAddHomework();
                },
              ),
            ),
          isLoading
              ? SizedBox(height: 100,
              child: const Center(child: CircularProgressIndicator(
                color: AppColors.primaryGold,)))
              : homeworks.isEmpty
              ? SizedBox(
            height: 180,
            child: Center(
              child: Text(
                "No homeworks found.",
                style: TextStyle(fontSize: isTab ? 10.sp : 14, fontWeight: FontWeight.w700),
              ),
            ),
          )
              : Expanded(child: mainBody(context)),
        ],
      ),
    );
  }

  //MAIN BODY
Widget mainBody(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: homeworks.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              final HomeworkExamModel model = homeworks[index];

              return HomeworkExamItemWidget(
                title: model.title,
                staff: model.teacher,
                startDate: model.startDate,
                startTime: model.startTime,
                commentCount: model.comments.length,
                endDate: model.endDate,
                endTime: model.endTime,
                isStudent: isStudent,
                status: model.status,
                onClick: () {
                  Get.toNamed(
                    AppRoutes.contentDetails,
                    arguments: {
                      "contentDetailsType": ContentDetailsType.homeWork,
                      "contentDetailsModel": ContentDetailsModel.fromHomeworkExamModel(model),
                      "index" : index
                    },
                  );
                },
              );
            }
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
