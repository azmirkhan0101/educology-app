import 'package:dr_dina_educology/core/services/role_service.dart';
import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/core/widgets/text_widget.dart';
import 'package:dr_dina_educology/modules/home/widgets/course_item_widget.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_banner.dart';
import 'package:dr_dina_educology/modules/home/widgets/home_header_widget.dart';
import 'package:dr_dina_educology/modules/home/widgets/learning_journey_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {

  final RoleService roleService = Get.find<RoleService>();
  late Role role;

  @override
  Widget build(BuildContext context) {

    role = roleService.getUpdatedRole();
    bool isTeacher = role == Role.teacher || role == Role.assistant;
    bool isStudent = role == Role.student;
    bool isParent = role == Role.parents;

    print(role.name);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
          child: Column(
            children: [
              SizedBox(height: 22,),
              HomeHeaderWidget(
                  profileImageUrl: "",
                  userName: "Azmir Khan"
              ),
              SizedBox(height: 20,),
              HomeBanner(isParent: isParent,),
              SizedBox(height: 20,),
              if( isParent )
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
              if( isParent )
                childDropdownWidget(
                    selectedValue: "Rakibul Hasan",
                    onChanged: (value){},
                ),
              if( isTeacher )
                teacherCourseCount(),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    text: isTeacher ? AppStrings.myAssignCourses : isStudent ? "My Courses" : "Enrolled Classes",
                  textAlignment: TextAlign.left,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.secondaryDarkBlue,
                ),
              ),
              SizedBox(height: 10,),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CourseItemWidget(
                      imageUrl: "",
                      title: "Grade 10 – Mathematicsssssssssssssssssssssss",
                      category: "Mathematics",
                      status: "Active",
                      isTeacher: isTeacher,
                      enrolledCount: 12,
                    onClick: (){
                        if( isParent ){
                          Get.toNamed(AppRoutes.studentProgress);
                        }else{
                          Get.toNamed(AppRoutes.courseDetails);
                        }
                    },
                  ),
                  CourseItemWidget(
                      imageUrl: "",
                      title: "Grade 10 – Mathematicsssssssssssssssssssssss",
                      category: "Mathematics",
                      status: "Active",
                    isTeacher: isTeacher,
                      enrolledCount: 12,
                    onClick: (){
                      if( isParent ){
                        Get.toNamed(AppRoutes.studentProgress);
                      }else{
                        Get.toNamed(AppRoutes.courseDetails);
                      }
                    },
                  ),
                  CourseItemWidget(
                      imageUrl: "",
                      title: "Grade 10 – Mathematicsssssssssssssssssssssss",
                      category: "Mathematics",
                      status: "Active",
                    isTeacher: isTeacher,
                      enrolledCount: 12,
                    onClick: (){
                      if( isParent ){
                        Get.toNamed(AppRoutes.studentProgress);
                      }else{
                        Get.toNamed(AppRoutes.courseDetails);
                      }
                    },
                  ),
                  CourseItemWidget(
                      imageUrl: "",
                      title: "Grade 10 – Mathematicsssssssssssssssssssssss",
                      category: "Mathematics",
                      status: "Active",
                    isTeacher: isTeacher,
                      enrolledCount: 12,
                    onClick: (){
                      if( isParent ){
                        Get.toNamed(AppRoutes.studentProgress);
                      }else{
                        Get.toNamed(AppRoutes.courseDetails);
                      }
                    },
                  )
                ],
              ),
              if( role == Role.student )
                LearningJourneyWidget()
            ],
          ),
        ),
      ),
    );
  }

  //FOR TEACHER AND ASSISTANT
  Row teacherCourseCount(){
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
                    ]),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondaryGreen,
                  width: 1,
                )
            ),
            child: Column(
              children: [
                TextWidget(
                  text: "12",
                  fontColor: AppColors.darkGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
                TextWidget(text: AppStrings.totalCourses,
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
                    ]),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondaryGreen,
                  width: 1,
                )
            ),
            child: Column(
              children: [
                TextWidget(
                  text: "360",
                  fontColor: AppColors.darkGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
                TextWidget(text: AppStrings.totalStudents,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.grey4E,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget childDropdownWidget({
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15), // Soft shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
          // This acts as the default "Rakibul Hasan" view from your image
          hint: profileRow("Rakibul Hasan", "+8801827347685"),
          onChanged: onChanged,
          items: [
            dropdownItem("Rakibul Hasan", "+8801827347685"),
            dropdownItem("Jasmine Akter", "+8801700000000"),
            dropdownItem("Tanvir Ahmed", "+8801900000000"),
          ],
        ),
      ),
    );
  }

// Helper: Creates the actual selectable menu item
  DropdownMenuItem<String> dropdownItem(String name, String phone) {
    return DropdownMenuItem<String>(
      value: name,
      child: profileRow(name, phone),
    );
  }

  Widget profileRow(String name, String phone) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=12'),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF6B9080),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              phone,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

