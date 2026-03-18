import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/course_details_controller.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/announce_tab.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/classes_tab.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/exam_tab.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/homework_tab.dart';
import 'package:dr_dina_educology/core/widgets/percentage_card.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseDetailsController controller =
      Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    bool isStaff =
        controller.role == Role.teacher || controller.role == Role.assistant;
    bool isStudent = controller.role == Role.student;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const TextWidget(
          text: 'Course Details',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            courseTitle(
              isStaff: isStaff,
              courseName: controller.courseName,
              subject: controller.subject,
              status: controller.status,
            ),
            SizedBox(height: 4),
            if (isStaff)
              Obx(() {
                return stats(
                  attendance: controller.courseStat.value?.attendanceRate ?? 0,
                  homework: controller.courseStat.value?.homeworkRate ?? 0,
                  avgGrade: controller.courseStat.value?.avgGrade ?? 0,
                  overdue: controller.courseStat.value?.overdueRate ?? 0,
                );
              }),
            if (isStaff) SizedBox(height: 10),
            if (isStaff)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ButtonWidget(
                  label: AppStrings.generateReport,
                  buttonHeight: 45,
                  gradient: AppColors.primaryButtonGradient,
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.studentsReport,
                      arguments: controller.courseId,
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            if (isStaff) overviewParticipantButtons(),
            if (isStudent) myProgressParticipantButtons(),
            Expanded(
              child: tabBar(isTeacher: isStaff, isStudent: isStudent),
            ),
          ],
        ),
      ),
    );
  }

  Row courseTitle({
    required bool isStaff,
    required String subject,
    required String courseName,
    required String status,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C5364),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subject,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              if (isStaff)
                Obx(() {
                  return Text(
                    'Total Enrolled Student: ${controller.courseStat.value?.totalEnrolled ?? 0}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
            ],
          ),
        ),
        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFE1F5FE), // Light blue background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Color(0xFF0277BD), // Darker blue text
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  //STATS FOR TEACHER AND ASSISTANT
  Column stats({
    required double attendance,
    required double homework,
    required double avgGrade,
    required double overdue,
  }) {
    return Column(
      spacing: 5,
      children: [
        Row(
          spacing: 5,
          children: [
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.attendance,
                percentage: "${attendance.toSmartString()}%",
                label: AppStrings.attendance,
              ),
            ),
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.homeworkSubmitted,
                percentage: "${homework.toSmartString()}%",
                label: AppStrings.homeworkSubmitted,
              ),
            ),
          ],
        ),
        Row(
          spacing: 5,
          children: [
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.avgGrade,
                percentage: "${avgGrade.toSmartString()}%",
                label: AppStrings.avgGrade,
              ),
            ),
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.overdueTasks,
                percentage: "${overdue.toSmartString()}%",
                label: AppStrings.overdueTasks,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //OVERVIEW | PARTICIPANT BUTTONS FOR TEACHER AND ASSISTANT
  Row overviewParticipantButtons() {
    return Row(
      spacing: 2,
      children: [
        Expanded(
          child: ButtonWidget(
            fontSize: 14,
            padding: EdgeInsets.all(0),
            label: "Course Overview",
            buttonHeight: 45,
            backgroundColor: AppColors.secondaryDarkBlue,
            prefixIcon: Icons.calendar_today_outlined,
            prefixIconSize: 16,
            onPressed: () {
              Get.toNamed(
                AppRoutes.courseOverview,
                arguments: controller.courseId,
              );
            },
          ),
        ),
        Expanded(
          child: ButtonWidget(
            padding: EdgeInsets.all(0),
            label: AppStrings.participants,
            fontSize: 14,
            buttonHeight: 45,
            backgroundColor: AppColors.white,
            textColor: AppColors.secondaryDarkBlue,
            borderColor: AppColors.secondaryDarkBlue,
            borderWidth: 2,
            prefixIconColor: AppColors.secondaryDarkBlue,
            prefixIcon: Icons.people_outline,
            prefixIconSize: 16,
            onPressed: () {
              Get.toNamed(
                AppRoutes.participants,
                arguments: controller.courseId
              );
            },
          ),
        ),
      ],
    );
  }

  //MY PROGRESS | PARTICIPANT BUTTONS FOR STUDENT
  Row myProgressParticipantButtons() {
    return Row(
      spacing: 2,
      children: [
        Expanded(
          child: ButtonWidget(
            fontSize: 14,
            padding: EdgeInsets.all(0),
            label: AppStrings.myProgress,
            buttonHeight: 45,
            backgroundColor: AppColors.secondaryDarkBlue,
            prefixIcon: Icons.calendar_today_outlined,
            prefixIconSize: 16,
            onPressed: () {
              Get.toNamed(
                  AppRoutes.studentProgress,
                  arguments: {
                    'courseId': controller.courseId,
                    'studentId': controller.studentId
                  }
              );
            },
          ),
        ),
        Expanded(
          child: ButtonWidget(
            padding: EdgeInsets.all(0),
            label: AppStrings.participants,
            fontSize: 14,
            buttonHeight: 45,
            backgroundColor: AppColors.white,
            textColor: AppColors.secondaryDarkBlue,
            borderColor: AppColors.secondaryDarkBlue,
            borderWidth: 2,
            prefixIconColor: AppColors.secondaryDarkBlue,
            prefixIcon: Icons.people_outline,
            prefixIconSize: 16,
            onPressed: () {
              Get.toNamed(
                  AppRoutes.participants,
                  arguments: controller.courseId
              );
            },
          ),
        ),
      ],
    );
  }

  //TAB BAR
  Column tabBar({required bool isTeacher, required bool isStudent}) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          controller: controller.tabController,
          indicatorColor: AppColors.black,
          labelColor: Colors.black,
          unselectedLabelColor: AppColors.grey78,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.black,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: AppStrings.classes),
            Tab(text: "Homework"),
            Tab(text: AppStrings.examination),
            Tab(text: AppStrings.announcement),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              Obx(() {
                return ClassesTab(
                  scrollController: controller.classesScrollController,
                  isMoreLoading: controller.isClassesMoreLoading.value,
                  showAddButton: isTeacher,
                  isLoading: controller.isClassesLoading.value,
                  classes: controller.classes.value,
                  onRefresh: () {
                    controller.getClasses(refresh: true);
                  },
                  onAddClass: () {
                    Get.toNamed(
                      AppRoutes.addContent,
                      arguments: {
                        "contentType": AddContentType.cClass,
                        "courseId": controller.courseId
                      },
                    );
                  },
                );
              }),
              Obx(() {
                return HomeworkTab(
                  scrollController: controller.homeworksScrollController,
                  isMoreLoading: controller.isHomeworkMoreLoading.value,
                  showAddButton: isTeacher,
                  isStudent: isStudent,
                  isLoading: controller.isHomeworkLoading.value,
                  homeworks: controller.homeworks.value,
                  onRefresh: () {
                    controller.getHomeworks();
                  },
                  onAddHomework: () {
                    Get.toNamed(
                      AppRoutes.addContent,
                      arguments: {
                        "contentType": AddContentType.homeWork,
                        "courseId": controller.courseId
                      },
                    );
                  },
                );
              }),
              Obx(() {
                return ExamTab(
                  scrollController: controller.examsScrollController,
                  isMoreLoading: controller.isExamMoreLoading.value,
                  showAddButton: isTeacher,
                  isStudent: isStudent,
                  isLoading: controller.isExamLoading.value,
                  exams: controller.exams.value,
                  onRefresh: () {
                    controller.getExams();
                  },
                  onAddExam: () {
                    Get.toNamed(
                      AppRoutes.addContent,
                      arguments: {
                        "contentType": AddContentType.exam,
                        "courseId": controller.courseId
                      },
                    );
                  },
                );
              }),
              Obx(() {
                return AnnounceTab(
                  scrollController: controller.announcementsScrollController,
                  isMoreLoading: controller.isAnnouncementMoreLoading.value,
                  showAddButton: isTeacher,
                  isLoading: controller.isAnnouncementLoading.value,
                  announcements: controller.announcements.value,
                  onRefresh: () {
                    controller.getAnnouncements();
                  },
                  onAddAnnouncement: () {
                    Get.toNamed(
                      AppRoutes.addContent,
                      arguments: {
                        "contentType": AddContentType.announcement,
                        "courseId": controller.courseId
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
