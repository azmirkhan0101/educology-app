import 'package:dr_dina_educology/core/utils/app_colors.dart';
import 'package:dr_dina_educology/core/utils/app_constants.dart';
import 'package:dr_dina_educology/core/utils/app_strings.dart';
import 'package:dr_dina_educology/modules/course_details/controllers/view_marks_controller.dart';
import 'package:dr_dina_educology/modules/teacher/widgets/view_exam_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllMarksScreen extends StatelessWidget {
  ViewAllMarksScreen({super.key});

  final ViewMarksController controller = Get.find<ViewMarksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text("View All Marks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                ),
                ViewExamItemWidget(
                    title: "Exam 1",
                    deadline: "10 Mar 2026 | 12 PM",
                    marksObtained: 95,
                    totalMarks: 100,
                    feedback: "Very good",
                    instructorName: "Azmir Khan",
                    date: "20 Feb 2026",
                    imageUrl: Dummy.profileImageUrl,
                    onViewAnswer: (){

                    }
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
