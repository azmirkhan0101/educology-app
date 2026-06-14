import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/utils/extensions.dart';
import 'package:dr_dina_educology/core/widgets/button_widget.dart';
import 'package:dr_dina_educology/core/widgets/percentage_card.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/student_progress_controller.dart';
import 'package:dr_dina_educology/modules/course_details/widgets/participant_list_item.dart';
import 'package:dr_dina_educology/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets_gen/assets.gen.dart';

class StudentProgressScreen extends StatelessWidget {
  StudentProgressScreen({super.key});

  final StudentProgressController controller = Get.find<StudentProgressController>();

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: TextWidget(
          text: AppStrings.studentProgress,
          fontSize: isTab ? 12.sp : 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_sharp, size: isTab ? 30 : null,),
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
                'Learner',
                style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Obx((){
              return ParticipantListItem(
                name: controller.studentModel.value?.fullName ?? "",
                phoneNumber: controller.studentModel.value?.contact ?? "",
                imageUrl: controller.studentModel.value?.image ?? "",
                studentStatus: controller.studentProgress.value?.status,
                showDivider: false,
              );
            }),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Supervisor',
                style: TextStyle(fontSize: isTab ? 10.sp : 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Obx((){
              return ParticipantListItem(
                name: controller.parentModel.value?.fullName ?? "",
                phoneNumber: controller.parentModel.value?.contact ?? "",
                imageUrl: controller.parentModel.value?.image ?? "",
                studentStatus: null,
                showDivider: false,
              );
            }),
            SizedBox(height: 20),
            Obx((){
              return stats(
                  attendance: controller.studentProgress.value?.attendance ?? 0,
                  homework: controller.studentProgress.value?.homework ?? 0,
                  avgGrade: controller.studentProgress.value?.avgGrade ?? 0,
                  overdue: controller.studentProgress.value?.overdue ?? 0
              );
            }),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Obx((){
              return TextWidget(
                text: controller.alertMessage.value,
                fontColor: AppColors.errorRed,
                fontSize: isTab ? 9.sp : 14,
              );
            }),
            SizedBox(height: 18,),
            attendanceExamButtons(isTab),
          ],
        ),
      ),
    );
  }

  //STATS
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

  //ATTENDANCE | EXAM BUTTONS
  Row attendanceExamButtons(bool isTab) {
    return Row(
      spacing: isTab ? 40 : 2,
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
              Get.toNamed(
                  AppRoutes.singleAttendance,
                  arguments: {
                "courseId": controller.courseId,
                "studentId": controller.studentId
              });
            },
          ),
        ),
        Expanded(
          child: ButtonWidget(
            padding: EdgeInsets.all(0),
            label: "View Marks",
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
              Get.toNamed(
                  AppRoutes.viewAllMarks,
                  arguments: {
                "courseId": controller.courseId,
                "studentId": controller.studentId
              });
            },
          ),
        ),
      ],
    );
  }
}
