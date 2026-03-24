import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/api_endpoints.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/data/models/home/course_model.dart';
import 'package:dr_dina_educology/modules/home/controllers/home_controller.dart';
import 'package:dr_dina_educology/modules/home/widgets/children_dropdown.dart';
import 'package:dr_dina_educology/modules/home/widgets/course_item_widget.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_banner.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_header_widget.dart';
import 'package:dr_dina_educology/modules/home/widgets/learning_journey_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    bool isStaff =
        controller.role == Role.teacher || controller.role == Role.assistant;
    bool isStudent = controller.role == Role.student;
    bool isParent = controller.role == Role.parent;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshHome();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: Column(
              children: [
                SizedBox(height: 22),
                Obx((){
                  return HomeHeaderWidget(
                      profileImageUrl: controller.profileController.profileImageUrl.value,
                      userName: controller.profileController.profileModel.value?.fullName ?? ""
                  );
                }),
                SizedBox(height: 20),
                HomeBanner(isParent: isParent),
                SizedBox(height: 20),
                //====================YOUR CHILD FOR PARENT====================
                if (isParent)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: AppStrings.yourChild,
                      textAlignment: TextAlign.left,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.secondaryDarkBlue,
                    ),
                  ),
                //===================CHILD DROPDOWN FOR PARENT=================
                if (isParent)
                  Obx((){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ChildrenDropdown(
                          children: controller.children.value,
                          selectedChild: controller.selectedChild.value,
                          onItemSelected: (child){
                            controller.selectedChild.value = child;
                            controller.refreshChildCourses();
                          }
                      ),
                    );
                  }),
                //===================COURSE COUNTS FOR STAFF===================
                if (isStaff)
                  Obx(() {
                    return teacherCourseCount(
                      totalCourse: controller.staffCourseStats.value?.totalCourses ?? 0,
                      totalStudents: controller.staffCourseStats.value?.totalStudents ?? 0
                    );
                  },
                  ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: isStaff
                        ? AppStrings.myAssignCourses
                        : isStudent
                        ? "My Courses"
                        : "Enrolled Courses",
                    textAlignment: TextAlign.left,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.secondaryDarkBlue,
                  ),
                ),
                SizedBox(height: 10),
                //=======================COURSES==========================
                Obx(() {
                  if (controller.isCoursesLoading.value) {
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryGold,));
                  }
                  if (controller.courses.isEmpty) {
                    if (controller.role == Role.student) {
                      return LearningJourneyWidget();
                    } else {
                      return Center(child: Text("No Courses Found"));
                    }
                  }
                  return ListView.builder(
                    controller: controller.coursesScrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.courses.length,
                    itemBuilder: (context, index) {
                      final CourseModel model =
                          controller.courses[index];

                      return CourseItemWidget(
                        title: model.className,
                        imageUrl: model.imageUrl,
                        subject: model.subjectName,
                        status: model.status,
                        isStaff: isStaff,
                        teacherName: model.teacher.fullName,
                        enrolledCount: model.totalEnrolled,
                        onClick: () {
                          if (isParent) {
                            Get.toNamed(
                                AppRoutes.studentProgress,
                                arguments: {
                                  'courseId': model.id,
                                  'studentId': controller.selectedChild.value?.id ?? ""
                                }
                            );
                          } else {
                            Map<String, String> arguments = {
                              "courseId": model.id,
                              "courseName": model.className,
                              "subject": model.subjectName,
                              "status": model.status,
                              "studentId": isStudent ? controller.profileController.profileModel.value?.id ?? "" : ""
                            };
                            Get.toNamed(
                                AppRoutes.courseDetails,
                                arguments: arguments
                            );
                          }
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //FOR TEACHER AND ASSISTANT
  Row teacherCourseCount({required int totalCourse, required int totalStudents}) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: [
                  AppColors.secondaryGreen.withValues(alpha: 0.2),
                  AppColors.white.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.secondaryGreen, width: 1),
            ),
            child: Column(
              children: [
                TextWidget(
                  text: totalCourse.toString(),
                  fontColor: AppColors.darkGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
                TextWidget(
                  text: AppStrings.totalCourses,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.grey4E,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: [
                  AppColors.secondaryGreen.withValues(alpha: 0.2),
                  AppColors.white.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.secondaryGreen, width: 1),
            ),
            child: Column(
              children: [
                TextWidget(
                  text: totalStudents.toString(),
                  fontColor: AppColors.darkGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
                TextWidget(
                  text: AppStrings.totalStudents,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.grey4E,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
