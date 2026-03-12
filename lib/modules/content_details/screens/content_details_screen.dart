import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/cached_image_widget.dart';
import 'package:dr_dina_educology/modules/content_details/controllers/content_details_controller.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/comment_tile_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/widgets/showCommentDialog.dart';
import '../../../data/models/comment/comment_model.dart';

class ContentDetailsScreen extends StatelessWidget {
  ContentDetailsScreen({super.key});

  final ContentDetailsController controller =
      Get.find<ContentDetailsController>();

  @override
  Widget build(BuildContext context) {
    Role role = controller.role;
    bool isTeacher = role == Role.teacher || role == Role.assistant;
    bool isStudent = role == Role.student;
    bool isExam =
        controller.contentDetailsType == ContentDetailsType.exam ||
        controller.contentDetailsType == ContentDetailsType.homeWork;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          controller.appTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //======================CLASS INFO==========================
            Text(
              isExam
                  ? controller.homeworkExamModel.title
                  : controller.classModel.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5B71),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isExam
                  ? 'Due Date: ${DateFormat("dd MMM yyyy | hh:mm a").format(controller.homeworkExamModel.endDate.toLocal())}'
                  : 'Live class starting time: ${DateFormat("dd MMM yyyy | hh:mm").format(controller.classModel.endDate.toLocal())}',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            //==========================TEACHER SECTION====================
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    color: AppColors.greyB2,
                    child: CachedImageWidget(
                      imageUrl: isExam
                          ? controller.homeworkExamModel.teacher.image
                          : controller.classModel.teacher.image,
                      iconSize: 30.r,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isExam
                            ? controller.homeworkExamModel.teacher.fullName
                            : controller.classModel.teacher.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryGreen,
                        ),
                      ),
                      Text(
                        DateFormat("dd MMM yyyy | hh:mm a").format(
                          isExam
                              ? controller.homeworkExamModel.endDate.toLocal()
                              : controller.classModel.endDate.toLocal(),
                        ),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade200,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: const Text('Missing', style: TextStyle(color: Colors.grey, fontSize: 12)),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            //==============CHECK ANSWER FOR TEACHER IF EXAM====================
            if (isExam && isTeacher)
              ButtonWidget(
                label: AppStrings.checkAnswer,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.question_answer_rounded,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: () {
                  Get.toNamed(AppRoutes.checkAnswer);
                },
              ),
            //===============SUBMIT ANSWER FOR STUDENT IF EXAM================
            if (isExam && isStudent)
              ButtonWidget(
                label: AppStrings.submitAnswer,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.file_upload_outlined,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: () {
                  //Get.toNamed(AppRoutes.checkAnswer);
                },
              ),
            //===============JOIN CLASS FOR STUDENT IF CLASS  ================
            if (!isExam && isStudent)
              ButtonWidget(
                label: AppStrings.joinClass,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.timer_outlined,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: () {
                  //Get.toNamed(AppRoutes.checkAnswer);
                },
              ),
            //===============START CLASS | TAKE ATTENDANCE FOR TEACHER IF CLASS  ================
            if (!isExam && isTeacher)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 2,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      buttonHeight: 45,
                      label: AppStrings.startClass,
                      gradient: AppColors.primaryButtonGradient,
                      prefixIcon: Icons.timer_outlined,
                      fontSize: 13,
                    ),
                  ),
                  Expanded(
                    child: ButtonWidget(
                      padding: EdgeInsets.zero,
                      buttonHeight: 45,
                      label: AppStrings.attendance,
                      fontSize: 13,
                      prefixIcon: Icons.calendar_today_outlined,
                      prefixIconColor: AppColors.darkGold,
                      prefixIconSize: 18,
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.darkGold,
                      textColor: AppColors.darkGold,
                      borderWidth: 2,
                      iconColor: AppColors.darkGold,
                      onPressed: () {
                        Get.toNamed(AppRoutes.takeAttendance);
                      },
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 15),
            Text(
              AppStrings.hereInPdfHasYourQuestion,
              style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 20),
            //============================QUESTION PDF SECTION========================
            if ((controller.classModel?.documents?.isNotEmpty ?? false) ||
                (controller.homeworkExamModel?.documents?.isNotEmpty ?? false))
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount:
                      (controller.classModel?.documents?.length) ??
                      (controller.homeworkExamModel?.documents?.length),
                  itemBuilder: (context, index) {

                    final documents = controller.classModel?.documents ??
                        controller.homeworkExamModel?.documents;
                    final String pdfUrl = documents?[index] ?? '';

                    return GestureDetector(
                      onTap: (){
                        //TODO: OPEN PDF
                        //pdfUrl
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(Assets.icons.document),
                          title: const Text(
                            'exam.pdf',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('2 MB'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            const Divider(),

            //============================ADD COMMENTS SECTION========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.comment_outlined, size: 20),
                    SizedBox(width: 5),
                    Text(controller.comments.length.toString().padLeft(2, "0")),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    showCommentDialog(
                      title: 'Write a comment',
                      subTitle: 'write your comment here...',
                      controller: controller.commentController,
                      onSubmit: (value) {
                        print("Got the comment: $value");
                      },
                    );
                  },
                  icon: const Icon(Icons.add, size: 20, color: Colors.grey),
                  label: const Text(
                    'Add Comment',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),

            //============================COMMENTS LIST SECTION========================
            Expanded(
              child: ListView.builder(
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final CommentModel comment = controller.comments[index];

                  return CommentTileWidget(comment: comment);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
