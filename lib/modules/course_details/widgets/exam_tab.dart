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
  final bool showAddButton;
  final bool isStudent;
  final bool isLoading;
  final List<HomeworkExamModel> exams;
  final VoidCallback onRefresh;

  const ExamTab({
    super.key,
    required this.showAddButton,
    required this.isStudent,
    required this.isLoading,
    required this.exams,
    required this.onRefresh,
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
                  Get.toNamed(
                    AppRoutes.addContent,
                    arguments: {"contentType": AddContentType.exam},
                  );
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
              : mainBody(context),
        ],
      ),
    );
  }

  //MAIN BODY
  mainBody(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {

          final HomeworkExamModel model = exams[index];

          return HomeworkItemWidget(
            title: model.title,
            authorName: model.teacher.fullName,
            authorImageUrl: Dummy.profileImageUrl,
            postDate: model.startDate,
            commentCount: model.comments.length,
            dueDate: model.endDate,
            isStudent: isStudent,
            onClick: () {
              Get.toNamed(
                AppRoutes.contentDetails,
                arguments: {
                  "contentDetailsType": ContentDetailsType.exam,
                  "homeworkExamModel": model,
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
