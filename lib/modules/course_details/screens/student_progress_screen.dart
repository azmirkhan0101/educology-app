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

  final CourseDetailsController controller = Get.isRegistered<CourseDetailsController>()
      ?
  Get.find<CourseDetailsController>()
  :
      Get.put<CourseDetailsController>(CourseDetailsController());

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
        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                imageUrl: Dummy.profileImageUrl,
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
                imageUrl: Dummy.profileImageUrl,
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

  //STATS
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

  //ATTENDANCE | EXAM BUTTONS
  Row attendanceExamButtons() {
    return Row(
      spacing: 2,
      children: [
        Expanded(
          child: ButtonWidget(
            fontSize: 14,
            padding: EdgeInsets.all(0),
            label: AppStrings.viewAttendance,
            buttonHeight: 45,
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
            fontSize: 14,
            buttonHeight: 45,
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
