import 'package:dr_dina_educology/data/models/content_details/content_details_model.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/homework_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../data/models/homework_exam/homework_exam_model.dart';
import '../../../routes/app_pages.dart';

class ExamTab extends StatelessWidget {
  final ScrollController scrollController;
  final bool isMoreLoading;
  final bool showAddButton;
  final bool isStudent;
  final bool isLoading;
  final List<HomeworkExamModel> exams;
  final VoidCallback onRefresh;
  final VoidCallback onAddExam;

  const ExamTab({
    super.key,
    required this.scrollController,
    required this.isMoreLoading,
    required this.showAddButton,
    required this.isStudent,
    required this.isLoading,
    required this.exams,
    required this.onRefresh,
    required this.onAddExam
  });

  @override
  Widget build(BuildContext context) {
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
                label: AppStrings.addExam,
                prefixIcon: Icons.add,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 45,
                onPressed: () {
                  onAddExam();
                },
              ),
            ),
          isLoading
              ? SizedBox(
                  height: 100,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryGold,
                    ),
                  ),
                )
              : exams.isEmpty
              ? SizedBox(
                  height: 180,
                  child: const Center(
                    child: Text(
                      "No exams found.",
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
  mainBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: exams.length,
            itemBuilder: (context, index) {

              final HomeworkExamModel model = exams[index];

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
                      "contentDetailsType": ContentDetailsType.exam,
                      "contentDetailsModel": ContentDetailsModel.fromHomeworkExamModel(model),
                      "index" : index
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
