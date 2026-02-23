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
import 'package:dr_dina_educology/modules/course_details/widgets/participant_list_item.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class StudentProgressScreen extends StatelessWidget {
  final RoleService roleService = Get.find<RoleService>();
  final CourseDetailsController controller =
  Get.find<CourseDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const TextWidget(
          text: AppStrings.studentProgress,
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Student',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ParticipantListItem(
                name: "Azmir Khan",
                phoneNumber: "01909352422",
                imageUrl: "",
                status: StudentStatus.onTrack,
               showDivider: false,
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Parent',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ParticipantListItem(
                name: "Azmir Khan",
                phoneNumber: "01909352422",
                imageUrl: "",
                status: null,
              showDivider: false,
            ),
            SizedBox(height: 20),
            stats(),
            SizedBox(height: 10),
            SizedBox(height: 10),
            TextWidget(text: "Attendance (3) and Home-work (4) are missing.",
            fontColor: AppColors.errorRed,
              fontSize: 14,
            ),
            SizedBox(height: 18,),
            attendanceExamButtons(),
          ],
        ),
      ),
    );
  }

  //FOR TEACHER AND ASSISTANT
  Row courseTitle() {
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
              if (roleService.role == Role.teacher ||
                  roleService.role == Role.assistant)
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
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
  Row attendanceExamButtons() {
    return Row(
      spacing: 2,
      children: [
        Expanded(
          child: ButtonWidget(
            fontSize: 15,
            padding: EdgeInsets.all(0),
            label: AppStrings.viewAttendance,
            buttonHeight: 50,
            gradient: AppColors.primaryButtonGradient,
            prefixIcon: Icons.calendar_today_outlined,
            prefixIconSize: 16,
            onPressed: (){
              Get.toNamed(AppRoutes.singleAttendance);
            },
          ),
        ),
        Expanded(
          child: ButtonWidget(
            padding: EdgeInsets.all(0),
            label: AppStrings.viewExams,
            fontSize: 15,
            buttonHeight: 50,
            backgroundColor: AppColors.white,
            textColor: AppColors.darkGold,
            borderColor: AppColors.darkGold,
            borderWidth: 2,
            prefixIconColor: AppColors.darkGold,
            prefixIcon: Icons.people_outline,
            prefixIconSize: 16,
            onPressed: (){
              Get.toNamed(AppRoutes.viewAllExams);
            },
          ),
        ),
      ],
    );
  }
}
