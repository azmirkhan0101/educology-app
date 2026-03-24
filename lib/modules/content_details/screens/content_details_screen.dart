import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/modules/content_details/controllers/content_details_controller.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/comment_tile_widget.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/copy_link_widget.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/documents_list.dart';
import 'package:dr_dina_educology/modules/content_details/widgets/staff_info_widget.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
              controller.contentDetailsModel.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5B71),
              ),
            ),
            const SizedBox(height: 4),
            //=====================EXAM START TIME==========================
            if (isExam)
              Text(
                'Start date: ${DateFormat("dd MMM yyyy").format(controller.contentDetailsModel.startDate.toLocal())} | ${controller.contentDetailsModel.startTime}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            //======================EXAM END TIME===========================
            if (isExam)
              Text(
                'Due Date: ${DateFormat("dd MMM yyyy").format(controller.contentDetailsModel.endDate!.toLocal())} | ${controller.contentDetailsModel.endTime}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            //====================CLASS START TIME============================
            if (!isExam)
              Text(
                'Live class starting time: ${DateFormat("dd MMM yyyy").format(controller.contentDetailsModel.startDate.toLocal())} | ${controller.contentDetailsModel.startTime}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            //======================CLASS LINK==============================
            if (!isExam)
              CopyLinkWidget(
                classLink: controller.contentDetailsModel.classLink!,
              ),
            const SizedBox(height: 12),
            //==========================TEACHER SECTION====================
            StaffInfoWidget(
                staff: controller.contentDetailsModel.teacher,
                createdAt: controller.contentDetailsModel.createdAt
            ),
            const SizedBox(height: 20),
            //==============CHECK ANSWER FOR TEACHER IF EXAM================
            if (isExam && isTeacher)
              ButtonWidget(
                label: AppStrings.checkAnswer,
                gradient: AppColors.primaryButtonGradient,
                prefixIcon: Icons.question_answer_rounded,
                fontSize: 14,
                buttonHeight: 45,
                onPressed: () {
                  Get.toNamed(
                      AppRoutes.checkAnswer,
                      arguments: {
                        "taskId" : controller.contentDetailsModel.contentId,
                        "isExam" : controller.contentDetailsType == ContentDetailsType.exam
                      }
                  );
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
                  print("Course id: ${controller.contentDetailsModel.courseId}");
                  print("Task id: ${controller.contentDetailsModel.contentId}");
                  Get.toNamed(
                      AppRoutes.submitAnswer,
                    arguments: {
                        "taskId" : controller.contentDetailsModel.contentId,
                      "courseId" : controller.contentDetailsModel.courseId
                    }
                  );
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
                  if( controller.contentDetailsModel.classLink != null ) {
                    controller.openLinkInBrowser(classLink: controller.contentDetailsModel.classLink! );
                  }
                },
              ),
            //===============START CLASS | TAKE ATTENDANCE FOR TEACHER IF CLASS================
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
                      onPressed: (){
                        if( controller.contentDetailsModel.classLink != null ) {
                          controller.openLinkInBrowser(classLink: controller.contentDetailsModel.classLink! );
                        }
                      },
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
                        Get.toNamed(
                            AppRoutes.takeAttendance,
                            arguments: {
                              "courseId" : controller.contentDetailsModel.courseId,
                              "classId" : controller.contentDetailsModel.contentId
                            }
                        );
                      },
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 15),
            Html(
              data: controller.contentDetailsModel.details,
              style: {
                "body": Style(
                  fontSize: FontSize(14),
                  lineHeight: const LineHeight(1.6),
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                "h1": Style(fontSize: FontSize(22)),
                "h2": Style(fontSize: FontSize(18)),
              },
            ),
            const SizedBox(height: 20),
            //========================QUESTION PDF SECTION========================
            if (controller.contentDetailsModel.documents.isNotEmpty)
              Obx((){
                return DocumentsList(
                  documents: controller.documents.value,
                );
              }),
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
                    Obx((){
                      return Text(
                        controller.comments.value.length
                            .toString()
                            .padLeft(2, "0"),
                      );
                    })
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    showCommentDialog(
                      title: 'Write a comment',
                      subTitle: 'write your comment here...',
                      controller: controller.commentController,
                      onSubmit: (value) {
                        controller.postComment(comment: value);
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
              child: Obx((){
                return ListView.builder(
                  itemCount: controller.comments.value.length,
                  itemBuilder: (context, index) {
                    final CommentModel comment =
                    controller.comments.value[index];

                    return CommentTileWidget(
                      comment: comment,
                      onReply: () {
                        showCommentDialog(
                            title: 'Write a reply',
                            subTitle: 'write your reply here...',
                            controller: controller.commentController,
                            onSubmit: (value) {
                              controller.postReply(
                                commentIndex: index,
                                reply: value,
                              );
                            }
                        );
                      },
                    );
                  },
                );
              })
            ),
          ],
        ),
      ),
    );
  }
}
