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

class CourseDetailsScreen extends StatelessWidget {
  final RoleService roleService = Get.find<RoleService>();
  final CourseDetailsController controller =
      Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {

    Role role = roleService.getUpdatedRole();
    bool isTeacher = role == Role.teacher || role == Role.assistant;
    bool isStudent = role == Role.student;

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
            courseTitle(isTeacher: isTeacher),
            SizedBox(height: 4),
            if( isTeacher )
            stats(),
            if( isTeacher )
            SizedBox(height: 10),
            if( isTeacher )
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ButtonWidget(
                label: AppStrings.generateReport,
                buttonHeight: 45,
                gradient: AppColors.primaryButtonGradient,
                onPressed: (){
                  Get.toNamed(AppRoutes.studentsReport);
                },
              ),
            ),
            SizedBox(height: 10),
            if( isTeacher )
            overviewParticipantButtons(),
            if( isStudent )
              myProgressParticipantButtons(),
            Expanded(
                child: tabBar(isTeacher: isTeacher)
            )
          ],
        ),
      ),
    );
  }

  Row courseTitle({required bool isTeacher}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Grade 10 - Mathematics",
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
                "category",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              if ( isTeacher )
                Text(
                  'Total Enrolled Student ',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
            "Active",
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
  Column stats() {
    return Column(
      spacing: 5,
      children: [
        Row(
          spacing: 5,
          children: [
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.attendance,
                percentage: "90%",
                label: AppStrings.attendance,
              ),
            ),
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.homeworkSubmitted,
                percentage: "90%",
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
                percentage: "71%",
                label: AppStrings.avgGrade,
              ),
            ),
            Expanded(
              child: PercentageCard(
                svgPath: Assets.icons.overdueTasks,
                percentage: "12%",
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
            label: AppStrings.classOverview,
            buttonHeight: 45,
            backgroundColor: AppColors.secondaryDarkBlue,
            prefixIcon: Icons.calendar_today_outlined,
            prefixIconSize: 16,
            onPressed: (){
              Get.toNamed(AppRoutes.classOverview);
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
            onPressed: (){
              Get.toNamed(AppRoutes.participants);
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
            onPressed: (){
              Get.toNamed(AppRoutes.studentProgress);
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
            onPressed: (){
              Get.toNamed(AppRoutes.participants);
            },
          ),
        ),
      ],
    );
  }

  //TAB BAR
  tabBar({required bool isTeacher}) {
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
              ClassesTab(showAddButton: isTeacher,),
              HomeworkTab(showAddButton: isTeacher,),
              ExamTab(showAddButton: isTeacher,),
              AnnounceTab(showAddButton: isTeacher,)
            ],
          ),
        ),
      ],
    );
  }
}
