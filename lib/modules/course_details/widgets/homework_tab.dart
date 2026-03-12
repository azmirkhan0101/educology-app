import 'package:dr_dina_educology/data/models/homework_exam/homework_exam_model.dart';
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
  final bool isLoading;
  final List<HomeworkExamModel> homeworks;
  final VoidCallback onRefresh;

  const HomeworkTab({
    super.key,
    required this.showAddButton,
    required this.isStudent,
    required this.isLoading,
    required this.homeworks,
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
                label: AppStrings.addHomework,
                prefixIcon: Icons.add,
                gradient: AppColors.primaryButtonGradient,
                buttonHeight: 45,
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.addContent,
                    arguments: {"contentType": AddContentType.homeWork},
                  );
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
            child: const Center(
              child: Text(
                "No homeworks found.",
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
Widget mainBody(BuildContext context){
    return Expanded(
      child: ListView.builder(
        itemCount: homeworks.length,
        itemBuilder: (context, index) {

          final HomeworkExamModel model = homeworks[index];

          return HomeworkItemWidget(
            title: model.title,
            authorName: model.teacher.fullName,
            authorImageUrl: model.teacher.image,
            postDate: model.startDate,
            commentCount: model.comments.length,
            dueDate: model.endDate,
            isStudent: isStudent,
            onClick: () {
              Get.toNamed(
                AppRoutes.contentDetails,
                arguments: {
                  "contentDetailsType": ContentDetailsType.homeWork,
                  "homeworkExamModel": model,
                  "comments": model.comments
                },
              );
            },
          );
        }
      ),
    );
}
}
